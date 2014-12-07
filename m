Return-Path: <rickard_strandqvist@spectrumdigital.se>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
 [209.85.212.174])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A66B21A001B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 09:26:38 +1100 (AEDT)
Received: by mail-wi0-f174.google.com with SMTP id h11so3171033wiw.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Dec 2014 14:26:35 -0800 (PST)
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Alexander Graf <agraf@suse.de>,
	Gleb Natapov <gleb@kernel.org>
Subject: [PATCH] arch: powerpc: kvm: book3s_paired_singles.c: Remove unused
 function
Date: Sun,  7 Dec 2014 23:29:14 +0100
Message-Id: <1417991354-19932-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
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

Remove the function inst_set_field() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/powerpc/kvm/book3s_paired_singles.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_paired_singles.c b/arch/powerpc/kvm/book3s_paired_singles.c
index bfb8035..bd6ab16 100644
--- a/arch/powerpc/kvm/book3s_paired_singles.c
+++ b/arch/powerpc/kvm/book3s_paired_singles.c
@@ -352,14 +352,6 @@ static inline u32 inst_get_field(u32 inst, int msb, int lsb)
 	return kvmppc_get_field(inst, msb + 32, lsb + 32);
 }
 
-/*
- * Replaces inst bits with ordering according to spec.
- */
-static inline u32 inst_set_field(u32 inst, int msb, int lsb, int value)
-{
-	return kvmppc_set_field(inst, msb + 32, lsb + 32, value);
-}
-
 bool kvmppc_inst_is_paired_single(struct kvm_vcpu *vcpu, u32 inst)
 {
 	if (!(vcpu->arch.hflags & BOOK3S_HFLAG_PAIRED_SINGLE))
-- 
1.7.10.4
