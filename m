Return-Path: <nkbj@mail.tele.dk>
Received: from fep33.mail.dk (fep33.mail.dk [80.160.76.197])
	by ozlabs.org (Postfix) with ESMTP id B650767A64
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Jul 2006 21:25:47 +1000 (EST)
Received: from fep41.mail.dk ([195.41.46.142]) by fep31.mail.dk
	(InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
	id <20060702110225.HQDF16980.fep31.mail.dk@fep41.mail.dk>
	for <linuxppc-dev@ozlabs.org>; Sun, 2 Jul 2006 13:02:25 +0200
Received: from [87.51.138.48] by fep41.mail.dk
	(InterMail vG.2.02.00.00 201-2161-120-101-20051020) with ESMTP
	id <20060702110225.QOFI29058.fep41.mail.dk@[87.51.138.48]>
	for <linuxppc-dev@ozlabs.org>; Sun, 2 Jul 2006 13:02:25 +0200
Subject: [PATCH 2.6.17] Add -fno-stack-protector to BOOTCFLAGS in
	arch/powerpc/boot/Makefile.
From: Niels Kristian Bech Jensen <nkbj@mail.tele.dk>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/mixed; boundary="=-6NX6yiI5jUwIUvPG94Qn"
Date: Sun, 02 Jul 2006 13:02:27 +0200
Message-Id: <1151838148.7311.5.camel@plutonium.opasia.dk>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-6NX6yiI5jUwIUvPG94Qn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I got some undefined references to __stack_chk_fail in
arch/powerpc/boot/stdio.o and arch/powerpc/boot/prom.o when I was trying
to build a kernel on Ubuntu Edgy Eft - which includes Stack Smashing
Protection.

This patch adds -fno-stack-protector to BOOTCFLAGS in
arch/powerpc/boot/Makefile (why does BOOTCFLAGS depend on HOSTCFLAGS and
not CFLAGS?).

Regards,
Niels Kristian Bech Jensen


--=-6NX6yiI5jUwIUvPG94Qn
Content-Disposition: attachment; filename=powerpc-2.6.17.diff
Content-Type: text/x-patch; name=powerpc-2.6.17.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-source-2.6.17/arch/powerpc/boot/Makefile~	2006-06-29 03:23:03.000000000 +0200
+++ linux-source-2.6.17/arch/powerpc/boot/Makefile	2006-07-02 12:44:34.000000000 +0200
@@ -41,6 +41,10 @@ src-boot += $(zlib)
 src-boot := $(addprefix $(obj)/, $(src-boot))
 obj-boot := $(addsuffix .o, $(basename $(src-boot)))
 
+ifeq ($(call cc-option-yn, -fstack-protector),y)
+BOOTCFLAGS	+= -fno-stack-protector
+endif
+
 BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj)
 
 quiet_cmd_copy_zlib = COPY    $@

--=-6NX6yiI5jUwIUvPG94Qn--
