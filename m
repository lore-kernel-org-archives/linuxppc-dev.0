Return-Path: <ken@kenmoffat.uklinux.net>
Received: from ppgpenguin.kenmoffat.uklinux.net
	(spc2-brig1-3-0-cust232.asfd.broadband.ntl.com [82.1.142.232])
	by ozlabs.org (Postfix) with ESMTP id 6BAC92BD6A
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2004 08:24:07 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by ppgpenguin.kenmoffat.uklinux.net (Postfix) with ESMTP id 7B2DE146E0
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2004 23:03:20 +0100 (BST)
Date: Fri, 17 Sep 2004 23:03:20 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: linuxppc-dev@ozlabs.org
Message-ID: <Pine.LNX.4.58.0409172249520.23520@ppg_penguin.kenmoffat.uklinux.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Subject: Problem with 745x errata in 2.6.8
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

 I'm trying to get the port to the AmigaOne/Teron into a fit state to
attempt to submit it.  I've got it working adequately in 2.6.7 (no ide
dma, obviously, and no floppy disk, plus other minor issues) but
obviously I need to get it up to the current version before asking for
your comments on what needs to be changed to make it acceptable.

 Unfortunately, the following changes in 2.6.8-rc3 stop my 7455 from
booting (with a vga console, it stops after the console: colour VGA+
80x25 message, and also the top of the screen is blank).  If I revert
these, it runs.  I'm totally out of my depth here, I don't even know how
to work out which sort of 7455 I've got, much less what this is all
doing.  Can anybody offer me some pointers, please ?

Ken

--- linux-2.6.8-rc2/arch/ppc/kernel/cputable.c=092004-09-17 15:26:38.000000=
000 +0100
+++ linux-2.6.8-rc3/arch/ppc/kernel/cputable.c=092004-09-17 15:27:45.000000=
000 +0100
@@ -55,7 +55,8 @@ extern void __setup_cpu_generic(unsigned
 #endif

 /* We need to mark all pages as being coherent if we're SMP or we
- * have a 754x and an MPC107 host bridge. */
+ * have a 754x and an MPC107 host bridge.
+ */
 #if defined(CONFIG_SMP) || defined(CONFIG_MPC10X_BRIDGE)
 #define CPU_FTR_COMMON                  CPU_FTR_NEED_COHERENT
 #else
@@ -263,7 +264,7 @@ struct cpu_spec=09cpu_specs[] =3D {
 =09CPU_FTR_COMMON |
     =09CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
 =09CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-=09CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450,
+=09CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NEED_COHERENT,
 =09COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 =0932, 32,
 =09__setup_cpu_745x
@@ -274,7 +275,7 @@ struct cpu_spec=09cpu_specs[] =3D {
     =09CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 =09CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 =09CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-=09CPU_FTR_L3_DISABLE_NAP,
+=09CPU_FTR_L3_DISABLE_NAP | CPU_FTR_NEED_COHERENT,
 =09COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 =0932, 32,
 =09__setup_cpu_745x
@@ -284,7 +285,8 @@ struct cpu_spec=09cpu_specs[] =3D {
 =09CPU_FTR_COMMON |
     =09CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 =09CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-=09CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR,
+=09CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
+=09CPU_FTR_NEED_COHERENT,
 =09COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 =0932, 32,
 =09__setup_cpu_745x
@@ -294,7 +296,8 @@ struct cpu_spec=09cpu_specs[] =3D {
 =09CPU_FTR_COMMON |
     =09CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
 =09CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-=09CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_HAS_HIGH_BATS,
+=09CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_HAS_HIGH_BATS |
+=09CPU_FTR_NEED_COHERENT,
 =09COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 =0932, 32,
 =09__setup_cpu_745x
@@ -305,7 +308,7 @@ struct cpu_spec=09cpu_specs[] =3D {
     =09CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 =09CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 =09CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-=09CPU_FTR_L3_DISABLE_NAP | CPU_FTR_HAS_HIGH_BATS,
+=09CPU_FTR_L3_DISABLE_NAP | CPU_FTR_NEED_COHERENT | CPU_FTR_HAS_HIGH_BATS,
 =09COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 =0932, 32,
 =09__setup_cpu_745x
@@ -316,18 +319,40 @@ struct cpu_spec=09cpu_specs[] =3D {
     =09CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 =09CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 =09CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-=09CPU_FTR_HAS_HIGH_BATS,
+=09CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
+=09COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
+=0932, 32,
+=09__setup_cpu_745x
+    },
+    {=09/* 7447/7457 Rev 1.0 */
+    =090xffffffff, 0x80020100, "7447/7457",
+=09CPU_FTR_COMMON |
+    =09CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
+=09CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
+=09CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
+=09CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC,
+=09COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
+=0932, 32,
+=09__setup_cpu_745x
+    },
+    {=09/* 7447/7457 Rev 1.1 */
+    =090xffffffff, 0x80020101, "7447/7457",
+=09CPU_FTR_COMMON |
+    =09CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
+=09CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
+=09CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
+=09CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC,
 =09COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 =0932, 32,
 =09__setup_cpu_745x
     },
-    {=09/* 7457 */
-    =090xffff0000, 0x80020000, "7457",
+    {=09/* 7447/7457 Rev 1.2 and later */
+    =090xffff0000, 0x80020000, "7447/7457",
 =09CPU_FTR_COMMON |
     =09CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 =09CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 =09CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-=09CPU_FTR_HAS_HIGH_BATS,
+=09CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
 =09COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 =0932, 32,
 =09__setup_cpu_745x
@@ -338,7 +363,7 @@ struct cpu_spec=09cpu_specs[] =3D {
     =09CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 =09CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP |
 =09CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-=09CPU_FTR_HAS_HIGH_BATS,
+=09CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
 =09COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 =0932, 32,
 =09__setup_cpu_745x
@@ -351,8 +376,8 @@ struct cpu_spec=09cpu_specs[] =3D {
 =0932, 32,
 =09__setup_cpu_603
     },
-    {=09/* 8280 is a G2_LE (603e core, plus some) */
-=090x7fff0000, 0x00820000, "8280",
+    {=09/* All G2_LE (603e core, plus some) have the same pvr */
+=090x7fff0000, 0x00820000, "G2_LE",
 =09CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 =09CPU_FTR_CAN_NAP | CPU_FTR_HAS_HIGH_BATS,
 =09COMMON_PPC,

--=20
 das eine Mal als Trag=F6die, das andere Mal als Farce
