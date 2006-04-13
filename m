Return-Path: <cel@us.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 16DF6679EB
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 10:06:34 +1000 (EST)
Received: from e32.co.us.ibm.com (e32.boulder.ibm.com [9.17.249.42])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3DNA8rR022009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 19:10:08 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3DN9tCF002145
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 19:09:55 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3DN6NQC240350
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 17:06:23 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3DN9sbJ024228
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 17:09:54 -0600
Subject: patch for powerpc lparcfg.c
From: Carl Love <cel@us.ibm.com>
To: linuxppc-dev@ozlabs.org, cel@us.ibm.com
Content-Type: multipart/mixed; boundary="=-VL1Rbsx05AuPe/20uWeJ"
Date: Thu, 13 Apr 2006 16:09:53 -0700
Message-Id: <1144969793.5286.10.camel@dyn9047021119.beaverton.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-VL1Rbsx05AuPe/20uWeJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


I created the attached patch to print the partition name along with the
other partition information reported in /proc/ppc64/lparcfg for the
powerpc systems.  The patch adds a single line of code to the
arch/powerpc/kernel/lparcfg.c file.  I tested the code on a power5 box.
I would suggest adding the same line to the I series code at line 101 so
the partition name is printed on I series hardware as well.  Since I
don't have access to I series hardware to test on I did not include this
change in my patch file.

Carl Love

 

--=-VL1Rbsx05AuPe/20uWeJ
Content-Disposition: attachment; filename=linux-2.6.17-rc1-git8-lparcfg.patch
Content-Type: text/x-patch; name=linux-2.6.17-rc1-git8-lparcfg.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -rauN -X /home/carll/dontdiff linux-2.6.17-rc1-git8/arch/powerpc/kernel/lparcfg.c linux-2.6.17-rc1-git8-new/arch/powerpc/kernel/lparcfg.c
--- linux-2.6.17-rc1-git8/arch/powerpc/kernel/lparcfg.c	2006-04-13 12:25:11.000000000 -0700
+++ linux-2.6.17-rc1-git8-new/arch/powerpc/kernel/lparcfg.c	2006-04-13 15:29:02.000000000 -0700
@@ -360,6 +360,9 @@
 
 	seq_printf(m, "system_type=%s\n", model);
 
+	seq_printf(m, "partition_name=%s\n",
+		   get_property(rootdn, "ibm,partition-name", NULL));
+
 	seq_printf(m, "partition_id=%d\n", (int)lp_index);
 
 	rtas_node = find_path_device("/rtas");

--=-VL1Rbsx05AuPe/20uWeJ--
