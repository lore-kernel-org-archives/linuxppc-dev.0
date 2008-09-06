Return-Path: <hugh@veritas.com>
Received: from extu-mxob-1.symantec.com (extu-mxob-1.symantec.com
	[216.10.194.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "extu-mxob-1.symantec.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 71EEFDDDDC
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Sep 2008 09:35:24 +1000 (EST)
Date: Sun, 7 Sep 2008 00:35:48 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: fix rare boot build breakage
Message-ID: <Pine.LNX.4.64.0809070031440.5065@blonde.site>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1736752567-1220744148=:5065"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1736752567-1220744148=:5065
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

A make -j20 powerpc kernel build broke a couple of months ago saying:
In file included from arch/powerpc/boot/gunzip_util.h:13,
                 from arch/powerpc/boot/prpmc2800.c:21:
arch/powerpc/boot/zlib.h:85: error: expected =E2=80=98:=E2=80=99, =E2=80=98=
,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98}=E2=80=99 or =E2=80=98__attribut=
e__=E2=80=99 before =E2=80=98*=E2=80=99 token
arch/powerpc/boot/zlib.h:630: warning: type defaults to =E2=80=98int=E2=80=
=99 in declaration of =E2=80=98Byte=E2=80=99
arch/powerpc/boot/zlib.h:630: error: expected =E2=80=98;=E2=80=99, =E2=80=
=98,=E2=80=99 or =E2=80=98)=E2=80=99 before =E2=80=98*=E2=80=99 token

It happened again yesterday: too rare for me to confirm the fix, but
it looks like the list of dependants on gunzip_util.h was incomplete.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/powerpc/boot/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 2.6.27-rc5/arch/powerpc/boot/Makefile=092008-07-29 04:24:27.000000000 +=
0100
+++ linux/arch/powerpc/boot/Makefile=092008-09-06 18:28:29.000000000 +0100
@@ -49,7 +49,7 @@ zlib       :=3D inffast.c inflate.c inftre
 zlibheader :=3D inffast.h inffixed.h inflate.h inftrees.h infutil.h
 zliblinuxheader :=3D zlib.h zconf.h zutil.h
=20
-$(addprefix $(obj)/,$(zlib) gunzip_util.o main.o): \
+$(addprefix $(obj)/,$(zlib) cuboot-c2k.o gunzip_util.o main.o prpmc2800.o)=
: \
 =09$(addprefix $(obj)/,$(zliblinuxheader)) $(addprefix $(obj)/,$(zlibheade=
r))
=20
 src-libfdt :=3D fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c
--8323584-1736752567-1220744148=:5065--
