Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F064606A326
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xUq/oW4q
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHd2r10Swz2y7M;
	Mon, 02 Nov 2026 01:47:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793544420;
	cv=none; b=kQIIYaR/OqyLi3DJsmrIdFI/XylFSJHyzQN58jxFH0APcxd6jnz/OEXYZu5UcjZAPfMIOvmx/SrfwPDeeyDT9gazA+/KbhWtHvwK/0l4QcQiZb3hY84J17ECcg1Z07pvs2xktvzs3Z5yVJdv9BzpONTKiiN1AmR/f8yWD7F1FGa11xYCd5W2NXrDRBogpBgeUJsIVHxfRNcSUU/tz0LV6rfU999RK6rlNwgjIj6q14XiSRD3HRjRWpGfutvEcVs1HKfJnqgGdiFy4JngOmIb76e+YQbKFhwUaRNykaaccbIVQIY58KKs5Lc+1cbd88Ju7AeJvPG0A7k4c0N+xXYo+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793544420; c=relaxed/relaxed;
	bh=RxWoIhpJjuj2outZeAOWH2ZFPlszOZNa+qnxn1FwicE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ax4LOnG/vBnKRL69xr1NzlDptpYI9OSKFhIzMWBbto8EVrDR/2hhRtMChfzzLeU69MOZEeBPagjbN6O2y58ELXpD2U6Zup55SUUeTSl13JxK/ezSkIGs7vvU6R0c5S0oDE0GH+unSQP6EEd74nKpVHJKMEP23GbFTRLhxdpucULOpc2t59KKwemnfy2aBEPe6cisFzteCj3mJtNexxTGixzZ9Hfo+z2cr7OF3kI7mFNT2lEqHeBitL/CQAMI6fphD2A8p7CjCG+EPAjYdmfrYQ2oZiELKuz93Nj9Q0/EyvgpwTOOA/owhjdZMrQQsAKF1eMVPqPsZtt0yP0Y46LwNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xUq/oW4q; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xUq/oW4q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com [IPv6:2607:f8b0:4864:20::132f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHd2q1p6Nz2xgv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 01:46:59 +1100 (AEDT)
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-353804b591eso3851763eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2026 06:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793544417; x=1794149217; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RxWoIhpJjuj2outZeAOWH2ZFPlszOZNa+qnxn1FwicE=;
        b=xUq/oW4qDMCHxi5c27ndJHb1m4fAMmJ0YoctHVcb8uuveY9OkNjkNjoAXr2m7GZSaf
         RUwEm5jL6AsdUr0dZBDv9aQWxVRWtbPa2ss3h3dDHIbneSNRQCFs2HeEQzcFG19EEwtt
         fQr60jXiYEZRkvTWrZe/RARm/O0G7+Xbk+t5kJOC+HrBKbeUd2VserISWf7sOKJVEN+S
         Jl+1YrXrrAJIuWGxwVdT8xwv+IYoIRP8dsp9jw0mZsgNWFFy7EHEXbbIZP6ElrspA9lQ
         9BUAYLLZdb9c8+ZRL4ZsupWT/f3apleWh3v9cxYWYgXgTWn94mqhCThgV0+USqWSk7vL
         TlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793544417; x=1794149217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RxWoIhpJjuj2outZeAOWH2ZFPlszOZNa+qnxn1FwicE=;
        b=g27v4i9KoT+mHQaUINposItY1Cw/MufptGljTpepN3T6oWNX8BHw3UbV2skCtervHl
         2ksX7H00vM9db6XHf6nvtlAHoqN8lZd2OQMl5f0W8R+7ixc3WsnELFyYrbqOezGp7XUJ
         kcSWqcNaAc8hah9P3DbGIwwQPnPrtnfv7EzV6WMsmQERhRxvuQDxID/oKaV3sxWqp/FF
         VftAlQtAifCbhVfqsWzKPCGt9g1HK+a+zCv1/odC41nuehMPQwaKeeDbLdOFmo7PqBw4
         D5JQZUPo3KzbYw28gC1NWKEKzSlrRgVOqcbCJnTDZtLTzsuE7I1lDZJ7cl7mCRaaiBcJ
         K4xg==
X-Gm-Message-State: AFq9FYKpmg4zjf690+gMZgLuIqIzV+Smxhj+KChBxjzMBgqam/J3EWq8
	+UiMIRayYUhya3KuoIq+hfAaVlEeJ+R7bO4DBIOP9G5zBYojXTiPYvCCQU31NQ==
X-Gm-Gg: AYBFou3WbOA4kgY+hLeUHccw1FFluxPlzEB2IKdcZ4YbAl9ZX697L6PrbmbNHVNjWgc
	llP662Vjfofzr6Zz81/zSdZQniDOZUVzKqXnraPjcUTgkGro68ib1GgB0Dqtd+IH+FVVbgf0KlC
	knxdKcUczRfS5I2QT9zJ6en3xfm5QK3UeArRbysO0MVzL6xkgti1oMalKN/8IHp8PZGj4npuQbC
	+PLFUceLnhhVfwvzj5pSHA6fawv3twInYZ01l5JxJQ4UUj8Zhmyp5iR0NTyzw4ig4jsBC7k+Fkq
	LINaBLvozwoZ4EVoNEmpOdHfZf+6iRmAfaNB38xQDT09xsXV5olTufkiPeWSqbsSYltBabNXDfJ
	Zl9Alyd3o21HgSAFVGdfSrM+zV+HDYox1Cwb5LmTNxTx3jB0JKFMkeh8g73/78Wo44UtiLw5VSl
	73o7iJF8eyxMZFCfUCVl59vH60ZK0Jp/M7bk7+VGjk98ZGf9Y710biVu9zG4c1hTVty31fxTdc6
	Ht+BOiyU24uDC6CYbMO3LlgL/37Ei5GyoS4vzs/1nvfRBtDl45VOOFudLpwK7LdupL/vePVdL3L
	2x87G267uQ6j3XLvr7MXx8z0CMGn0YF2cMo=
X-Received: by 2002:a05:693c:88c8:10b0:36a:1f:9b74 with SMTP id 5a478bee46e88-36a423bf83emr11475457eec.27.1793544416826;
        Sun, 01 Nov 2026 06:46:56 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm32747545eec.25.2026.11.01.06.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 06:46:56 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	kvm@vger.kernel.org,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv2 2/7] KVM: PPC: Book3S: Don't call __ffs() on an empty pending_exceptions bitmap
