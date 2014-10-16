Return-Path: <kernelfans@gmail.com>
Received: from mail-ie0-x22e.google.com (mail-ie0-x22e.google.com
 [IPv6:2607:f8b0:4001:c03::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3739A1A0583
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 18:26:19 +1100 (AEDT)
Received: by mail-ie0-f174.google.com with SMTP id tr6so2903848ieb.19
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 00:26:17 -0700 (PDT)
From: kernelfans@gmail.com
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [RFC 09/11] powerpc: kvm: handle time base on secondary hwthread
Date: Thu, 16 Oct 2014 15:29:58 -0400
Message-Id: <1413487800-7162-10-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
References: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(This is a place holder patch.)
We need to store the time base for host on secondary hwthread.
Later when switching back, we need to reprogram it with elapse
time.

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 89ea16c..a817ba6 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -371,6 +371,8 @@ _GLOBAL_TOC(kvmppc_secondary_stopper_enter)
 
 	/* fixme: store other register such as msr */
 
+	/* fixme: store the tb, and set it as MAX, so we cease the tick on secondary */
+
 	/* prevent us to enter kernel */
 	li	r0, 1
 	stb	r0, HSTATE_HWTHREAD_REQ(r13)
@@ -382,6 +384,10 @@ _GLOBAL_TOC(kvmppc_secondary_stopper_enter)
 
 /* enter with vmode */
 kvmppc_secondary_stopper_exit:
+	/* fixme: restore the tb, with the orig val plus time elapse
+         * so we can fire the hrtimer as soon as possible
+         */
+
 	/* fixme, restore the stack which we store on lpaca */
 
 	ld	r0, 112+PPC_LR_STKOFF(r1)
-- 
1.8.3.1
