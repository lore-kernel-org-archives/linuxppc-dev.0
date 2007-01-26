Return-Path: <Tony.Li@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id C1F6FDE039
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 19:00:13 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l0Q80CiO028909
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 01:00:12 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l0Q809nA023338
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 02:00:10 -0600 (CST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7411F.FF806127"
Subject: [PATCH]Disable early console in default to avoid printing boot
	message twice
Date: Fri, 26 Jan 2007 16:00:08 +0800
Message-ID: <995B09A8299C2C44B59866F6391D26356C26C3@zch01exm21.fsl.freescale.net>
From: "Li Tony-r64360" <Tony.Li@freescale.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7411F.FF806127
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The early console is default enable in powerpc 32 now.
This cause the boot message from beginning to console_init() printed
twice.
The early console is useful only when the kernel dead before
console_init.
The patch make the early console optional and disable the early console
in default.
The patch has been tested on mpc8313erdb board
=20
Signed-off-by: Li Tony <tony.li@freescale.com>

---
 arch/powerpc/Kconfig           |    2 +-
 arch/powerpc/kernel/setup_32.c |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)
=20
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 0673dbe..0c18951 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -59,7 +59,7 @@ config PPC
=20
 config EARLY_PRINTK
  bool
- default y
+ default t
=20
 config COMPAT
  bool
diff --git a/arch/powerpc/kernel/setup_32.c
b/arch/powerpc/kernel/setup_32.c
index a4c2964..71eb320 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -242,8 +242,10 @@ void __init setup_arch(char **cmdline_p)
=20
  smp_setup_cpu_maps();
=20
+#ifdef CONFIG_EARLY_PRINTK
  /* Register early console */
  register_early_udbg_console();
+#endif
=20
  xmon_setup();
=20
--=20
1.4.2
=20
=20

------_=_NextPart_001_01C7411F.FF806127
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3020" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D309414009-25012007>The =
early console is=20
default enable in powerpc 32 now.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D309414009-25012007>This =
cause the boot=20
message from beginning to console_init() printed =
twice.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D309414009-25012007>The =
early console is=20
useful only when the kernel dead before =
console_init.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D309414009-25012007>The =
patch&nbsp;<SPAN=20
class=3D525140007-26012007>make the early console optional and =
</SPAN>disable the=20
early console<SPAN class=3D525140007-26012007> in=20
default.</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D309414009-25012007><SPAN=20
class=3D525140007-26012007>The patch has been tested on mpc8313erdb=20
board</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D309414009-25012007><SPAN=20
class=3D525140007-26012007></SPAN></SPAN></FONT><FONT face=3DArial =
size=3D2><SPAN=20
class=3D309414009-25012007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D309414009-25012007>Signed-off-by:=20
Li&nbsp;Tony &lt;<A title=3Dmailto:tony.li@freescale.com=20
href=3D"mailto:tony.li@freescale.com">tony.li@freescale.com</A>&gt;<BR></=
SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D309414009-25012007>---<BR></SPAN></FONT><FONT face=3DArial =
size=3D2><SPAN=20
class=3D309414009-25012007>&nbsp;arch/powerpc/Kconfig&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 2 +-<BR>&nbsp;arch/powerpc/kernel/setup_32.c=20
|&nbsp;&nbsp;&nbsp; 2 ++<BR>&nbsp;2 files changed, 3 insertions(+), 1=20
deletions(-)</SPAN></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D309414009-25012007>diff =
--git=20
a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig<BR>index 0673dbe..0c18951=20
100644<BR>--- a/arch/powerpc/Kconfig<BR>+++ b/arch/powerpc/Kconfig<BR>@@ =
-59,7=20
+59,7 @@ config PPC<BR>&nbsp;<BR>&nbsp;config=20
EARLY_PRINTK<BR>&nbsp;&nbsp;bool<BR>-&nbsp;default y<BR>+&nbsp;default=20
t<BR>&nbsp;<BR>&nbsp;config COMPAT<BR>&nbsp;&nbsp;bool<BR>diff --git=20
a/arch/powerpc/kernel/setup_32.c =
b/arch/powerpc/kernel/setup_32.c<BR>index=20
a4c2964..71eb320 100644<BR>--- a/arch/powerpc/kernel/setup_32.c<BR>+++=20
b/arch/powerpc/kernel/setup_32.c<BR>@@ -242,8 +242,10 @@ void __init=20
setup_arch(char=20
**cmdline_p)<BR>&nbsp;<BR>&nbsp;&nbsp;smp_setup_cpu_maps();<BR>&nbsp;<BR>=
+#ifdef=20
CONFIG_EARLY_PRINTK<BR>&nbsp;&nbsp;/* Register early console=20
*/<BR>&nbsp;&nbsp;register_early_udbg_console();<BR>+#endif<BR>&nbsp;<BR>=
&nbsp;&nbsp;xmon_setup();<BR>&nbsp;<BR>--=20
<BR>1.4.2</SPAN></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D309414009-25012007></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C7411F.FF806127--
