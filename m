Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B6A5BDDED2
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 23:43:40 +1000 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m3BDhYUK015119
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 15:43:34 +0200
Message-ID: <014701c89bda$09380060$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: zImage.embedded
Date: Fri, 11 Apr 2008 15:43:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello all,

I'm not sure what kind of error this is. I'm trying to generate a kernel 
image suitable for network boot and it seems to fail at the very end (wrong 
target ?)

$ make ARCH=ppc CROSS_COMPILE=powerpc-linux-uclibc-  znetboot

powerpc-linux-uclibc-objcopy -O elf32-powerpc arch/ppc/boot/simple/zvmlinux 
arch/ppc/boot/simple/zvmlinux -R .comment -R .stab \
                -R .stabstr -R .ramdisk
cp -f arch/ppc/boot/simple/zvmlinux arch/ppc/boot/images/zImage.elf
rm -f arch/ppc/boot/simple/zvmlinux
cp arch/ppc/boot/images/zImage.embedded /tftpboot/zImage.embedded
cp: cannot stat `arch/ppc/boot/images/zImage.embedded': No such file or 
directory
make[2]: *** [znetboot] Error 1
make[1]: *** [simple] Error 2
make: *** [znetboot] Error 2

is the file zImage.elf my proper network image ?
-- 
Guillaume Dargaud
http://www.gdargaud.net/
