Return-Path: <hugh_dickins@symantec.com>
Received: from excu-mxob-2.symantec.com (excu-mxob-2.symantec.com
	[198.6.49.23])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "excu-mxob-2.symantec.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6BD6867B8F
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Nov 2006 06:45:16 +1100 (EST)
Received: from excu-mxob-1.symantec.com (excu-mxob-1.symantec.com
	[198.6.49.12])
	by excu-mxob-2.symantec.com (8.13.7/8.13.7) with ESMTP id
	k9VIeWPW018281
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 10:40:33 -0800
Date: Tue, 31 Oct 2006 18:40:39 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/5] ppc64: make high hugepage areas preempt safe
In-Reply-To: <Pine.LNX.4.64.0610311834580.26470@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0610311839480.26470@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0610311834580.26470@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Checking source for other get_paca()->field preemption dangers found that
open_high_hpage_areas does a structure copy into its paca while preemption
is enabled: unsafe however gcc accomplishes it.  Just remove that copy:
it's done safely afterwards by on_each_cpu, as in open_low_hpage_areas.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
I think this patch should go into 2.6.19 (but no reports to justify 18-stable).

 arch/powerpc/mm/hugetlbpage.c |    3 ---
 1 file changed, 3 deletions(-)

--- 2.6.19-rc4/arch/powerpc/mm/hugetlbpage.c	2006-09-20 04:42:06.000000000 +0100
+++ linux/arch/powerpc/mm/hugetlbpage.c	2006-10-30 19:27:05.000000000 +0000
@@ -480,9 +480,6 @@ static int open_high_hpage_areas(struct 
 
 	mm->context.high_htlb_areas |= newareas;
 
-	/* update the paca copy of the context struct */
-	get_paca()->context = mm->context;
-
 	/* the context change must make it to memory before the flush,
 	 * so that further SLB misses do the right thing. */
 	mb();
