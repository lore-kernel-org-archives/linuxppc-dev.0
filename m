Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 578162C008D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 18:51:29 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Fri, 25 Jan 2013 17:46:06 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7B8192BB004A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 18:51:23 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0P7dOkn6685038
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 18:39:25 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0P7pLv7022827
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 18:51:22 +1100
Message-ID: <1359100273.2666.51.camel@ThinkPad-T5421.cn.ibm.com>
Subject: [PATCH v2 powerpc ] Avoid debug_smp_processor_id() check in
 SHARED_PROCESSOR
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 25 Jan 2013 15:51:13 +0800
In-Reply-To: <1359063889.29726.36.camel@pasglop>
References: <1353305799.3694.9.camel@ThinkPad-T5421.cn.ibm.com>
 <1357797726.4838.89.camel@pasglop>
 <1357808418.10378.16.camel@ThinkPad-T5421.cn.ibm.com>
 <1358999231.29726.9.camel@pasglop>
 <1359022384.2666.46.camel@ThinkPad-T5421.cn.ibm.com>
 <1359063889.29726.36.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use local_paca directly in macro SHARED_PROCESSOR, as all processors
have the same value for the field shared_proc, so we don't need care
racy here.

Reported-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/spinlock.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 7124fc0..5b23f91 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -96,7 +96,7 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
 
 #if defined(CONFIG_PPC_SPLPAR)
 /* We only yield to the hypervisor if we are in shared processor mode */
-#define SHARED_PROCESSOR (get_lppaca()->shared_proc)
+#define SHARED_PROCESSOR (local_paca->lppaca_ptr->shared_proc)
 extern void __spin_yield(arch_spinlock_t *lock);
 extern void __rw_yield(arch_rwlock_t *lock);
 #else /* SPLPAR */
-- 
1.7.1
