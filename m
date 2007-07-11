Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C0643DDEA3
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 23:57:32 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6BDvUfU031006
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 09:57:30 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6BDvTfQ067294
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 07:57:29 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6BDvTMY012235
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 07:57:29 -0600
Subject: [RFC][PATCH 4/8] 4xx decrementer fixes
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 11 Jul 2007 08:57:28 -0500
Message-Id: <1184162248.32199.61.camel@weaponx.rchland.ibm.com>
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
