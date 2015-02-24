Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF83A1A0D1F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 11:10:24 +1100 (AEDT)
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DD4E3140134
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2015 11:10:23 +1100 (AEDT)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Mon, 23 Feb 2015 19:10:20 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id C0B74C9003E
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2015 19:01:28 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1O0AHdp19202202
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2015 00:10:17 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1O0AH4l006782
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2015 19:10:17 -0500
Received: from oc2861555856.ibm.com ([9.80.34.71])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t1O0AEf6006194
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2015 19:10:14 -0500
Message-ID: <54EBC165.3020708@linux.vnet.ibm.com>
Date: Mon, 23 Feb 2015 18:10:13 -0600
From: "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Export __spin_yield
References: <1424477465-9199-2-git-send-email-warrier@linux.vnet.ibm.com>
In-Reply-To: <1424477465-9199-2-git-send-email-warrier@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Export __spin_yield so that the arch_spin_unlock() function
can be invoked from a module.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
 arch/powerpc/lib/locks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
index bb7cfec..d100de8 100644
--- a/arch/powerpc/lib/locks.c
+++ b/arch/powerpc/lib/locks.c
@@ -41,6 +41,7 @@ void __spin_yield(arch_spinlock_t *lock)
 	plpar_hcall_norets(H_CONFER,
 		get_hard_smp_processor_id(holder_cpu), yield_count);
 }
+EXPORT_SYMBOL(__spin_yield);

 /*
  * Waiting for a read lock or a write lock on a rwlock...
-- 
1.8.3.4
