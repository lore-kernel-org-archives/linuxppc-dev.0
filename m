Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: erik.teose@exgate.tek.com
Message-ID: <BA0E4392AD99D040885C414D992C24BE03615100@us-bv-m11>
To: ElTopo@myrealbox.com, linuxppc-embedded@lists.linuxppc.org
Cc: erik.teose@tek.com
Subject: RE: ppcboot 2.0.0 + ppclinux2.4.devel, network weirdo
Date: Wed, 9 Apr 2003 09:23:14 -0700 
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C2FEB4.52031FA0"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C2FEB4.52031FA0
Content-Type: text/plain;
	charset="iso-8859-1"

> 1. for some reason, linux kernel sees the two eth interfaces but fails
> to get the correct MAC addresses, thus when system fully boots up
> "ifconfig" shows two eth0/eth1 with MAC addr as ff:ff:ff:ff:ff:ff, because
> this is same as brd, many network services won't work.
> I checked kernel source code and found that, in include/asm-ppc/ibm440.h,
> there's a structure "board_info" holds MAC addresses of the two enet
> interfaces. According to this header file: "Ebony firmware stores MAC
> addresses in the F/W VPD area. The firmware must store the other dynamic
> values in NVRAM like on the previous 40x systems so they  should be
> accessible if we really want them."
> So, my question is: how can I get ibm440's EMAC info? from NVRAM?
> the kernel I am using now does not support NVRAM for ppc yet.

