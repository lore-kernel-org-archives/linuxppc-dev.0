Return-Path: <olh@suse.de>
Received: from Cantor.suse.de (news.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 211CD67A83
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Feb 2005 23:40:22 +1100 (EST)
Date: Sun, 6 Feb 2005 13:40:14 +0100
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Message-ID: <20050206124014.GA5880@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: make -j12 all fails in uImage target
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


this is what I got with 2.6.11rc3:

make ARCH=ppc O=../O-2.6.11-rc3-b50-SMP -j12 all
...
  LD      vmlinux
  SYSMAP  System.map
  SYSMAP  .tmp_System.map
  OBJCOPY arch/ppc/boot/images/vmlinux.bin
  HOSTCC  arch/ppc/boot/utils/addnote
  HOSTCC  arch/ppc/boot/utils/mknote
  HOSTCC  arch/ppc/boot/utils/mkprep
  LD      arch/ppc/boot/lib/built-in.o
  HOSTCC  arch/ppc/boot/utils/hack-coff
  HOSTCC  arch/ppc/boot/utils/mkbugboot
  OBJCOPY arch/ppc/boot/images/vmlinux.bin
  GZIP    arch/ppc/boot/images/vmlinux.gz
/bin/sh: line 1: arch/ppc/boot/images/vmlinux.bin: No such file or directory
make[2]: *** [arch/ppc/boot/images/vmlinux.gz] Error 1
make[1]: *** [uImage] Error 2
make[1]: *** Waiting for unfinished jobs....

also, one time that zImage.chrp was only 570K instead of the expected
1.4M, so netboot failed. But I got no build error.
Any idea what dependency is missing?
