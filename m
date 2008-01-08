Return-Path: <b04825@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2C4BBDE00C
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 03:31:52 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au
Subject: [PATCH v7] qe: add ability to upload QE firmware
Date: Tue,  8 Jan 2008 10:30:58 -0600
Message-Id: <11998098582795-git-send-email-timur@freescale.com>
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
on how to upload it.  Add function qe_upload_firmware() to parse the blob
and perform the actual upload.  Fully define 'struct rsp' in immap_qe.h to
include the actual RISC Special Registers.  Added description of a new
QE firmware node to booting-without-of.txt.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

Updated w.r.t. comments from Stephen R.

This patch is for Kumar's for-2.6.25 branch.  This code is necessary for
my QE UART driver.

 Documentation/powerpc/00-INDEX               |    3 +
 Documentation/powerpc/booting-without-of.txt |   33 +++-
 Documentation/powerpc/qe_firmware.txt        |  295 ++++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig               |    1 +
 arch/powerpc/sysdev/qe_lib/qe.c              |  247 +++++++++++++++++++++
 include/asm-powerpc/immap_qe.h               |   34 +++-
 include/asm-powerpc/qe.h                     |   61 ++++++
 7 files changed, 670 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/powerpc/qe_firmware.txt

diff --git a/Documentation/powerpc/00-INDEX b/Documentation/powerpc/00-INDEX
index 94a3c57..3be84aa 100644
--- a/Documentation/powerpc/00-INDEX
+++ b/Documentation/powerpc/00-INDEX
@@ -28,3 +28,6 @@ sound.txt
 	- info on sound support under Linux/PPC
 zImage_layout.txt
 	- info on the kernel images for Linux/PPC
+qe_firmware.txt
+	- describes the layout of firmware binaries for the Freescale QUICC
+	  Engine and the code that parses and uploads the microcode therein.
diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index ee0209a..53c2295 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -52,7 +52,10 @@ Table of Contents
       i) Freescale QUICC Engine module (QE)
       j) CFI or JEDEC memory-mapped NOR flash
       k) Global Utilities Block
-      l) Xilinx IP cores
+      l) Freescale Communications Processor Module
+      m) Chipselect/Local Bus
+      n) 4xx/Axon EMAC ethernet nodes
+      o) Xilinx IP cores
 
   VII - Specifying interrupt information for devices
     1) interrupts property
@@ -1788,6 +1791,32 @@ platforms are moved over to use the flattened-device-tree model.
 		};
 	};
 
+   viii) Uploaded QE firmware
+
+	 If a new firwmare has been uploaded to the QE (usually by the
+	 boot loader), then a 'firmware' child node should be added to the QE
+	 node.  This node provides information on the uploaded firmware that
+	 device drivers may need.
+
+	 Required properties:
+	 - id: The string name of the firmware.  This is taken from the 'id'
+	       member of the qe_firmware structure of the uploaded firmware.
+	       Device drivers can search this string to determine if the
+	       firmware they want is already present.
+	 - extended-modes: The Extended Modes bitfield, taken from the
+			   firmware binary.  It is a 64-bit number represented
+			   as an array of two 32-bit numbers.
+	 - virtual-traps: The virtual traps, taken from the firmware binary.
+			  It is an array of 8 32-bit numbers.
+
+	 Example:
+
+		firmware {
+			id = "Soft-UART";
+			extended-modes = <0 0>;
+			virtual-traps = <0 0 0 0 0 0 0 0>;
+		}
+
    j) CFI or JEDEC memory-mapped NOR flash
 
     Flash chips (Memory Technology Devices) are often used for solid state
@@ -2270,7 +2299,7 @@ platforms are moved over to use the flattened-device-tree model.
 			   available.
 			   For Axon: 0x0000012a
 
-   l) Xilinx IP cores
+   o) Xilinx IP cores
 
    The Xilinx EDK toolchain ships with a set of IP cores (devices) for use
    in Xilinx Spartan and Virtex FPGAs.  The devices cover the whole range
