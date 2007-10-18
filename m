Return-Path: <b04825@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2A502DDF4B
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 01:08:37 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l9IF8TPp011907
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 08:08:29 -0700 (MST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: qe: add ability to upload QE firmware
Date: Thu, 18 Oct 2007 10:08:25 -0500
Message-Id: <11927201051427-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Define the layout of a binary blob that contains a QE firmware and instructions
on how to upload it.  Add function qe_upload_microcode() to parse the blob
and perform the actual upload.  Fully define 'struct rsp' in immap_qe.h to
include the actual RISC Special Registers.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch applies on top of my previous patches
"qe: add function qe_clock_source" and
"ucc_geth: use rx-clock-name and tx-clock-name device tree properties".

This patch defines a new specification for a QE binary file.  Please review
the specification as well as the code.

 arch/powerpc/sysdev/qe_lib/qe.c |   96 +++++++++++++++++++++++++++++
 include/asm-powerpc/immap_qe.h  |   29 ++++++++-
 include/asm-powerpc/qe.h        |  128 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 251 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index 8551e74..7ca398c 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
+#include <linux/crc32.h>
 #include <asm/irq.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -393,3 +394,98 @@ void *qe_muram_addr(unsigned long offset)
 	return (void *)&qe_immr->muram[offset];
 }
 EXPORT_SYMBOL(qe_muram_addr);
