Return-Path: <linuxppc-dev+bounces-21587-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C0ECD5BD0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 12:52:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQTxv5QzQz2yqL;
	Wed, 27 May 2026 22:50:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779886259;
	cv=none; b=llAOPa7nj04EDdjf0LroIloMa2xmHfrurZoDDM+JCNpdjC4KjQER/G8KQ/Z/Rr03FvTDFA36+nEgdYYA3c6fCbAkOQX88LFHNrzXU237D8uhot0ToJMoabowMcWxpfX2ev+0KuPOGM9khu9AVKCVApYaQXWO04URUWjqJ42OaBdMkBfOZu6trX0lRg0ZK4Bq98d1Q2dF79l9GamqgG2dAjEirRFwgJSZOpmM3apDh2eIdQJWuL3pKnM9w5FWbiRAxy80ZaJEScR9YIo4LyeeL/RgTCkoFqdi4kD4/ICNAOwT92dl2xI62W9bHRvolYhL1Q+jOXu0HDx2Ln9Gekg69Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779886259; c=relaxed/relaxed;
	bh=o69E8eZZ8xoY19N9nOZcNtpgHKzR1JbFW5hWEhTv7Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKk9Q8xAE472zXecSPrL55p5keVctLHJd/KC/XXnKSkfHMU8XqfOR7ktzf2DgVd+5wdpPRkvWzzgYU87IAzkaxsVG1DFkov2uOTLvBnFn8F3xXu5EPqzdSeyf6u9iQwSnaGxmmBnX+Gxhix5Wp2ZrGOoIwKb/eihLU07ipMs9KDJut8jHLn/3LfsKebcJXAP9TpqRudbtFr6ULene134D4mEiA6SMmc9krC1vRTe7LAvagWwj2MfIqmwSHzrnk4PIdFhvCw0YNsCROxeyzkFeSvSaTHTJ37k6mp7pespc0nJhzJm32uXCafDqSoptjAXR6Gt/kq38EQpR3d0kTwTeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D5kwsg3x; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D5kwsg3x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQTxt3g4dz2ypk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 22:50:58 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2ba4efedbeaso88134385ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 05:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779886256; x=1780491056; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o69E8eZZ8xoY19N9nOZcNtpgHKzR1JbFW5hWEhTv7Qg=;
        b=D5kwsg3xg52TGSvFaJneMk9YjDKCczJNojtFPN4stOgqPUQNyoTJgNqsOwiqp7fPFq
         5hKOB+f1cwmt/OqOgsKEai2gdf3TL15j4w8wYlPPNh6BQW7QGTbg2Q9AhG9JnGT20TIp
         yHpoP77lAJz+oCyCfEQVUCSKTylhHtMhMLOUZlNFmLrhoSoymXYMlLHs0GQgjeQclkhx
         y0ZRAV2bbhC06cUJqkIcOpwt7MXcy7N9CVDBtByQkDo7FFHEO/xHimP7RWstfsIf1TV/
         LyKEECLAJc77TCZJLnzyPGjHHrRO3iHKd9pfbDNKgyWkecVC3LFTCzwZKvloLOSVNeHn
         3BiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886256; x=1780491056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o69E8eZZ8xoY19N9nOZcNtpgHKzR1JbFW5hWEhTv7Qg=;
        b=gj4ZcmIv0bB1RcKAidUt3ZZVIFGeUkJ5Ih1xlbHeTU1QABtil1+qvqy4576iku7+JM
         TJFZEnspEcx+fVP7GXXTkDKQS/9nULNJlJrqfCmNCl8DdigfZ5PFKx+XbngmPcQop/hs
         6ksrzxkDqKyjr7vBU4ulUQ//7mJMk7wFdwOcoZrbAyevPjhV7uxS5n69hvpE0J1iPTTa
         Br0SCoKiflkxJID0mqOwOQhDXqp7HVM23Q+AtNj7cwtiB4JdXMoMHo34Sk7eK3S0zGdm
         A+S1zBJnZx2JbD6U1GY9hG2IGXUXpKqfQof3IPTiTbs/un1x/v9oEVrkQ28q1GSYzOcZ
         Sj+g==
