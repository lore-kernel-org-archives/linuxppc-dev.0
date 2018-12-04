Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458FEC04EBF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 22:55:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C083F2081C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 22:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C083F2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438cdN5SbHzDqWs
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 09:55:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zytor.com
 (client-ip=198.137.202.136; helo=mail.zytor.com;
 envelope-from=tipbot@zytor.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=zytor.com
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438cb83Y2kzDqV6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 09:53:08 +1100 (AEDT)
Received: from terminus.zytor.com (localhost [127.0.0.1])
 by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB4M6DJ21030974
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 4 Dec 2018 14:06:13 -0800
Received: (from tipbot@localhost)
 by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB4M6CN31030970;
 Tue, 4 Dec 2018 14:06:12 -0800
Date: Tue, 4 Dec 2018 14:06:12 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to
 tipbot@zytor.com using -f
From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-04229110adfba984950fc0209632640a76eb1de4@git.kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/rcu] powerpc: Convert hugepd_free() to use call_rcu()
Git-Commit-ID: 04229110adfba984950fc0209632640a76eb1de4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Precedence: bulk
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Reply-To: tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, hpa@zytor.com,
 mingo@kernel.org, paulmck@linux.ibm.com, mpe@ellerman.id.au, paulus@samba.org,
 benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Cc: paulus@samba.org, hpa@zytor.com, tglx@linutronix.de, paulmck@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit-ID:  04229110adfba984950fc0209632640a76eb1de4
Gitweb:     https://git.kernel.org/tip/04229110adfba984950fc0209632640a76eb1de4
Author:     Paul E. McKenney <paulmck@linux.ibm.com>
AuthorDate: Mon, 5 Nov 2018 16:53:13 -0800
Committer:  Paul E. McKenney <paulmck@linux.ibm.com>
CommitDate: Thu, 8 Nov 2018 21:43:20 -0800

powerpc: Convert hugepd_free() to use call_rcu()

Now that call_rcu()'s callback is not invoked until after all
preempt-disable regions of code have completed (in addition to explicitly
marked RCU read-side critical sections), call_rcu() can be used in place
of call_rcu_sched().  This commit therefore makes that change.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@lists.ozlabs.org>
---
 arch/powerpc/mm/hugetlbpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 8cf035e68378..4c01e9a01a74 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -289,7 +289,7 @@ static void hugepd_free(struct mmu_gather *tlb, void *hugepte)
 
 	(*batchp)->ptes[(*batchp)->index++] = hugepte;
 	if ((*batchp)->index == HUGEPD_FREELIST_SIZE) {
-		call_rcu_sched(&(*batchp)->rcu, hugepd_free_rcu_callback);
+		call_rcu(&(*batchp)->rcu, hugepd_free_rcu_callback);
 		*batchp = NULL;
 	}
 	put_cpu_var(hugepd_freelist_cur);
