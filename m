Return-Path: <tj@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 37D3BDE1DD
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 16:54:18 +1100 (EST)
Message-ID: <49B75215.5010707@kernel.org>
Date: Wed, 11 Mar 2009 14:54:29 +0900
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
To: "Sachin P. Sant" <sachinp@in.ibm.com>
Subject: [RESEND GIT PATCH tj-percpu] percpu: fix spurious alignment WARN
	in legacy SMP percpu allocator
References: <20090310195534.8f8f3c7a.sfr@canb.auug.org.au>
	<49B67552.5070307@in.ibm.com> <49B73B15.3040101@in.ibm.com>
In-Reply-To: <49B73B15.3040101@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Ingo Molnar <mingo@elte.hu>,
	linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Impact: remove spurious WARN on legacy SMP percpu allocator

Commit f2a8205c4ef1af917d175c36a4097ae5587791c8 incorrectly added too
tight WARN_ON_ONCE() on alignments for UP and legacy SMP percpu
allocator.  Commit e317603694bfd17b28a40de9d65e1a4ec12f816e fixed it
for UP but legacy SMP allocator was forgotten.  Fix it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Sachin P. Sant <sachinp@in.ibm.com>
---
(RESEND: cc'ing Ingo. :-)

Oops, that was a stupid omission.  This patch should fix it.  Ingo,
please pull from the following git vector to receive the first first
four patches from the use-dynamic-percpu-allocator-by-default patchset
(without the actual conversion which can disrupt archs) + this patch.
I moved the actual conversion patch into #tj-percpu-exp branch, so the
pull should be safe.

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git tj-percpu

Thanks.

 mm/allocpercpu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mm/allocpercpu.c b/mm/allocpercpu.c
index 3653c57..1882923 100644
--- a/mm/allocpercpu.c
+++ b/mm/allocpercpu.c
@@ -120,7 +120,7 @@ void *__alloc_percpu(size_t size, size_t align)
 	 * on it.  Larger alignment should only be used for module
 	 * percpu sections on SMP for which this path isn't used.
 	 */
-	WARN_ON_ONCE(align > __alignof__(unsigned long long));
+	WARN_ON_ONCE(align > SMP_CACHE_BYTES);
 
 	if (unlikely(!pdata))
 		return NULL;
-- 
1.6.0.2
