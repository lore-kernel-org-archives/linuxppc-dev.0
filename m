Return-Path: <thomas@m3y3r.de>
Received: from www17.your-server.de (www17.your-server.de [213.133.104.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xlY3R1hxczDqjK
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Sep 2017 22:59:47 +1000 (AEST)
Subject: [PATCH 1/10] KVM: PPC: Book3S HV: Use ARRAY_SIZE macro
From: Thomas Meyer <thomas@m3y3r.de>
To: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-ID: <1504439110050-1911621934-1-diffsplit-thomas@m3y3r.de>
References: <1504439110050-939061377-0-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1504439110050-939061377-0-diffsplit-thomas@m3y3r.de>
Date: Sun, 03 Sep 2017 14:19:31 +0200
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use ARRAY_SIZE macro, rather than explicitly coding some variant of it
yourself.
Found with: find -type f -name "*.c" -o -name "*.h" | xargs perl -p -i -e
's/\bsizeof\s*\(\s*(\w+)\s*\)\s*\ /\s*sizeof\s*\(\s*\1\s*\[\s*0\s*\]\s*\)
/ARRAY_SIZE(\1)/g' and manual check/verification.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 359c79cdf0cc..ae80181c4e1f 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/kvm_host.h>
+#include <linux/kernel.h>
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/preempt.h>
@@ -1766,7 +1767,7 @@ static struct debugfs_timings_element {
 	{"cede",	offsetof(struct kvm_vcpu, arch.cede_time)},
 };
 
-#define N_TIMINGS	(sizeof(timings) / sizeof(timings[0]))
+#define N_TIMINGS	(ARRAY_SIZE(timings))
 
 struct debugfs_timings_state {
 	struct kvm_vcpu	*vcpu;