diff --git a/Documentation/powerpc/qe_firmware.txt b/Documentation/powerpc/qe_firmware.txt
new file mode 100644
index 0000000..8962664
--- /dev/null
+++ b/Documentation/powerpc/qe_firmware.txt
@@ -0,0 +1,295 @@
+	   Freescale QUICC Engine Firmware Uploading
+	   -----------------------------------------
+
+(c) 2007 Timur Tabi <timur at freescale.com>,
+    Freescale Semiconductor
+
+Table of Contents
+=================
+
+  I - Software License for Firmware
+
+  II - Microcode Availability
+
+  III - Description and Terminology
+
+  IV - Microcode Programming Details
+
+  V - Firmware Structure Layout
+
+  VI - Sample Code for Creating Firmware Files
+
+Revision Information
+====================
+
+November 30, 2007: Rev 1.0 - Initial version
+
+I - Software License for Firmware
+=================================
+
+Each firmware file comes with its own software license.  For information on
+the particular license, please see the license text that is distributed with
+the firmware.
+
+II - Microcode Availability
+===========================
+
+Firmware files are distributed through various channels.  Some are available on
+http://opensource.freescale.com.  For other firmware files, please contact
+your Freescale representative or your operating system vendor.
+
+III - Description and Terminology
+================================
+
+In this document, the term 'microcode' refers to the sequence of 32-bit
+integers that compose the actual QE microcode.
+
+The term 'firmware' refers to a binary blob that contains the microcode as
+well as other data that
+
+	1) describes the microcode's purpose
+	2) describes how and where to upload the microcode
+	3) specifies the values of various registers
+	4) includes additional data for use by specific device drivers
+
+Firmware files are binary files that contain only a firmware.
+
+IV - Microcode Programming Details
+===================================
+
+The QE architecture allows for only one microcode present in I-RAM for each
+RISC processor.  To replace any current microcode, a full QE reset (which
+disables the microcode) must be performed first.
+
+QE microcode is uploaded using the following procedure:
+
+1) The microcode is placed into I-RAM at a specific location, using the
+   IRAM.IADD and IRAM.IDATA registers.
+
+2) The CERCR.CIR bit is set to 0 or 1, depending on whether the firmware
+   needs split I-RAM.  Split I-RAM is only meaningful for SOCs that have
+   QEs with multiple RISC processors, such as the 8360.  Splitting the I-RAM
+   allows each processor to run a different microcode, effectively creating an
+   asymmetric multiprocessing (AMP) system.
+
+3) The TIBCR trap registers are loaded with the addresses of the trap handlers
+   in the microcode.
+
+4) The RSP.ECCR register is programmed with the value provided.
+
+5) If necessary, device drivers that need the virtual traps and extended mode
+   data will use them.
+
+Virtual Microcode Traps
+
+These virtual traps are conditional branches in the microcode.  These are
+"soft" provisional introduced in the ROMcode in order to enable higher
+flexibility and save h/w traps If new features are activated or an issue is
+being fixed in the RAM package utilizing they should be activated.  This data
+structure signals the microcode which of these virtual traps is active.
+
+This structure contains 6 words that the application should copy to some
+specific been defined.  This table describes the structure.
+
+	---------------------------------------------------------------
+	| Offset in |                  | Destination Offset | Size of |
+	|   array   |     Protocol     |   within PRAM      | Operand |
+	--------------------------------------------------------------|
+	|     0     | Ethernet         |      0xF8          | 4 bytes |
+	|           | interworking     |                    |         |
+	---------------------------------------------------------------
+	|     4     | ATM              |      0xF8          | 4 bytes |
+	|           | interworking     |                    |         |
+	---------------------------------------------------------------
+	|     8     | PPP              |      0xF8          | 4 bytes |
+	|           | interworking     |                    |         |
+	---------------------------------------------------------------
+	|     12    | Ethernet RX      |      0x22          | 1 byte  |
+	|           | Distributor Page |                    |         |
+	---------------------------------------------------------------
+	|     16    | ATM Globtal      |      0x28          | 1 byte  |
+	|           | Params Table     |                    |         |
+	---------------------------------------------------------------
+	|     20    | Insert Frame     |      0xF8          | 4 bytes |
+	---------------------------------------------------------------
+
+
+Extended Modes
+
+This is a double word bit array (64 bits) that defines special functionality
+which has an impact on the softwarew drivers.  Each bit has its own impact
+and has special instructions for the s/w associated with it.  This structure is
+described in this table:
+
+	-----------------------------------------------------------------------
+	| Bit #  |     Name     |   Description                               |
+	-----------------------------------------------------------------------
+	|   0    | General      | Indicates that prior to each host command   |
+	|        | push command | given by the application, the software must |
+	|        |              | assert a special host command (push command)|
+	|        |              | CECDR = 0x00800000.                         |
+	|        |              | CECR = 0x01c1000f.                          |
+	-----------------------------------------------------------------------
+	|   1    | UCC ATM      | Indicates that after issuing ATM RX INIT    |
+	|        | RX INIT      | command, the host must issue another special|
+	|        | push command | command (push command) and immediately      |
+	|        |              | following that re-issue the ATM RX INIT     |
+	|        |              | command. (This makes the sequence of        |
+	|        |              | initializing the ATM receiver a sequence of |
+	|        |              | three host commands)                        |
+	|        |              | CECDR = 0x00800000.                         |
+	|        |              | CECR = 0x01c1000f.                          |
+	-----------------------------------------------------------------------
+	|   2    | Add/remove   | Indicates that following the specific host  |
+	|        | command      | command: "Add/Remove entry in Hash Lookup   |
+	|        | validation   | Table" used in Interworking setup, the user |
+	|        |              | must issue another command.                 |
+	|        |              | CECDR = 0xce000003.                         |
+	|        |              | CECR = 0x01c10f58.                          |
+	-----------------------------------------------------------------------
+	|   3    | General push | Indicates that the s/w has to initialize    |
+	|        | command      | some pointers in the Ethernet thread pages  |
+	|        |              | which are used when Header Compression is   |
+	|        |              | activated.  The full details of these       |
+	|        |              | pointers is located in the software drivers.|
+	-----------------------------------------------------------------------
+	|   4    | General push | Indicates that after issuing Ethernet TX    |
+	|        | command      | INIT command, user must issue this command  |
+	|        |              | for each SNUM of Ethernet TX thread.        |
+	|        |              | CECDR = 0x00800003.                         |
+	|        |              | CECR = 0x7'b{0}, 8'b{Enet TX thread SNUM},  |
+	|        |              |        1'b{1}, 12'b{0}, 4'b{1}              |
+	-----------------------------------------------------------------------
+	| 5 - 31 |     N/A      | Reserved, set to zero.                      |
+	-----------------------------------------------------------------------
+
+V - Firmware Structure Layout
+==============================
+
+QE microcode from Freescale is typically provided as a header file.  This
+header file contains macros that define the microcode binary itself as well as
+some other data used in uploading that microcode.  The format of these files
+do not lend themselves to simple inclusion into other code.  Hence,
+the need for a more portable format.  This section defines that format.
+
+Instead of distributing a header file, the microcode and related data are
+embedded into a binary blob.  This blob is passed to the qe_upload_firmware()
+function, which parses the blob and performs everything necessary to upload
+the microcode.
+
+All integers are big-endian.  See the comments for function
+qe_upload_firmware() for up-to-date implementation information.
+
+This structure supports versioning, where the version of the structure is
+embedded into the structure itself.  To ensure forward and backwards
+compatibility, all versions of the structure must use the same 'qe_header'
+structure at the beginning.
+
+'header' (type: struct qe_header):
+	The 'length' field is the size, in bytes, of the entire structure,
+	including all the microcode embedded in it, as well as the CRC (if
+	present).
+
+	The 'magic' field is an array of three bytes that contains the letters
+	'Q', 'E', and 'F'.  This is an identifier that indicates that this
+	structure is a QE Firmware structure.
+
+	The 'version' field is a single byte that indicates the version of this
+	structure.  If the layout of the structure should ever need to be
+	changed to add support for additional types of microcode, then the
+	version number should also be changed.
+
+The 'id' field is a null-terminated string(suitable for printing) that
+identifies the firmware.
+
+The 'count' field indicates the number of 'microcode' structures.  There
+must be one and only one 'microcode' structure for each RISC processor.
+Therefore, this field also represents the number of RISC processors for this
+SOC.
+
+The 'soc' structure contains the SOC numbers and revisions used to match
+the microcode to the SOC itself.  Normally, the microcode loader should
+check the data in this structure with the SOC number and revisions, and
+only upload the microcode if there's a match.  However, this check is not
+made on all platforms.
+
+Although it is not recommended, you can specify '0' in the soc.model
+field to skip matching SOCs altogether.
+
+The 'model' field is a 16-bit number that matches the actual SOC. The
+'major' and 'minor' fields are the major and minor revision numbrs,
+respectively, of the SOC.
+
+For example, to match the 8323, revision 1.0:
+     soc.model = 8323
+     soc.major = 1
+     soc.minor = 0
+
+'padding' is neccessary for structure alignment.  This field ensures that the
+'extended_modes' field is aligned on a 64-bit boundary.
+
+'extended_modes' is a bitfield that defines special functionality which has an
+impact on the device drivers.  Each bit has its own impact and has special
+instructions for the driver associated with it.  This field is stored in
+the QE library and available to any driver that calles qe_get_firmware_info().
+
+'vtraps' is an array of 8 words that contain virtual trap values for each
+virtual traps.  As with 'extended_modes', this field is stored in the QE
+library and available to any driver that calles qe_get_firmware_info().
+
+'microcode' (type: struct qe_microcode):
+	For each RISC processor there is one 'microcode' structure.  The first
+	'microcode' structure is for the first RISC, and so on.
+
+	The 'id' field is a null-terminated string suitable for printing that
+	identifies this particular microcode.
+
+	'traps' is an array of 16 words that contain hardware trap values
+	for each of the 16 traps.  If trap[i] is 0, then this particular
+	trap is to be ignored (i.e. not written to TIBCR[i]).  The entire value
+	is written as-is to the TIBCR[i] register, so be sure to set the EN
+	and T_IBP bits if necessary.
+
+	'eccr' is the value to program into the ECCR register.
+
+	'iram_offset' is the offset into IRAM to start writing the
+	microcode.
+
+	'count' is the number of 32-bit words in the microcode.
+
+	'code_offset' is the offset, in bytes, from the beginning of this
+	structure where the microcode itself can be found.  The first
+	microcode binary should be located immediately after the 'microcode'
+	array.
+
+	'major', 'minor', and 'revision' are the major, minor, and revision
+	version numbers, respectively, of the microcode.  If all values are 0,
+	then these fields are ignored.
+
+	'reserved' is necessary for structure alignment.  Since 'microcode'
+	is an array, the 64-bit 'extended_modes' field needs to be aligned
+	on a 64-bit boundary, and this can only happen if the size of
+	'microcode' is a multiple of 8 bytes.  To ensure that, we add
+	'reserved'.
+
+After the last microcode is a 32-bit CRC.  It can be calculated using
+this algorithm:
+
+u32 crc32(const u8 *p, unsigned int len)
+{
+	unsigned int i;
+	u32 crc = 0;
+
+	while (len--) {
+	   crc ^= *p++;
+	   for (i = 0; i < 8; i++)
+		   crc = (crc >> 1) ^ ((crc & 1) ? 0xedb88320 : 0);
+	}
+	return crc;
+}
+
+VI - Sample Code for Creating Firmware Files
+============================================
+
+A Python program that creates firmware binaries from the header files normally
+distributed by Freescale can be found on http://opensource.freescale.com.
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index ea22cad..18f101b 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -265,6 +265,7 @@ config TAU_AVERAGE
 config QUICC_ENGINE
 	bool
 	select PPC_LIB_RHEAP
