Return-Path: <norsk5@yahoo.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8E230B7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 09:31:21 +1000 (EST)
Received: from web50111.mail.re2.yahoo.com (web50111.mail.re2.yahoo.com
	[206.190.39.137]) by ozlabs.org (Postfix) with SMTP id 7313EDDDF6
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 09:31:20 +1000 (EST)
Message-ID: <2576.44687.qm@web50111.mail.re2.yahoo.com>
Date: Thu, 9 Jul 2009 16:24:38 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: [PATCH v2] edac: mpc85xx: add support for mpc83xx memory
	controller
To: bluesmoke-devel@lists.sourceforge.net, Dave Jiang <djiang@mvista.com>,
	Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
	"Ira W. Snyder" <iws@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Ok, is this the one you want me to push upstream?=0A=0Adoug t=0A=0A=0A--- O=
n Thu, 7/9/09, Ira W. Snyder <iws@ovro.caltech.edu> wrote:=0A=0AFrom: Ira W=
. Snyder <iws@ovro.caltech.edu>=0ASubject: [PATCH v2] edac: mpc85xx: add su=
pport for mpc83xx memory controller=0ATo: bluesmoke-devel@lists.sourceforge=
.net, "Dave Jiang" <djiang@mvista.com>, "Kumar Gala" <galak@kernel.crashing=
.org>, linuxppc-dev@ozlabs.org=0ADate: Thursday, July 9, 2009, 1:40 PM=0A=
=0AAdd support for the Freescale MPC83xx memory controller to the existing=
=0Adriver for the Freescale MPC85xx memory controller. The only difference=
=0Abetween the two processors are in the CS_BNDS register parsing code, whi=
ch=0Ahas been changed so it will work on both processors.=0A=0AThe L2 cache=
 controller does not exist on the MPC83xx, but the OF subsystem=0Awill not =
use the driver if the device is not present in the OF device tree.=0A=0ASig=
ned-off-by: Ira W. Snyder <iws@ovro.caltech.edu>=0A---=0A=0AKumar, I had to=
 change the nr_pages calculation to make the math work=0Aout. I checked it =
on my board and did the math by hand for a 64GB 85xx=0Ausing 64K pages. In =
both cases, nr_pages * PAGE_SIZE comes out to the=0Acorrect value. Thanks f=
or the help.=0A=0Av1 -> v2:=0A=A0 * Use PAGE_SHIFT to parse cs_bnds regardl=
ess of board type=0A=A0 * Remove special-casing for the 83xx processor=0A=
=0A drivers/edac/Kconfig=A0 =A0 =A0 =A0 |=A0 =A0 6 +++---=0A drivers/edac/m=
pc85xx_edac.c |=A0=A0=A028 +++++++++++++++++++---------=0A 2 files changed,=
 22 insertions(+), 12 deletions(-)=0A=0Adiff --git a/drivers/edac/Kconfig b=
