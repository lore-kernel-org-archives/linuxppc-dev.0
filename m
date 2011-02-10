Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 94126B711E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Feb 2011 08:57:37 +1100 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p1ALltxO004092
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Feb 2011 16:48:12 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 9718D4DE8041
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Feb 2011 16:56:41 -0500 (EST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p1ALvXK5416170
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Feb 2011 16:57:33 -0500
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p1ALvW2R028453
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Feb 2011 14:57:32 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH powerpc 1/2] powerpc: protect per-CPU access with
	preempt_disable
Date: Thu, 10 Feb 2011 13:57:26 -0800
Message-Id: <1297375047-18608-1-git-send-email-paulmck@linux.vnet.ibm.com>
In-Reply-To: <20110210215710.GA18429@linux.vnet.ibm.com>
References: <20110210215710.GA18429@linux.vnet.ibm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hpte_need_flush() function accesses the ppc64_tlb_batch per-CPU
variable with preemption enabled, a bug that this patch fixes.  Perhaps
crudely.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable-ppc64.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 2b09cd5..6ed08ab 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -228,8 +228,11 @@ static inline unsigned long pte_update(struct mm_struct *mm,
 		assert_pte_locked(mm, addr);
 
 #ifdef CONFIG_PPC_STD_MMU_64
-	if (old & _PAGE_HASHPTE)
+	if (old & _PAGE_HASHPTE) {
+		preempt_disable();
 		hpte_need_flush(mm, addr, ptep, old, huge);
+		preempt_enable();
+	}
 #endif
 
 	return old;
-- 
1.7.3.2
