Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1AB9BDDDF5
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 03:24:37 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id l1HGOXDN074046
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 16:24:33 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l1HGOWAJ1871940
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 17:24:32 +0100
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l1HGOWQF004016
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 17:24:32 +0100
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: paulus@samba.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	johnrose@us.ibm.com, Sylvain Munaut <tnt@246tnt.com>
Subject: [PATCH 2.6.21-rc1] powerpc: Make of_device_uevent() compatible with
	ibmebus
MIME-Version: 1.0
Date: Sat, 17 Feb 2007 17:28:15 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702171728.15597.hnguyen@linux.vnet.ibm.com>
Cc: fenkes@de.ibm.com, pmac@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ibmebus has a fake root device that's not associated with an ofdt node.
Filter out any such devices in of_device_uevent().


Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---


 of_device.c |    4 ++++
 1 files changed, 4 insertions(+)


diff -urp a/arch/powerpc/kernel/of_device.c b/arch/powerpc/kernel/of_device.c
--- a/arch/powerpc/kernel/of_device.c	2007-02-17 16:36:32.116368480 +0100
+++ b/arch/powerpc/kernel/of_device.c	2007-02-17 16:44:01.319366352 +0100
@@ -180,6 +180,10 @@ int of_device_uevent(struct device *dev,
 
 	ofdev = to_of_device(dev);
 
+	/* e.g. ibmebus has a fake root device w/o ofdt node -- filter that */
+	if (!ofdev->node)
+		return -ENODEV;
+
 	if (add_uevent_var(envp, num_envp, &i,
 			   buffer, buffer_size, &length,
 			   "OF_NAME=%s", ofdev->node->name))