Date: Sun,  1 Nov 2026 20:16:27 +0530
Message-Id: <b985cc12b0ed62599815ddf87e612bc8b6b2813c.1793543627.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793543627.git.ritesh.list@gmail.com>
References: <cover.1793543627.git.ritesh.list@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This problem was caught when running KVM PPC selftests on big-endian.
__ffs() doc clearly says:
  "Undefined if no bit exists, so code should check against 0 first"

This cause KVM to deliever an arbitrary interrupt to the guest and was
causing guest to hang up while running these selftests.

On checking further - GCC was emitting 0 in this case, which caused
System Reset in guest while running kvm selftests.

Use find_first_bit() instead, which reads the word once and returns the
bitmap size when no bit is set, instead of reading *pending twice
thereby causing TOCTOU as pointed by Sashiko.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kvm/book3s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 2efbe05caed7..38816578d002 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -401,7 +401,7 @@ int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.pending_exceptions)
 		printk(KERN_EMERG "KVM: Check pending: %lx\n", vcpu->arch.pending_exceptions);
 #endif
-	priority = __ffs(*pending);
+	priority = find_first_bit(pending, BITS_PER_LONG * sizeof(*pending));
 	while (priority < BOOK3S_IRQPRIO_MAX) {
 		if (kvmppc_book3s_irqprio_deliver(vcpu, priority) &&
 		    clear_irqprio(vcpu, priority)) {
--
2.39.5