X-Gm-Message-State: AOJu0YwrtFagXzzjOYHA9jksSTAazjrhokKLix6wB/BJk8EnB6mx/NkS
	tnGJc6XaBZ+ZDszeoSYmFp7nDbmuSA1LHusYik7s7h9mJpY75HmfweNW
X-Gm-Gg: Acq92OFpeZW2jZA4/UoAyS05wH7RAMJRa3XW8mReLrXRP59INQnk4V8OT8I5dK1VoNC
	9eYcRwSNFHA8EDBQhwf1DOHbeLvZKU0IFLhNFrLNI9Hi4DwCfWuPY/Z+fGlLo+8l+wTdTs0WKND
	VWNToGw9XvPRX0NPmOyPW3w/9XMO0+Ab5vpYpbhtJnrfKOBjiRAz6WqMUGGeeyK/eyJjAPA2pZW
	gHURSMCrvTtGjN3X+QngdjCxXsMp2i7l9gpxvxSjq6dUoYPkqk5l2xvDX60+hhsqkm88m6hzJmL
	/XoXJPOsICwWDVCYtJXVeCUjQewH+uCze2gnNltgyB4Sd02lspVR6E00s5azrSsJjmQ30jrxqp1
	iclJv39XB1TMYkU/ABfoFnhlxqV691t/U/Cbsk+hnx7JKMzmz7S0r8n82cqSonUPE2dpGh88Pl8
	+TxCQFX0CmtKZnzT1BgG8NJBNeY2zBeXRXEbayzid3O9PW7kt9MA==
X-Received: by 2002:a17:903:198b:b0:2bd:c2ec:eec9 with SMTP id d9443c01a7336-2beb05ef6c2mr253654725ad.18.1779886255305;
        Wed, 27 May 2026 05:50:55 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c69a0sm151851185ad.59.2026.05.27.05.50.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 May 2026 05:50:54 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Misbah Anjum N <misanjum@linux.ibm.com>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v3 09/10] KVM: PPC: selftests: Use u8 instead of uint8_t
Date: Wed, 27 May 2026 18:19:58 +0530
Message-ID: <206327ff71a118e0a87fd3eca5c84afc6e3e6142.1779885589.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1779885589.git.ritesh.list@gmail.com>
References: <cover.1779885589.git.ritesh.list@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 6ec982b5a2c7c ("KVM: selftests: Use u8 instead of uint8_t")
made this change from uint32_t -> u32 for all other kvm selftests.

Do the same for powerpc as well. No functional changes expected.

It uses the same method described in above commit.
      git ls-files tools/testing/selftests/kvm | xargs sed -i 's/uint8_t/u8/g'

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/lib/powerpc/processor.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/testing/selftests/kvm/lib/powerpc/processor.c
index 0a65fc3a8d9a..2c1e95c8aa9c 100644
--- a/tools/testing/selftests/kvm/lib/powerpc/processor.c
+++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
@@ -256,7 +256,7 @@ gpa_t addr_arch_gva2gpa(struct kvm_vm *vm, gva_t gva)
 }
 
 static void virt_dump_pt(FILE *stream, struct kvm_vm *vm, gpa_t pt,
-			 gva_t va, int level, uint8_t indent)
+			 gva_t va, int level, u8 indent)
 {
 	int size, idx;
 
@@ -283,7 +283,7 @@ static void virt_dump_pt(FILE *stream, struct kvm_vm *vm, gpa_t pt,
 
 }
 
-void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
+void virt_arch_dump(FILE *stream, struct kvm_vm *vm, u8 indent)
 {
 	gpa_t pt = vm->mmu.pgd;
 
@@ -380,7 +380,7 @@ void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
 	va_end(ap);
 }
 
-void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, uint8_t indent)
+void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, u8 indent)
 {
 	struct kvm_regs regs;
 
-- 
2.39.5