+
+/*
+ * Download a microcode to the I-RAM at a specific address.
+ *
+ * @firmware: pointer to qe_firmware structure
+ */
+int qe_upload_microcode(const struct qe_firmware *firmware)
+{
+	unsigned int i;
+	unsigned int j;
+	__be32 *code;
+	u32 crc;
+	size_t length = sizeof(struct qe_firmware);
+
+	/* Check the magic and version number */
+	if ((firmware->magic[0] != 'Q') || (firmware->magic[1] != 'E') ||
+	    (firmware->magic[2] != 'F') || (firmware->version != 1)) {
+		printk(KERN_ERR "QE: invalid or unsupported microcode\n");
+		return -EPERM;
+	}
+
+	/* Validate the length and check if there's a CRC */
+	for (i = 0; i < firmware->count; i++)
+		length += firmware->microcode[i].count * 4;
+
+	if (firmware->length == (length + sizeof(u32))) {
+		/* Length is valid, and there's a CRC */
+		crc = be32_to_cpu(*((__be32 *) ((void *) firmware + length)));
+		if (crc != crc32(0, firmware, length)) {
+			printk(KERN_ERR "QE: firmware CRC is invalid\n");
+			return -EIO;
+		}
+	} else if (firmware->length != length) {
+		printk(KERN_ERR "QE: invalid length(s) in firware structure\n");
+		return -EPERM;
+	}
+
+	/* If there's only one microcode, then we assume it's common for all
+	   RISCs, so we set the CERCR.CIR bit to share the IRAM with all RISCs.
+	   This should be safe even on SOCs with only one RISC.
+
+	   If there are multiple 'microcode' structures, but each one points
+	   to the same microcode binary (ignoring offsets), then we also assume
+	   that we want share RAM.
+	 */
+	if (firmware->count == 1)
+	      setbits16(&qe_immr->cp.cercr, cpu_to_be16(0x800));
+	else {
+		for (i = 1; i < firmware->count; i++)
+			if (firmware->microcode[i].code_offset !=
+			    firmware->microcode[0].code_offset)
+				break;
+
+		if (i == firmware->count)
+			setbits16(&qe_immr->cp.cercr, cpu_to_be16(0x800));
+	}
+
+	if (firmware->soc.model)
+		printk(KERN_INFO "QE: uploading microcode '%s' for %u V%u.%u\n",
+			firmware->id, be16_to_cpu(firmware->soc.model),
+			firmware->soc.rev_h, firmware->soc.rev_l);
+	else
+		printk(KERN_INFO "QE: uploading microcode '%s'\n",
+			firmware->id);
+
+	for (i = 0; i < firmware->count; i++) {
+		const struct qe_microcode *ucode = &firmware->microcode[i];
+
+		code = (void *) firmware + be32_to_cpu(ucode->code_offset);
+
+		/* Use auto-increment */
+		out_be32(&qe_immr->iram.iadd, cpu_to_be32(0x80080000 |
+			be32_to_cpu(ucode->iram_offset)));
+
+		for (j = 0; j < ucode->count; j++)
+			out_be32(&qe_immr->iram.idata, be32_to_cpu(code[j]));
+
+		/* Program the traps.  We program both RISCs, even on platforms
+		   that only have one.  This *should* be safe. */
+		for (j = 0; j < 16; j++)
+			if (ucode->traps[j]) {
+				u32 trap = be32_to_cpu(ucode->traps[j]);
+				out_be32(&qe_immr->rsp[0].tibcr[j], trap);
+				out_be32(&qe_immr->rsp[1].tibcr[j], trap);
+			}
+	}
+
+	/* Enable the traps for both RISCs.  Again, on a single-RISC system,
+	   this should be safe. */
+	out_be32(&qe_immr->rsp[0].eccr, cpu_to_be32(0x20800000));
+	out_be32(&qe_immr->rsp[1].eccr, cpu_to_be32(0x20800000));
+
+	return 0;
+}
+EXPORT_SYMBOL(qe_upload_microcode);
diff --git a/include/asm-powerpc/immap_qe.h b/include/asm-powerpc/immap_qe.h
index aba9806..d0c60c4 100644
--- a/include/asm-powerpc/immap_qe.h
+++ b/include/asm-powerpc/immap_qe.h
@@ -395,8 +395,33 @@ struct dbg {
 
 /* RISC Special Registers (Trap and Breakpoint) */
 struct rsp {
-	u32	reg[0x40];	/* 64 32-bit registers */
-} __attribute__ ((packed));
+	__be32 tibcr[16];
+	u8 res0[64];
+	__be32 ibcr0;
+	__be32 ibs0;
+	__be32 ibcnr0;
+	u8 res1[4];
+	__be32 ibcr1;
+	__be32 ibs1;
+	__be32 ibcnr1;
+	__be32 npcr;
+	__be32 dbcr;
+	__be32 dbar;
+	__be32 dbamr;
+	__be32 dbsr;
+	__be32 dbcnr;
+	u8 res2[12];
+	__be32 dbdr_h;
+	__be32 dbdr_l;
+	__be32 dbdmr_h;
+	__be32 dbdmr_l;
+	__be32 bsr;
+	__be32 bor;
+	u8 res3[24];
+	__be32 eccr;
+	__be32 eicr;
+	u8 res4[0x100-0xf8];
+};
 
 struct qe_immap {
 	struct qe_iram		iram;		/* I-RAM */
diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
index 81403ee..f773280 100644
--- a/include/asm-powerpc/qe.h
+++ b/include/asm-powerpc/qe.h
@@ -94,6 +94,134 @@ unsigned long qe_muram_alloc_fixed(unsigned long offset, int size);
 void qe_muram_dump(void);
 void *qe_muram_addr(unsigned long offset);
 
+/* Structure that defines QE firmware binary files.
+ *
+ * All integers are big-endian.  All lengths are in bytes.
+ *
+ * The 'length' field is the size, in bytes, of the entire structure,
+ * including all the microcode embedded in it, as well as the CRC (if
+ * present).
+ *
+ * The 'magic' field is an array of three bytes that contains the letters
+ * 'Q', 'E', and 'F'.  This is an identifier that indicates that this
+ * structure is a QE Firmware structure.
+ *
+ * The 'version' field is a single byte that indicates the version of this
+ * structure.  If the layout of the structure should ever need to be changed
+ * to add support for additional types of microcode, then the version number
+ * should also be changed.  Currently, only version 1 (this version) is
+ * supported, so this field must be set to 1.
+ *
+ * The 'id' field is a null-terminated string suitable for printing.
+ *
+ * The 'count' field indicates the number of 'microcode' structures.  If
+ * there are multiple RISC processors, then it's possible to have a
+ * different microcode for each one.  This allows for three possible
+ * scenarios:
+ *
+ *      1) Single microcode common to all RISCs
+ *      2) Single microcode copied to multiple offsets, one per RISC
+ *      3) Different microcode and traps for each RISC
+ *
+ * In scenarious (1) and (2), the CERCR.CIR bit is set to 1, which allows
+ * all of IRAM to be shared among all RISC processors.
+ *
+ * The 'soc' structure contains the SOC numbers and revisions used to match
+ * the microcode to the SOC itself.  Normally, the microcode loader should
+ * check the data in this structure with the SOC number and revisions, and
+ * only upload the microcode if there's a match.  However, because there is
+ * no generic way to obtain the SOC model and revision, this check is not
+ * currently made.
+ *
+ * Although it is not recommended, you can specify '0' in the soc.model
+ * field to skip matching SOCs altogether.
+ *
+ * The 'model' field is a 16-bit number that matches the actual SOC. The
+ * 'rev_h' and 'rev_l' fields match the high and low bytes of the SOC
+ * revision ID.
+ *
+ * For example, to match the 8323, revision 1.0:
+ *      soc.model = 8323
+ *      soc.rev_h = 1
+ *      soc.rev_h = 0
+ *
+ * 'reserved' is neccessary for structure alignment.  This field ensures
+ * that the first element of the 'microcode' array is aligned on a 64-bit
+ * boundary.
+ *
+ * 'microcode' (type: struct qe_microcode):
+ *      'traps' is an array of 16 words that contain hardware trap values
+ *      for each of the 16 traps.  If trap[i] is 0, then this particular
+ *      trap is to be ignored (i.e. not written to TIBCR[i]).
+ *
+ *      'vtraps' is an array of 8 words that contain virtual trap values for
+ *      each virtual traps.  Currently, this field is ignored.
+ *
+ *      'extended_modes' is a bitfield that defines special functionality
+ *      which has an impact on the software drivers.  Each bit has its own
+ *      impact and has special instructions for the driver associated with
+ *      it.  Currently, this field is ignored.
+ *
+ *      'iram_offset' is the offset into IRAM to start writing the
+ *      microcode.
+ *
+ *      'count' is the number of 32-bit words in the microcode.
+ *
+ *      'code_offset' is the offset, in bytes, from the beginning of this
+ *      structure where the microcode itself can be found.  The first
+ *      microcode binary should be located immediately after the 'microcode'
+ *      array.
+ *
+ *      'reserved' is necessary for structure alignment.  Since 'microcode'
+ *      is an array, the 64-bit 'extended_modes' field needs to be aligned
+ *      on a 64-bit boundary, and this can only happen if the size of
+ *      'microcode' is a multiple of 8 bytes.  To ensure that, we add
+ *      'reserved'.
+ *
+ * In addition, an optional 32-bit CRC can be added after the last
+ * microcode binary.  The CRC is checked via the crc32() Linux kernel macro.
+ * It can be calculated using this algorithm:
+ *
+ * u32 crc32(const u8 *p, unsigned int len)
+ * {
+ *         unsigned int i;
+ *         u32 crc = 0;
+ *
+ *         while (len--) {
+ *      	   crc ^= *p++;
+ *      	   for (i = 0; i < 8; i++)
+ *      		   crc = (crc >> 1) ^ ((crc & 1) ? 0xedb88320 : 0);
+ *         }
+ *         return crc;
+ * }
+ */
+struct qe_firmware {
+	__be32 length;  /* Length of the entire structure, in bytes */
+	u8 magic[3];    /* Set to { 'Q', 'E', 'F' } */
+	u8 version;     /* Version of this layout. First ver is '1' */
+	u8 id[63];      /* Null-terminated identifier string */
+	u8 count;       /* Number of microcode[] structures */
+	struct {
+		__be16 model;   	/* The SOC model  */
+		u8 rev_h;       	/* The SOC revision */
+		u8 rev_l;       	/* The SOC revision */
+	} soc;
+	__be32 reserved;		/* Reserved, for alignement */
+	struct qe_microcode {
+		__be32 traps[16];       /* Trap addresses, 0 == ignore */
+		__be32 vtraps[8];       /* Virtual trap addresses */
+		__be64 extended_modes;  /* Extended modes */
+		__be32 iram_offset;     /* Offset into I-RAM for the code */
+		__be32 count;   	/* Number of 32-bit words of the code */
+		__be32 code_offset;     /* Offset of the actual microcode */
+		__be32 reserved;	/* Reserved, for alignement */
+	} microcode[1]; 		/* At least one microcode */
+	/* All microcode binaries should be located here */
+	/* An optional CRC32 can be added after the microcode binaries here */
+} __attribute__ ((packed));
+
+int qe_upload_microcode(const struct qe_firmware *firmware);
+
 /* Buffer descriptors */
 struct qe_bd {
 	__be16 status;
-- 
1.5.2.4
