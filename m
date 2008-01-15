Return-Path: <mjw@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DDAF1DDE9A
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 08:06:13 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0FL69SD031218
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 16:06:09 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0FL61fr061038
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 14:06:02 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0FL60Jw023030
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 14:06:00 -0700
Received: from [9.76.8.226] (sig-9-76-8-226.mts.ibm.com [9.76.8.226])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m0FL5xdN022969
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 14:05:59 -0700
Message-ID: <478D2038.4090205@linux.vnet.ibm.com>
Date: Tue, 15 Jan 2008 15:06:00 -0600
From: Mike Wolf <mjw@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] change where the kernel loads
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: mjw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When netbooting a kernel with an initrd or initramfs that makes
the image larger than 8 meg the firmware will kick out the kernel 
and go to the second boot device.  However when the mkzimage 
script is used to create the image instead of 'make zImage' then 
the kernel/initrd will netboot.  So this patch changes boot/zImage.lds
to load the kernel at the same location that the mkzimage would set.

This has been boot tested on POWER5, POWER5+, blades and POWER6
systems successfully.

signed off by:  Mike Wolf (mjw@us.ibm.com)


------



--- linux-2.6.16.46-0.12.orig/arch/powerpc/boot/zImage.lds	2008-01-07 14:51:05.000000000 -0600
+++ linux-2.6.16.46-0.12/arch/powerpc/boot/zImage.lds	2008-01-07 14:31:14.000000000 -0600
@@ -2,7 +2,7 @@
 ENTRY(_zimage_start)
 SECTIONS
 {
-  . = (4*1024*1024);
+  . = (64*1024);
   _start = .;
   .text      :
   {