/drivers/edac/Kconfig=0Aindex 4339b1a..78303f9 100644=0A--- a/drivers/edac/=
Kconfig=0A+++ b/drivers/edac/Kconfig=0A@@ -176,11 +176,11 @@ config EDAC_I5=
100=0A =A0=A0=A0 =A0 San Clemente MCH.=0A =0A config EDAC_MPC85XX=0A-=A0=A0=
=A0 tristate "Freescale MPC85xx"=0A-=A0=A0=A0 depends on EDAC_MM_EDAC && FS=
L_SOC && MPC85xx=0A+=A0=A0=A0 tristate "Freescale MPC83xx / MPC85xx"=0A+=A0=
=A0=A0 depends on EDAC_MM_EDAC && FSL_SOC && (PPC_83xx || MPC85xx)=0A =A0=
=A0=A0 help=0A =A0=A0=A0 =A0 Support for error detection and correction on =
the Freescale=0A-=A0=A0=A0 =A0 MPC8560, MPC8540, MPC8548=0A+=A0=A0=A0 =A0 M=
PC8349, MPC8560, MPC8540, MPC8548=0A =0A config EDAC_MV64X60=0A =A0=A0=A0 t=
ristate "Marvell MV64x60"=0Adiff --git a/drivers/edac/mpc85xx_edac.c b/driv=
ers/edac/mpc85xx_edac.c=0Aindex b4f5c63..ba2a264 100644=0A--- a/drivers/eda=
c/mpc85xx_edac.c=0A+++ b/drivers/edac/mpc85xx_edac.c=0A@@ -43,7 +43,9 @@ st=
atic u32 orig_pci_err_en;=0A #endif=0A =0A static u32 orig_l2_err_disable;=
=0A+#ifdef CONFIG_MPC85xx=0A static u32 orig_hid1[2];=0A+#endif=0A =0A /***=
********************* MC SYSFS parts ***********************************/=
=0A =0A@@ -790,19 +792,20 @@ static void __devinit mpc85xx_init_csrows(stru=
ct mem_ctl_info *mci)=0A =A0=A0=A0 =A0=A0=A0 csrow =3D &mci->csrows[index];=
=0A =A0=A0=A0 =A0=A0=A0 cs_bnds =3D in_be32(pdata->mc_vbase + MPC85XX_MC_CS=
_BNDS_0 +=0A =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 (index * MPC85XX_M=
C_CS_BNDS_OFS));=0A-=A0=A0=A0 =A0=A0=A0 start =3D (cs_bnds & 0xfff0000) << =
4;=0A-=A0=A0=A0 =A0=A0=A0 end =3D ((cs_bnds & 0xfff) << 20);=0A-=A0=A0=A0 =
=A0=A0=A0 if (start)=0A-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 start |=3D 0xfffff;=
=0A-=A0=A0=A0 =A0=A0=A0 if (end)=0A-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 end |=3D =
0xfffff;=0A+=0A+=A0=A0=A0 =A0=A0=A0 start =3D (cs_bnds & 0xffff0000) >> 16;=
=0A+=A0=A0=A0 =A0=A0=A0 end=A0=A0=A0=3D (cs_bnds & 0x0000ffff);=0A =0A =A0=
=A0=A0 =A0=A0=A0 if (start =3D=3D end)=0A =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 con=
tinue;=A0=A0=A0 /* not populated */=0A =0A+=A0=A0=A0 =A0=A0=A0 start <<=3D =
(24 - PAGE_SHIFT);=0A+=A0=A0=A0 =A0=A0=A0 end=A0=A0=A0<<=3D (24 - PAGE_SHIF=
T);=0A+=A0=A0=A0 =A0=A0=A0 end=A0 =A0 |=3D (1 << (24 - PAGE_SHIFT)) - 1;=0A=
+=0A =A0=A0=A0 =A0=A0=A0 csrow->first_page =3D start >> PAGE_SHIFT;=0A =A0=
=A0=A0 =A0=A0=A0 csrow->last_page =3D end >> PAGE_SHIFT;=0A-=A0=A0=A0 =A0=
=A0=A0 csrow->nr_pages =3D csrow->last_page + 1 - csrow->first_page;=0A+=A0=
=A0=A0 =A0=A0=A0 csrow->nr_pages =3D end + 1 - start;=0A =A0=A0=A0 =A0=A0=
=A0 csrow->grain =3D 8;=0A =A0=A0=A0 =A0=A0=A0 csrow->mtype =3D mtype;=0A =
=A0=A0=A0 =A0=A0=A0 csrow->dtype =3D DEV_UNKNOWN;=0A@@ -986,6 +989,7 @@ sta=
tic struct of_device_id mpc85xx_mc_err_of_match[] =3D {=0A =A0=A0=A0 { .com=
patible =3D "fsl,mpc8560-memory-controller", },=0A =A0=A0=A0 { .compatible =
=3D "fsl,mpc8568-memory-controller", },=0A =A0=A0=A0 { .compatible =3D "fsl=
,mpc8572-memory-controller", },=0A+=A0=A0=A0 { .compatible =3D "fsl,mpc8349=
-memory-controller", },=0A =A0=A0=A0 {},=0A };=0A =0A@@ -1001,13 +1005,13 @=
@ static struct of_platform_driver mpc85xx_mc_err_driver =3D {=0A =A0=A0=A0=
 =A0=A0=A0 =A0=A0=A0},=0A };=0A =0A-=0A+#ifdef CONFIG_MPC85xx=0A static voi=
d __init mpc85xx_mc_clear_rfxe(void *data)=0A {=0A =A0=A0=A0 orig_hid1[smp_=
processor_id()] =3D mfspr(SPRN_HID1);=0A =A0=A0=A0 mtspr(SPRN_HID1, (orig_h=
id1[smp_processor_id()] & ~0x20000));=0A }=0A-=0A+#endif=0A =0A static int =
__init mpc85xx_mc_init(void)=0A {=0A@@ -1040,26 +1044,32 @@ static int __in=
it mpc85xx_mc_init(void)=0A =A0=A0=A0 =A0=A0=A0 printk(KERN_WARNING EDAC_MO=
D_STR "PCI fails to register\n");=0A #endif=0A =0A+#ifdef CONFIG_MPC85xx=0A=
 =A0=A0=A0 /*=0A =A0=A0=A0=A0=A0* need to clear HID1[RFXE] to disable machi=
ne check int=0A =A0=A0=A0=A0=A0* so we can catch it=0A =A0=A0=A0=A0=A0*/=0A=
 =A0=A0=A0 if (edac_op_state =3D=3D EDAC_OPSTATE_INT)=0A =A0=A0=A0 =A0=A0=
=A0 on_each_cpu(mpc85xx_mc_clear_rfxe, NULL, 0);=0A+#endif=0A =0A =A0=A0=A0=
 return 0;=0A }=0A =0A module_init(mpc85xx_mc_init);=0A =0A+#ifdef CONFIG_M=
PC85xx=0A static void __exit mpc85xx_mc_restore_hid1(void *data)=0A {=0A =
=A0=A0=A0 mtspr(SPRN_HID1, orig_hid1[smp_processor_id()]);=0A }=0A+#endif=
=0A =0A static void __exit mpc85xx_mc_exit(void)=0A {=0A+#ifdef CONFIG_MPC8=
5xx=0A =A0=A0=A0 on_each_cpu(mpc85xx_mc_restore_hid1, NULL, 0);=0A+#endif=
=0A #ifdef CONFIG_PCI=0A =A0=A0=A0 of_unregister_platform_driver(&mpc85xx_p=
ci_err_driver);=0A #endif=0A-- =0A1.5.4.3=0A=0A=0A-------------------------=
-----------------------------------------------------=0AEnter the BlackBerr=
y Developer Challenge=A0 =0AThis is your chance to win up to $100,000 in pr=
izes! For a limited time, =0Avendors submitting new applications to BlackBe=
rry App World(TM) will have=0Athe opportunity to enter the BlackBerry Devel=
oper Challenge. See full prize=A0 =0Adetails at: http://p.sf.net/sfu/Challe=
nge=0A_______________________________________________=0Abluesmoke-devel mai=
ling list=0Abluesmoke-devel@lists.sourceforge.net=0Ahttps://lists.sourcefor=
ge.net/lists/listinfo/bluesmoke-devel=0A
