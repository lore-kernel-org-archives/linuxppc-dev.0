Return-Path: <nfont@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DE00ADE109
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 07:37:01 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m16KavZm019348
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 15:36:57 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m16KarXe189088
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 13:36:55 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m16KarVf013890
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 13:36:53 -0700
Received: from austin.ibm.com (netmail1.austin.ibm.com [9.41.248.175])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m16Kar3T013866
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 13:36:53 -0700
Received: from [9.53.40.161] (dyn95340161.austin.ibm.com [9.53.40.161])
	by austin.ibm.com (8.13.8/8.12.10) with ESMTP id m16Kaq5H044084
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 14:36:53 -0600
Message-ID: <47AA1A86.7010604@austin.ibm.com>
Date: Wed, 06 Feb 2008 14:37:26 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4][POWERPC] Update irq descriptor affinity
Content-Type: multipart/mixed; boundary="------------070505070609030004060703"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070505070609030004060703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The affinity mask in the virq descriptor needs to be set before we reset the 
affinity for the virq.  Without doing this the call to get the new irq server
fails and we end up leaving the virq pinned to the cpu we are removing.

This does not fail the cpu remove from the kernel, but it does prevent cpu dlpar
remove operations from returning the cpu to the hypervisor.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

---

--------------070505070609030004060703
Content-Type: text/x-patch;
 name="irq_mapping.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="irq_mapping.patch"

Index: linux-2.6/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/xics.c	2008-02-04 14:27:43.000000000 -0600
+++ linux-2.6/arch/powerpc/platforms/pseries/xics.c	2008-02-05 10:40:06.000000000 -0600
@@ -880,8 +880,8 @@
 		       virq, cpu);
 
 		/* Reset affinity to all cpus */
+		irq_desc[virq].affinity = CPU_MASK_ALL;
 		desc->chip->set_affinity(virq, CPU_MASK_ALL);
-		irq_desc[irq].affinity = CPU_MASK_ALL;
 unlock:
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}

--------------070505070609030004060703--
