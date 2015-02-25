Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D9861A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 10:24:57 +1100 (AEDT)
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B01EB1400B6
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2015 10:24:56 +1100 (AEDT)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Wed, 25 Feb 2015 16:24:54 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 7A4D619D8026
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2015 16:16:00 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1PNOfGi31129822
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2015 16:24:49 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1PNOJUm007871
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2015 16:24:19 -0700
Received: from oc2861555856.ibm.com (sig-9-77-143-41.ibm.com [9.77.143.41])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t1PNOIIa006905
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2015 16:24:18 -0700
Message-ID: <54EE5989.7010800@linux.vnet.ibm.com>
Date: Wed, 25 Feb 2015 17:23:53 -0600
From: "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Export __spin_yield
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Export __spin_yield so that the arch_spin_unlock() function can
be invoked from a module. This will be required for modules where
we want to take a lock that is also is acquired in hypervisor
real mode. Because we want to avoid running any lockdep code
(which may not be safe in real mode), this lock needs to be 
an arch_spinlock_t instead of a normal spinlock.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
Replaced export to EXPORT_SYMBOL_GPL
Updated commit log to explain what kind of modules will need
to use the arch_spin_unlock() function

 arch/powerpc/lib/locks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
index bb7cfec..f31bcee 100644
--- a/arch/powerpc/lib/locks.c
+++ b/arch/powerpc/lib/locks.c
@@ -41,6 +41,7 @@ void __spin_yield(arch_spinlock_t *lock)
 	plpar_hcall_norets(H_CONFER,
 		get_hard_smp_processor_id(holder_cpu), yield_count);
 }
+EXPORT_SYMBOL_GPL(__spin_yield);
 
 /*
  * Waiting for a read lock or a write lock on a rwlock...
-- 
1.8.3.4
