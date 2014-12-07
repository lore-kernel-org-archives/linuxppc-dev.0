Return-Path: <rickard_strandqvist@spectrumdigital.se>
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D80A1A08C2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 04:18:10 +1100 (AEDT)
Received: by mail-wg0-f50.google.com with SMTP id k14so4570655wgh.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Dec 2014 09:18:07 -0800 (PST)
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Alexander Graf <agraf@suse.de>,
	Gleb Natapov <gleb@kernel.org>
Subject: [PATCH] arch: powerpc: kvm: book3s_32_mmu.c:  Remove unused function
Date: Sun,  7 Dec 2014 18:20:46 +0100
Message-Id: <1417972846-12776-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Cc: kvm@vger.kernel.org,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the function sr_nx() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/powerpc/kvm/book3s_32_mmu.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_32_mmu.c b/arch/powerpc/kvm/book3s_32_mmu.c
index cd0b073..a2eb6d3 100644
--- a/arch/powerpc/kvm/book3s_32_mmu.c
+++ b/arch/powerpc/kvm/book3s_32_mmu.c
@@ -78,11 +78,6 @@ static inline bool sr_kp(u32 sr_raw)
 	return (sr_raw & 0x20000000) ? true: false;
 }
 
-static inline bool sr_nx(u32 sr_raw)
-{
-	return (sr_raw & 0x10000000) ? true: false;
-}
-
 static int kvmppc_mmu_book3s_32_xlate_bat(struct kvm_vcpu *vcpu, gva_t eaddr,
 					  struct kvmppc_pte *pte, bool data,
 					  bool iswrite);
-- 
1.7.10.4