Are you using kernel code supplied by MontaVista (MV)? I had the same
problem;
we are using MontaVista 3.0 for the Ebony board, and I had trouble with
the interface from u-boot 0.2.0 to the MV kernel. The MV code is very
specific to the bootrom supplied by IBM; that bootrom is "custom" to each
unique Ebony board, because the 2 MAC addresses are stored at the end of the
bootrom (that's the "VPD" area). I had to modify 3 MV files to get the MAC
address passed in from u-boot to be used by the MV kernel
(kernel/arch/ppc/platforms/ebony.c,
kernel/include/asm-ppc/ibm440.h, and kernel/include/asm-ppc/ibm4xx.h). I
have attached
my patches for these files.

After I got the MAC address to transfer over from u-boot, I had trouble with
nfs mounting
the root filesystem (I did not want to use bootp/dhcp in the nfs mounting
process). I had to
modify kernel/net/ipv4/ipconfig.c to get this to work (I've attached this
patch as well).

Hope this helps.

Erik Teose
erik.teose@tek.com


------_=_NextPart_000_01C2FEB4.52031FA0
Content-Type: application/octet-stream;
	name="ebony.c.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ebony.c.patch"

--- ebony.c.orig	Thu Mar 27 17:07:13 2003=0A=
+++ ebony.c	Fri Mar 28 09:06:53 2003=0A=
@@ -125,6 +125,7 @@ extern void abort(void);=0A=
 =0A=
 /* Global Variables */=0A=
 unsigned char __res[sizeof (bd_t)];=0A=
+unsigned char __res_uboot[sizeof (bd_uboot_t)];=0A=
 =0A=
 static void __init=0A=
 ebony_calibrate_decr(void)=0A=
@@ -325,7 +326,7 @@ static void __init=0A=
 ebony_setup_arch(void)=0A=
 {=0A=
 	bd_t *bip =3D (bd_t *)__res;=0A=
-	unsigned char * vpd_base;=0A=
+	bd_uboot_t *bi_uboot_p =3D (bd_uboot_t *) __res_uboot;=0A=
 =0A=
 #if !defined(CONFIG_BDI_SWITCH)=0A=
 	/*=0A=
@@ -336,9 +337,16 @@ ebony_setup_arch(void)=0A=
 #endif=0A=
 =0A=
 	/* Retrieve MAC addresses */=0A=
+#if 0=0A=
 	vpd_base =3D ioremap64(EBONY_VPD_BASE, EBONY_VPD_SIZE);=0A=
 	memcpy(bip->bi_enetaddr[0],EBONY_NA0_ADDR(vpd_base),6);=0A=
 	memcpy(bip->bi_enetaddr[1],EBONY_NA1_ADDR(vpd_base),6);=0A=
+#endif=0A=
+	memcpy(bip->bi_enetaddr[0], bi_uboot_p->bi_enetaddr, 6);=0A=
+	memcpy(bip->bi_enetaddr[1], bi_uboot_p->bi_enetaddr, 6);=0A=
+	bip->bi_enetaddr[1][5]++;	/* mac addr of second enet port is one =
more=0A=
+								 * than first one's=0A=
+								 */=0A=
 =0A=
 	/* Setup TODC access */=0A=
 	TODC_INIT(TODC_TYPE_DS1743,=0A=
@@ -468,10 +476,51 @@ ebony_init_irq(void)=0A=
 		irq_desc[i].handler =3D ppc4xx_pic;=0A=
 }=0A=
 =0A=
-void __init platform_init(unsigned long r3, unsigned long r4,=0A=
+/*=0A=
+ * Input(s):=0A=
+ *   r3 - Optional pointer to a board information structure.=0A=
+ *   r4 - Optional pointer to the physical starting address of the =
init RAM=0A=
+ *        disk.=0A=
+ *   r5 - Optional pointer to the physical ending address of the init =
RAM=0A=
+ *        disk.=0A=
+ *   r6 - Optional pointer to the physical starting address of any =
kernel=0A=
+ *        command-line parameters.=0A=
+ *   r7 - Optional pointer to the physical ending address of any =
kernel=0A=
+ *        command-line parameters.=0A=
+ */=0A=
+void __init =0A=
+platform_init(unsigned long r3, unsigned long r4,=0A=
 		unsigned long r5, unsigned long r6, unsigned long r7)=0A=
 {=0A=
+#if 0=0A=
 	parse_bootinfo((struct bi_record *) (r3 + KERNELBASE));=0A=
+#endif=0A=
+=0A=
+    /*=0A=
+     * If we were passed in board information, copy it into the=0A=
+     * residual data area.=0A=
+     */=0A=
+    if (r3) {=0A=
+        memcpy((void *) __res_uboot, (void *) (r3 + KERNELBASE),=0A=
+               sizeof (bd_uboot_t));=0A=
+=0A=
+    }=0A=
+#if defined(CONFIG_BLK_DEV_INITRD)=0A=
+    /*=0A=
+     * If the init RAM disk has been configured in, and there's a =
valid=0A=
+     * starting address for it, set it up.=0A=
+     */=0A=
+    if (r4) {=0A=
+        initrd_start =3D r4 + KERNELBASE;=0A=
+        initrd_end   =3D r5 + KERNELBASE;=0A=
+    }=0A=
+#endif /* CONFIG_BLK_DEV_INITRD */=0A=
+=0A=
+    /* Copy the kernel command line arguments to a safe place. */=0A=
+    if (r6) {=0A=
+        *(char *) (r7 + KERNELBASE) =3D 0;=0A=
+        strcpy(cmd_line, (char *) (r6 + KERNELBASE));=0A=
+    }=0A=
 =0A=
 	ppc_md.setup_arch =3D ebony_setup_arch;=0A=
 	ppc_md.show_cpuinfo =3D ebony_show_cpuinfo;=0A=

------_=_NextPart_000_01C2FEB4.52031FA0
Content-Type: application/octet-stream;
	name="ibm440.h.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ibm440.h.patch"

--- ibm440.h.orig	Thu Mar 27 16:56:20 2003=0A=
+++ ibm440.h	Fri Mar 28 08:47:40 2003=0A=
@@ -44,6 +44,58 @@=0A=
 typedef struct board_info {=0A=
 	unsigned char	 bi_enetaddr[2][6];	/* EMAC addresses */=0A=
 } bd_t;=0A=
+=0A=
+typedef struct bd_info {=0A=
+    unsigned long   bi_memstart;    /* start of DRAM memory */=0A=
+    unsigned long   bi_memsize; /* size  of DRAM memory in bytes */=0A=
+    unsigned long   bi_flashstart;  /* start of FLASH memory */=0A=
+    unsigned long   bi_flashsize;   /* size  of FLASH memory */=0A=
+    unsigned long   bi_flashoffset; /* reserved area for startup =
monitor */=0A=
+    unsigned long   bi_sramstart;   /* start of SRAM memory */=0A=
+    unsigned long   bi_sramsize;    /* size  of SRAM memory */=0A=
+#if defined(CONFIG_8xx) || defined(CONFIG_8260)=0A=
+    unsigned long   bi_immr_base;   /* base of IMMR register */=0A=
+#endif=0A=
+    unsigned long   bi_bootflags;   /* boot / reboot flag (for LynxOS) =
*/=0A=
+    unsigned long   bi_ip_addr; /* IP Address */=0A=
+    unsigned char   bi_enetaddr[6]; /* Ethernet adress */=0A=
+    unsigned short  bi_ethspeed;    /* Ethernet speed in Mbps */=0A=
+    unsigned long   bi_intfreq; /* Internal Freq, in MHz */=0A=
+    unsigned long   bi_busfreq; /* Bus Freq, in MHz */=0A=
+#if defined(CONFIG_8260)=0A=
+    unsigned long   bi_cpmfreq; /* CPM_CLK Freq, in MHz */=0A=
+    unsigned long   bi_brgfreq; /* BRG_CLK Freq, in MHz */=0A=
+    unsigned long   bi_sccfreq; /* SCC_CLK Freq, in MHz */=0A=
+    unsigned long   bi_vco;     /* VCO Out from PLL, in MHz */=0A=
+#endif=0A=
+    unsigned long   bi_baudrate;    /* Console Baudrate */=0A=
+#if defined(CONFIG_405GP) || \=0A=
+    defined(CONFIG_405CR) || \=0A=
+    defined(CONFIG_440)   || \=0A=
+    defined(CONFIG_405)=0A=
+    unsigned char   bi_s_version[4];    /* Version of this structure =
*/=0A=
+    unsigned char   bi_r_version[32];   /* Version of the ROM (IBM) =
*/=0A=
+    unsigned int    bi_procfreq;    /* CPU (Internal) Freq, in Hz =
*/=0A=
+    unsigned int    bi_plb_busfreq; /* PLB Bus speed, in Hz */=0A=
+    unsigned int    bi_pci_busfreq; /* PCI Bus speed, in Hz */=0A=
+    unsigned char   bi_pci_enetaddr[6]; /* PCI Ethernet MAC address =
*/=0A=
+#endif=0A=
+#if defined(CONFIG_HYMOD)=0A=
+    hymod_conf_t    bi_hymod_conf;  /* hymod configuration information =
*/=0A=
+#endif=0A=
+#if defined(CONFIG_EVB64260) || defined(CONFIG_PN62)=0A=
+    /* second onboard ethernet port */=0A=
+    unsigned char   bi_enet1addr[6];=0A=
+#endif=0A=
+#if defined(CONFIG_EVB64260)=0A=
+    /* third onboard ethernet port */=0A=
+    unsigned char   bi_enet2addr[6];=0A=
+#endif=0A=
+#if defined(CONFIG_NX823)=0A=
+    unsigned char   bi_sernum[8];=0A=
+#endif=0A=
+} bd_uboot_t;=0A=
+=0A=
 #endif /* __ASSEMBLY__ */=0A=
 =0A=
 #ifndef NR_BOARD_IRQS=0A=

------_=_NextPart_000_01C2FEB4.52031FA0
Content-Type: application/octet-stream;
	name="ibm4xx.h.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ibm4xx.h.patch"

--- ibm4xx.h.orig	Thu Mar 27 17:28:08 2003=0A=
+++ ibm4xx.h	Thu Mar 27 17:28:25 2003=0A=
@@ -22,6 +22,7 @@=0A=
  */=0A=
 #ifndef __ASSEMBLY__=0A=
 extern unsigned char __res[];=0A=
+extern unsigned char __res_uboot[];=0A=
 =0A=
 /* Device Control Registers */=0A=
 #define stringify(s)	tostring(s)=0A=

------_=_NextPart_000_01C2FEB4.52031FA0
Content-Type: application/octet-stream;
	name="ipconfig.c.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ipconfig.c.patch"

--- ipconfig.c.orig	Wed Apr  2 14:38:21 2003=0A=
+++ ipconfig.c	Thu Apr  3 10:36:18 2003=0A=
@@ -1149,7 +1149,8 @@ static int __init ip_auto_config(void)=0A=
 	     && root_server_addr =3D=3D INADDR_NONE=0A=
 	     && ic_servaddr =3D=3D INADDR_NONE) ||=0A=
 #endif=0A=
-	    ic_first_dev->next) {=0A=
+		/* erikt: '!' needed so u-boot will work with this code */=0A=
+	    !ic_first_dev->next) {=0A=
 #ifdef IPCONFIG_DYNAMIC=0A=
 =0A=
 		if (ic_dynamic() < 0) {=0A=

------_=_NextPart_000_01C2FEB4.52031FA0--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
