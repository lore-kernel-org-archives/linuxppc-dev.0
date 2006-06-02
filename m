Return-Path: <mjw@us.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9372567A3D
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jun 2006 01:06:25 +1000 (EST)
Received: from e3.ny.us.ibm.com ([192.168.1.103])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k52Ero2w010936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jun 2006 10:53:51 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k52ErjpS017738
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jun 2006 10:53:45 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k52Erjqs097270
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jun 2006 10:53:45 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k52ErjvZ024988
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jun 2006 10:53:45 -0400
Subject: [PATCH] fix make rpm for powerpc
From: Mike Wolf <mjw@us.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 02 Jun 2006 09:53:42 -0500
Message-Id: <1149260023.13835.5.camel@localhost.localdomain>
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

The default target for most powerpc platforms is zImage.  The
zImage however is in arch/powerpc/boot and the mkspec script
was set up to get the kernel from the top level of the kernel 
tree.  This patch copies vmlinux to arch/powerpc/boot and then
copies the kernel to the tmp directory so the rpm can be made.

Signed-off-by: Mike Wolf <mjw@us.ibm.com>


=============

--- linux.orig/scripts/package/mkspec	2006-05-21 23:22:53.000000000 -0500
+++ linux/scripts/package/mkspec	2006-05-22 15:13:56.000000000 -0500
@@ -73,8 +73,13 @@
 echo 'cp $KBUILD_IMAGE $RPM_BUILD_ROOT'"/boot/efi/vmlinuz-$KERNELRELEASE"
 echo 'ln -s '"efi/vmlinuz-$KERNELRELEASE" '$RPM_BUILD_ROOT'"/boot/"
 echo "%else"
+echo "%ifarch ppc64"
+echo "cp vmlinux arch/powerpc/boot"
+echo "cp arch/powerpc/boot/"'$KBUILD_IMAGE $RPM_BUILD_ROOT'"/boot/vmlinuz-$KERNELRELEASE"
+echo "%else"
 echo 'cp $KBUILD_IMAGE $RPM_BUILD_ROOT'"/boot/vmlinuz-$KERNELRELEASE"
 echo "%endif"
+echo "%endif"
 
 echo 'cp System.map $RPM_BUILD_ROOT'"/boot/System.map-$KERNELRELEASE"
 
