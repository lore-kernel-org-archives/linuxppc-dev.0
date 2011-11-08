Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:32:0:1:25:1])
 by ozlabs.org (Postfix) with ESMTP id DFAB3B6F99
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Nov 2011 04:17:41 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH] KVM: PPC: protect use of kvmppc_h_pr
References: <1312907508-14599-1-git-send-email-agraf@suse.de>
 <1312907508-14599-10-git-send-email-agraf@suse.de>
Date: Tue, 08 Nov 2011 18:17:39 +0100
In-Reply-To: <1312907508-14599-10-git-send-email-agraf@suse.de> (Alexander
 Graf's message of "Tue, 9 Aug 2011 18:31:47 +0200")
Message-ID: <m27h3apm8c.fsf_-_@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kvmppc_h_pr is only available if CONFIG_KVM_BOOK3S_64_PR.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/powerpc/kvm/book3s_pr.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index bc4d50d..05473b5 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -660,10 +660,12 @@ program_interrupt:
 			ulong cmd = kvmppc_get_gpr(vcpu, 3);
 			int i;
 
+#ifdef CONFIG_KVM_BOOK3S_64_PR
 			if (kvmppc_h_pr(vcpu, cmd) == EMULATE_DONE) {
 				r = RESUME_GUEST;
 				break;
 			}
+#endif
 
 			run->papr_hcall.nr = cmd;
 			for (i = 0; i < 9; ++i) {
-- 
1.7.7.2


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