+	select CRC32
 	help
 	  The QUICC Engine (QE) is a new generation of communications
 	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index 21e0106..3925eae 100644
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
@@ -394,3 +395,249 @@ void *qe_muram_addr(unsigned long offset)
 	return (void *)&qe_immr->muram[offset];
 }
 EXPORT_SYMBOL(qe_muram_addr);
+
+/* The maximum number of RISCs we support */
+#define MAX_QE_RISC     2
+
+/* Firmware information stored here for qe_get_firmware_info() */
+static struct qe_firmware_info qe_firmware_info;
+
+/*
+ * Set to 1 if QE firmware has been uploaded, and therefore
+ * qe_firmware_info contains valid data.
+ */
+static int qe_firmware_uploaded;
+
+/*
+ * Upload a QE microcode
+ *
+ * This function is a worker function for qe_upload_firmware().  It does
+ * the actual uploading of the microcode.
+ */
+static void qe_upload_microcode(const void *base,
+	const struct qe_microcode *ucode)
+{
+	const __be32 *code = base + be32_to_cpu(ucode->code_offset);
+	unsigned int i;
+
+	if (ucode->major || ucode->minor || ucode->revision)
+		printk(KERN_INFO "qe-firmware: "
+			"uploading microcode '%s' version %u.%u.%u\n",
+			ucode->id, ucode->major, ucode->minor, ucode->revision);
+	else
+		printk(KERN_INFO "qe-firmware: "
+			"uploading microcode '%s'\n", ucode->id);
+
+	/* Use auto-increment */
+	out_be32(&qe_immr->iram.iadd, be32_to_cpu(ucode->iram_offset) |
+		QE_IRAM_IADD_AIE | QE_IRAM_IADD_BADDR);
+
+	for (i = 0; i < be32_to_cpu(ucode->count); i++)
+		out_be32(&qe_immr->iram.idata, be32_to_cpu(code[i]));
+}
+
+/*
+ * Upload a microcode to the I-RAM at a specific address.
+ *
+ * See Documentation/powerpc/qe-firmware.txt for information on QE microcode
+ * uploading.
+ *
+ * Currently, only version 1 is supported, so the 'version' field must be
+ * set to 1.
+ *
+ * The SOC model and revision are not validated, they are only displayed for
+ * informational purposes.
+ *
+ * 'calc_size' is the calculated size, in bytes, of the firmware structure and
+ * all of the microcode structures, minus the CRC.
+ *
+ * 'length' is the size that the structure says it is, including the CRC.
+ */
+int qe_upload_firmware(const struct qe_firmware *firmware)
+{
+	unsigned int i;
+	unsigned int j;
+	u32 crc;
+	size_t calc_size = sizeof(struct qe_firmware);
+	size_t length;
+	const struct qe_header *hdr;
+
+	if (!firmware) {
+		printk(KERN_ERR "qe-firmware: invalid pointer\n");
+		return -EINVAL;
+	}
+
+	hdr = &firmware->header;
+	length = be32_to_cpu(hdr->length);
+
+	/* Check the magic */
+	if ((hdr->magic[0] != 'Q') || (hdr->magic[1] != 'E') ||
+	    (hdr->magic[2] != 'F')) {
+		printk(KERN_ERR "qe-firmware: not a microcode\n");
+		return -EPERM;
+	}
+
+	/* Check the version */
+	if (hdr->version != 1) {
+		printk(KERN_ERR "qe-firmware: unsupported version\n");
+		return -EPERM;
+	}
+
+	/* Validate some of the fields */
+	if ((firmware->count < 1) || (firmware->count >= MAX_QE_RISC)) {
+		printk(KERN_ERR "qe-firmware: invalid data\n");
+		return -EINVAL;
+	}
+
+	/* Validate the length and check if there's a CRC */
+	calc_size += (firmware->count - 1) * sizeof(struct qe_microcode);
+
+	for (i = 0; i < firmware->count; i++)
+		/*
+		 * For situations where the second RISC uses the same microcode
+		 * as the first, the 'code_offset' and 'count' fields will be
+		 * zero, so it's okay to add those.
+		 */
+		calc_size += sizeof(__be32) *
+			be32_to_cpu(firmware->microcode[i].count);
+
+	/* Validate the length */
+	if (length != calc_size + sizeof(__be32)) {
+		printk(KERN_ERR "qe-firmware: invalid length\n");
+		return -EPERM;
+	}
+
+	/* Validate the CRC */
+	crc = be32_to_cpu(*(__be32 *)((void *)firmware + calc_size));
+	if (crc != crc32(0, firmware, calc_size)) {
+		printk(KERN_ERR "qe-firmware: firmware CRC is invalid\n");
+		return -EIO;
+	}
+
+	/*
+	 * If the microcode calls for it, split the I-RAM.
+	 */
+	if (!firmware->split)
+		setbits16(&qe_immr->cp.cercr, QE_CP_CERCR_CIR);
+
+	if (firmware->soc.model)
+		printk(KERN_INFO
+			"qe-firmware: firmware '%s' for %u V%u.%u\n",
+			firmware->id, be16_to_cpu(firmware->soc.model),
+			firmware->soc.major, firmware->soc.minor);
+	else
+		printk(KERN_INFO "qe-firmware: firmware '%s'\n",
+			firmware->id);
+
+	/*
+	 * The QE only supports one microcode per RISC, so clear out all the
+	 * saved microcode information and put in the new.
+	 */
+	memset(&qe_firmware_info, 0, sizeof(qe_firmware_info));
+	strcpy(qe_firmware_info.id, firmware->id);
+	qe_firmware_info.extended_modes = firmware->extended_modes;
+	memcpy(qe_firmware_info.vtraps, firmware->vtraps,
+		sizeof(firmware->vtraps));
+
+	/* Loop through each microcode. */
+	for (i = 0; i < firmware->count; i++) {
+		const struct qe_microcode *ucode = &firmware->microcode[i];
+
+		/* Upload a microcode if it's present */
+		if (ucode->code_offset)
+			qe_upload_microcode(firmware, ucode);
+
+		/* Program the traps for this processor */
+		for (j = 0; j < 16; j++) {
+			u32 trap = be32_to_cpu(ucode->traps[j]);
+
+			if (trap)
+				out_be32(&qe_immr->rsp[i].tibcr[j], trap);
+		}
+
+		/* Enable traps */
+		out_be32(&qe_immr->rsp[i].eccr, be32_to_cpu(ucode->eccr));
+	}
+
+	qe_firmware_uploaded = 1;
+
+	return 0;
+}
+EXPORT_SYMBOL(qe_upload_firmware);
+
+/*
+ * Get info on the currently-loaded firmware
+ *
+ * This function also checks the device tree to see if the boot loader has
+ * uploaded a firmware already.
+ */
+struct qe_firmware_info *qe_get_firmware_info(void)
+{
+	static int initialized;
+	struct property *prop;
+	struct device_node *qe;
+	struct device_node *fw = NULL;
+	const char *sprop;
+	unsigned int i;
+
+	/*
+	 * If we haven't checked yet, and a driver hasn't uploaded a firmware
+	 * yet, then check the device tree for information.
+	 */
+	if (initialized || qe_firmware_uploaded)
+		return NULL;
+
+	initialized = 1;
+
+	/*
+	 * Newer device trees have an "fsl,qe" compatible property for the QE
+	 * node, but we still need to support older device trees.
+	*/
+	qe = of_find_compatible_node(NULL, NULL, "fsl,qe");
+	if (!qe) {
+		qe = of_find_node_by_type(NULL, "qe");
+		if (!qe)
+			return NULL;
+	}
+
+	/* Find the 'firmware' child node */
+	for_each_child_of_node(qe, fw) {
+		if (strcmp(fw->name, "firmware") == 0)
+			break;
+	}
+
+	of_node_put(qe);
+
+	/* Did we find the 'firmware' node? */
+	if (!fw)
+		return NULL;
+
+	qe_firmware_uploaded = 1;
+
+	/* Copy the data into qe_firmware_info*/
+	sprop = of_get_property(fw, "id", NULL);
+	if (sprop)
+		strncpy(qe_firmware_info.id, sprop,
+			sizeof(qe_firmware_info.id) - 1);
+
+	prop = of_find_property(fw, "extended-modes", NULL);
+	if (prop && (prop->length == sizeof(u64))) {
+		const u64 *iprop = prop->value;
+
+		qe_firmware_info.extended_modes = *iprop;
+	}
+
+	prop = of_find_property(fw, "virtual-traps", NULL);
+	if (prop && (prop->length == 32)) {
+		const u32 *iprop = prop->value;
+
+		for (i = 0; i < ARRAY_SIZE(qe_firmware_info.vtraps); i++)
+			qe_firmware_info.vtraps[i] = iprop[i];
+	}
+
+	of_node_put(fw);
+
+	return &qe_firmware_info;
+}
+EXPORT_SYMBOL(qe_get_firmware_info);
+
diff --git a/include/asm-powerpc/immap_qe.h b/include/asm-powerpc/immap_qe.h
index aba9806..82a4526 100644
--- a/include/asm-powerpc/immap_qe.h
+++ b/include/asm-powerpc/immap_qe.h
@@ -393,9 +393,39 @@ struct dbg {
 	u8	res2[0x48];
 } __attribute__ ((packed));
 
