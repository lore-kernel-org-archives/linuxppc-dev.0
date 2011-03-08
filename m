Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2A9BB6F0B
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2011 17:37:40 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p286be7j009434
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:40 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p286bd7H2584828
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:39 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p286bdJx005169
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:39 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/18] powerpc/pmac/smp: Remove HMT changes for PowerMac
	offline code
Date: Tue,  8 Mar 2011 17:37:22 +1100
Message-Id: <1299566250-10516-11-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1299566250-10516-1-git-send-email-benh@kernel.crashing.org>
References: <1299566250-10516-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Those instructions do nothing on non-threaded processors such
as 970's used on those machines.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powermac/smp.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 50e15b4..53bee66 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -928,10 +928,6 @@ static void pmac_cpu_die(void)
 		/* should always be true at this point */
 		if (cpu_has_feature(CPU_FTR_CAN_NAP))
 			power4_cpu_offline_powersave();
-		else {
-			HMT_low();
-			HMT_very_low();
-		}
 	}
 }
 
-- 
1.7.1
