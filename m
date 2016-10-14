Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sw8HR3mjZzDt2L
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 11:53:55 +1100 (AEDT)
Received: by mail-pa0-x241.google.com with SMTP id hh10so5400863pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 17:53:55 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: pbonzini@redhat.com, rkrcmar@redhat.com, agraf@suse.com, corbet@lwn.net
Cc: paulus@samba.org, mpe@ellerman.id.au, sam.bobroff@au1.ibm.com,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 linux-doc@vger.kernel.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH 3/6] powerpc/kvm: Add check for module parameter halt_poll_ns
Date: Fri, 14 Oct 2016 11:53:21 +1100
Message-Id: <1476406404-32752-4-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1476406404-32752-1-git-send-email-sjitindarsingh@gmail.com>
References: <1476406404-32752-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The kvm module parameter halt_poll_ns defines the global maximum halt
polling interval and can be dynamically changed by writing to the
/sys/module/kvm/parameters/halt_poll_ns sysfs file. However in kvm-hv
this module parameter value is only ever checked when we grow the current
polling interval for the given vcore. This means that if we decrease the
halt_poll_ns value below the current polling interval we won't see any
effect unless we try to grow the polling interval above the new max at some
point or it happens to be shrunk below the halt_poll_ns value.

Update the halt polling code so that we always check for a new module param
value of halt_poll_ns and set the current halt polling interval to it if
it's currently greater than the new max. This means that it's redundant to
also perform this check in the grow_halt_poll_ns() function now.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index daad638..6503a63 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2526,9 +2526,6 @@ static void grow_halt_poll_ns(struct kvmppc_vcore *vc)
 		vc->halt_poll_ns = 10000;
 	else
 		vc->halt_poll_ns *= halt_poll_ns_grow;
-
-	if (vc->halt_poll_ns > halt_poll_ns)
-		vc->halt_poll_ns = halt_poll_ns;
 }
 
 static void shrink_halt_poll_ns(struct kvmppc_vcore *vc)
@@ -2648,6 +2645,8 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 		else if (vc->halt_poll_ns < halt_poll_ns &&
 				block_ns < halt_poll_ns)
 			grow_halt_poll_ns(vc);
+		if (vc->halt_poll_ns > halt_poll_ns)
+			vc->halt_poll_ns = halt_poll_ns;
 	} else
 		vc->halt_poll_ns = 0;
 
-- 
2.5.5
