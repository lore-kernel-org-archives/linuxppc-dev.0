Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ECCDFDDEF8
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 00:47:35 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l4EEi0ON019798
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 10:44:00 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4EElW95270218
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 08:47:32 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4EElWff031888
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 08:47:32 -0600
Subject: treeImage.initrd rule is very broken
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: dwg@au1.ibm.com
Content-Type: text/plain
Date: Mon, 14 May 2007 09:47:13 -0500
Message-Id: <1179154033.3420.13.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi David,

I tried compiling an Ebony kernel wrapped with a DTS and initrd this
morning but it fails with the following error:

WRAP    arch/powerpc/boot/treeImage.initrd.ebony
DTC: dts->dtb  on file "/home/jwboyer/src/linux-2.6/arch/powerpc/boot/dts/ebony.dts"
powerpc-440-linux-gnu-ld: arch/powerpc/boot/treeboot-initrd.ebony.o: No such file: No such file or directory
powerpc-440-linux-gnu-nm: 'arch/powerpc/boot/treeImage.initrd.ebony': No such file
powerpc-440-linux-gnu-objdump: 'arch/powerpc/boot/treeImage.initrd.ebony': No such file
mv: cannot stat `arch/powerpc/boot/treeImage.initrd.ebony': No such file or directory
stat: No such file or directory
ln: accessing `arch/powerpc/boot/treeImage.initrd.ebony': No such file or directory
make[1]: *** [arch/powerpc/boot/zImage.initrd] Error 1
make: *** [zImage.initrd] Error 2

At first glance, it should be looking for treeboot-ebony.o, not
treeboot-initrd.ebony.o.  On a whim, I symlinked treeboot-initrd.ebony.o
to treeboot-ebony.o and the compile worked, however the wrapper wasn't
called with the ramdisk.image.gz file:

 /bin/sh /home/jwboyer/src/linux-2.6/arch/powerpc/boot/wrapper -c -o arch/powerpc/boot/treeImage.initrd.ebony -p treeboot-initrd.ebony -C "powerpc-440-linux-gnu-"  -s /home/jwboyer/src/linux-2.6/arch/powerpc/boot/dts/ebony.dts vmlinux
DTC: dts->dtb  on file "/home/jwboyer/src/linux-2.6/arch/powerpc/boot/dts/ebony.dts"

So something is very broken with this rule.  I poked at it for a while,
but I apparently don't have the make-fu to figure out how to un-break
it.

Help?

josh