-/* RISC Special Registers (Trap and Breakpoint) */
+/*
+ * RISC Special Registers (Trap and Breakpoint).  These are described in
+ * the QE Developer's Handbook.
+ */
 struct rsp {
-	u32	reg[0x40];	/* 64 32-bit registers */
+	__be32 tibcr[16];	/* Trap/instruction breakpoint control regs */
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
+	__be32 bior;
+	u8 res3[4];
+	__be32 iatr[4];
+	__be32 eccr;		/* Exception control configuration register */
+	__be32 eicr;
+	u8 res4[0x100-0xf8];
 } __attribute__ ((packed));
 
 struct qe_immap {
diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
index a24b7b1..430dc77 100644
--- a/include/asm-powerpc/qe.h
+++ b/include/asm-powerpc/qe.h
@@ -94,6 +94,58 @@ unsigned long qe_muram_alloc_fixed(unsigned long offset, int size);
 void qe_muram_dump(void);
 void *qe_muram_addr(unsigned long offset);
 
+/* Structure that defines QE firmware binary files.
+ *
+ * See Documentation/powerpc/qe-firmware.txt for a description of these
+ * fields.
+ */
+struct qe_firmware {
+	struct qe_header {
+		__be32 length;  /* Length of the entire structure, in bytes */
+		u8 magic[3];    /* Set to { 'Q', 'E', 'F' } */
+		u8 version;     /* Version of this layout. First ver is '1' */
+	} header;
+	u8 id[62];      /* Null-terminated identifier string */
+	u8 split;	/* 0 = shared I-RAM, 1 = split I-RAM */
+	u8 count;       /* Number of microcode[] structures */
+	struct {
+		__be16 model;   	/* The SOC model  */
+		u8 major;       	/* The SOC revision major */
+		u8 minor;       	/* The SOC revision minor */
+	} __attribute__ ((packed)) soc;
+	u8 padding[4];			/* Reserved, for alignment */
+	__be64 extended_modes;		/* Extended modes */
+	__be32 vtraps[8];		/* Virtual trap addresses */
+	u8 reserved[4];			/* Reserved, for future expansion */
+	struct qe_microcode {
+		u8 id[32];      	/* Null-terminated identifier */
+		__be32 traps[16];       /* Trap addresses, 0 == ignore */
+		__be32 eccr;    	/* The value for the ECCR register */
+		__be32 iram_offset;     /* Offset into I-RAM for the code */
+		__be32 count;   	/* Number of 32-bit words of the code */
+		__be32 code_offset;     /* Offset of the actual microcode */
+		u8 major;       	/* The microcode version major */
+		u8 minor;       	/* The microcode version minor */
+		u8 revision;		/* The microcode version revision */
+		u8 padding;		/* Reserved, for alignment */
+		u8 reserved[4];		/* Reserved, for future expansion */
+	} __attribute__ ((packed)) microcode[1];
+	/* All microcode binaries should be located here */
+	/* CRC32 should be located here, after the microcode binaries */
+} __attribute__ ((packed));
+
+struct qe_firmware_info {
+	char id[64];		/* Firmware name */
+	u32 vtraps[8];		/* Virtual trap addresses */
+	u64 extended_modes;	/* Extended modes */
+};
+
+/* Upload a firmware to the QE */
+int qe_upload_firmware(const struct qe_firmware *firmware);
+
+/* Obtain information on the uploaded firmware */
+struct qe_firmware_info *qe_get_firmware_info(void);
+
 /* Buffer descriptors */
 struct qe_bd {
 	__be16 status;
@@ -329,6 +381,15 @@ enum comm_dir {
 
 #define QE_SDEBCR_BA_MASK	0x01FFFFFF
 
+/* Communication Processor */
+#define QE_CP_CERCR_MEE		0x8000	/* Multi-user RAM ECC enable */
+#define QE_CP_CERCR_IEE		0x4000	/* Instruction RAM ECC enable */
+#define QE_CP_CERCR_CIR		0x0800	/* Common instruction RAM */
+
+/* I-RAM */
+#define QE_IRAM_IADD_AIE	0x80000000	/* Auto Increment Enable */
+#define QE_IRAM_IADD_BADDR	0x00080000	/* Base Address */
+
 /* UPC */
 #define UPGCR_PROTOCOL	0x80000000	/* protocol ul2 or pl2 */
 #define UPGCR_TMS	0x40000000	/* Transmit master/slave mode */
-- 
1.5.2.4
