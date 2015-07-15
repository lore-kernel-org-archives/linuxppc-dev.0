Return-Path: <khlebnikov@yandex-team.ru>
Received: from forward-corp1o.mail.yandex.net (forward-corp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::1010])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 381A41A08AC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 20:00:13 +1000 (AEST)
Subject: [PATCH v2 1/3] drivers/xen/preempt: use need_resched() instead of
 should_resched()
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 Paul Mackerras <paulus@samba.org>, David Vrabel <david.vrabel@citrix.com>,
 xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Wed, 15 Jul 2015 12:52:01 +0300
Message-ID: <20150715095201.12246.49283.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This code is used only when CONFIG_PREEMPT=n and only in non-atomic context:
xen_in_preemptible_hcall is set only in privcmd_ioctl_hypercall().
Thus preempt_count is zero and should_resched() is equal to need_resched().

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 drivers/xen/preempt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/preempt.c b/drivers/xen/preempt.c
index a1800c150839..08cb419eb4e6 100644
--- a/drivers/xen/preempt.c
+++ b/drivers/xen/preempt.c
@@ -31,7 +31,7 @@ EXPORT_SYMBOL_GPL(xen_in_preemptible_hcall);
 asmlinkage __visible void xen_maybe_preempt_hcall(void)
 {
 	if (unlikely(__this_cpu_read(xen_in_preemptible_hcall)
-		     && should_resched())) {
+		     && need_resched())) {
 		/*
 		 * Clear flag as we may be rescheduled on a different
 		 * cpu.
