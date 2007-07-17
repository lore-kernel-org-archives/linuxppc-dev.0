Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F0550DDF38
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 04:32:55 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l6HIRBUQ001629
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 14:27:11 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6HIWnP6202916
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 12:32:49 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6HIWmWN013692
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 12:32:49 -0600
Received: from [9.10.86.36] (weaponx.rchland.ibm.com [9.10.86.36])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l6HIWmdw013649
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 12:32:48 -0600
Message-Id: <20070717182621.624622000@linux.vnet.ibm.com>>
References: <20070717181547.310201000@linux.vnet.ibm.com>>
Date: Tue, 17 Jul 2007 13:15:53 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [patch 06/14] 40x decrementer fixes
In-Reply-To: <20070717181547.310201000@linux.vnet.ibm.com>>
Content-Type: text/plain
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Allow generic_calibrate_decr to work for 40x platforms.  Given that the hardware
behavior is identical, this also changes the set_dec function to reload the PIT
on 40x to match the behavior 44x currently has.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/kernel/time.c |    2 +-
 include/asm-powerpc/time.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.orig/arch/powerpc/kernel/time.c
+++ linux-2.6/arch/powerpc/kernel/time.c
@@ -866,7 +866,7 @@ void __init generic_calibrate_decr(void)
 				"(not found)\n");
 	}
 
-#ifdef CONFIG_BOOKE
+#if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
 	/* Set the time base to zero */
 	mtspr(SPRN_TBWL, 0);
 	mtspr(SPRN_TBWU, 0);
--- linux-2.6.orig/include/asm-powerpc/time.h
+++ linux-2.6/include/asm-powerpc/time.h
@@ -174,7 +174,7 @@ static inline unsigned int get_dec(void)
 static inline void set_dec(int val)
 {
 #if defined(CONFIG_40x)
-	return;		/* Have to let it auto-reload */
+	mtspr(SPRN_PIT, val);
 #elif defined(CONFIG_8xx_CPU6)
 	set_dec_cpu6(val);
 #else

-- 
