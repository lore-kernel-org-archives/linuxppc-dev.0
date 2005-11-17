Return-Path: <Fabien.Clement@thomson.net>
Received: from dmzraw5.extranet.tce.com (dmzraw5.extranet.tce.com
	[157.254.234.142]) by ozlabs.org (Postfix) with ESMTP id 5403B6877C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Nov 2005 04:54:35 +1100 (EST)
Received: from indyvss2.am.thmulti.com (unknown [157.254.92.61])
	by dmzraw5.extranet.tce.com (Postfix) with ESMTP id 444F21A3F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Nov 2005 17:54:33 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by indyvss2.am.thmulti.com (Postfix) with ESMTP id 386BE25438
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Nov 2005 17:54:33 +0000 (GMT)
Received: from indyvss2.am.thmulti.com ([127.0.0.1])
	by localhost (indyvss2 [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 02539-01-52 for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Nov 2005 17:54:31 +0000 (GMT)
Received: from smtprelay2.indy.tce.com (smtprelay2.indy.tce.com
	[157.254.96.95])
	by indyvss2.am.thmulti.com (Postfix) with ESMTP id 0B75A2542D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Nov 2005 17:54:31 +0000 (GMT)
Received: from boulsmailbh01.eu.thmulti.com (localhost [127.0.0.1])
	by smtprelay2.indy.tce.com (8.12.9/8.12.8) with ESMTP id jAHHsTH2013083
	for <linuxppc-embedded@ozlabs.org>; Thu, 17 Nov 2005 17:54:30 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 17 Nov 2005 18:54:28 +0100
Message-ID: <9C1918067C3BC14C9C351C206D8A843701F7F86D@rennsmail03.eu.thmulti.com>
From: "Clement Fabien" <Fabien.Clement@thomson.net>
To: <linuxppc-embedded@ozlabs.org>
Subject: Depmod crash when installing modules
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi=20

As anyone here previously encountered a "segmentation fault" on depmod
when trying to install modules?

I'm building a 2.6.13, with Alex Zeffertt PQ2 Sar driver + atm modules,
and I've got a nice crash (see following)

make[1]: `arch/ppc/kernel/asm-offsets.s' is up to date.
  Building modules, stage 2.
  MODPOST
  CC      net/atm/atm.mod.o
  CC      net/atm/br2684.mod.o
  CC      net/atm/clip.mod.o
  LD [M]  net/atm/atm.ko
  LD [M]  net/atm/clip.ko
  LD [M]  net/atm/br2684.ko

make modules_install INSTALL_MOD_PATH=3D/home/xxx/Atm/
  INSTALL net/atm/atm.ko
  INSTALL net/atm/br2684.ko
  INSTALL net/atm/clip.ko
if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F
System.map -b /home/xxx/Atm/ -r 2.6.13; fi
/bin/sh: line 1:  8902 Segmentation fault      /sbin/depmod -ae -F
System.map -b /home/xxx/Atm/ -r 2.6.13
make: *** [_modinst_post] Error 139


With  depmod -V =3D> module-init-tools 3.1-pre5


Fabien.
