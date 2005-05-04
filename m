Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 2E217679E6
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 May 2005 00:35:29 +1000 (EST)
Message-ID: <4278DDAF.6010605@ru.mvista.com>
Date: Wed, 04 May 2005 18:35:27 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Content-Type: multipart/mixed; boundary="------------010301000202000109030901"
Subject: [RFC][PATCH 2.6.12-rc2 2/3] FCC Ethernet PlatformDevice support for
 82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010301000202000109030901
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds some helper functions to the common CPM2 code in order 
to prevent
direct *immr usage within network driver.

Signed-off-by: Vitaly Bordug<vbordug@ru.mvista.com>

-- 
Sincerely, 
Vitaly


--------------010301000202000109030901
Content-Type: text/x-patch;
 name="cpm2_addition.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpm2_addition.patch"

diff -Nru a/arch/ppc/syslib/cpm2_common.c b/arch/ppc/syslib/cpm2_common.c
--- a/arch/ppc/syslib/cpm2_common.c	2005-05-04 16:52:10 +04:00
+++ b/arch/ppc/syslib/cpm2_common.c	2005-05-04 16:52:10 +04:00
@@ -112,6 +112,62 @@
 		*bp |= CPM_BRG_DIV16;
 }
 
+void cpm2_cmd(uint cmd)
+{
+	cpmp->cp_cpcr = cmd | CPM_CR_FLG;
+	while(cpmp->cp_cpcr & CPM_CR_FLG)
+		cpu_relax();
+	
+}
+
+s_iop* cpm2_pin_read(enum ioports port)
+{	
+	s_iop* iop;
+	iop = (s_iop*)(&cpm2_immr->im_ioport);
+	return &iop[port];
+}
+
+void cpm2_pin_program(enum ioports port, int set, u32 par, u32 odr, u32 dir, u32 sor, u32 dat)
+{
+	s_iop *ioport = cpm2_pin_read(port);
+
+	pr_debug("Modified: iop[%d]: par %x odr %x dir %x sor %x dat %x\n",
+		par,odr,dir,sor,dat);
+	
+	if(set)
+	{
+		if(dir)
+			ioport->pdir |= dir;
+		if(par)
+			ioport->ppar  |= par;
+		if(par)
+			ioport->podr |= odr;
+		if(sor)
+			ioport->psor |= sor;
+		if(dat)
+			ioport->pdat |= dat;
+	} else {
+		if(dir)
+			ioport->pdir &= ~dir;
+		if(par)
+			ioport->ppar  &= ~par;
+		if(odr)
+			ioport->podr &= ~odr;
+		if(sor)
+			ioport->psor &= ~sor;
+		if(dat)
+			ioport->pdat &= ~dat;
+	}
+}
+
+void cpm2_cpmux_alter_fcr(u32 set, u32 clear)
+{
+	u32 tmpval = cpm2_immr->im_cpmux.cmx_fcr;
+	tmpval &= ~clear;
+	tmpval |= set;
+	cpm2_immr->im_cpmux.cmx_fcr = tmpval;
+}
+
 /*
  * dpalloc / dpfree bits.
  */
diff -Nru a/include/asm-ppc/cpm2.h b/include/asm-ppc/cpm2.h
--- a/include/asm-ppc/cpm2.h	2005-05-04 16:52:10 +04:00
+++ b/include/asm-ppc/cpm2.h	2005-05-04 16:52:10 +04:00
@@ -75,6 +75,11 @@
 #define CPM_CR_START_IDMA	((ushort)0x0009)
 #define CPM_CR_STOP_IDMA	((ushort)0x000b)
 
+#define CPM_MCN_HDLC		0x00
+#define CPM_MCN_ATM		0x0A
+#define CPM_MCN_ETHERNET	0x0C
+#define CPM_MCN_TRANSPARENT	0x0F
+
 #define mk_cr_cmd(PG, SBC, MCN, OP) \
 	((PG << 26) | (SBC << 21) | (MCN << 6) | OP)
 
@@ -116,6 +121,7 @@
 extern void *cpm_dpram_addr(uint offset);
 extern void cpm_setbrg(uint brg, uint rate);
 extern void cpm2_fastbrg(uint brg, uint rate, int div16);
+extern void cpm2_cmd(uint cmd);
 
 /* Buffer descriptors used by many of the CPM protocols.
 */
@@ -1038,6 +1044,28 @@
 #define CMXSCR_TS4CS_CLK6  0x00000005   /* SCC4 Tx Clock Source is CLK6 */
 #define CMXSCR_TS4CS_CLK7  0x00000006   /* SCC4 Tx Clock Source is CLK7 */
 #define CMXSCR_TS4CS_CLK8  0x00000007   /* SCC4 Tx Clock Source is CLK8 */
+
+/* IOport stuff*/
+
+enum ioports{
+	PORTA,
+	PORTB,
+	PORTC,
+	PORTD,
+};
+
+typedef struct single_ioport{
+	u32	pdir;
+	u32	ppar;
+	u32	psor;
+	u32	podr;
+	u32	pdat;
+	u8	res1[12];
+}s_iop;	
+
+void cpm2_pin_program(enum ioports port, int set, u32 par, u32 odr, u32 dir, u32 sor, u32 dat);
+void cpm2_cpmux_alter_fcr(u32 set, u32 clear);
+s_iop* cpm2_pin_read(enum ioports port);
 
 #endif /* __CPM2__ */
 #endif /* __KERNEL__ */

--------------010301000202000109030901--
