Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DC2606A330
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UB9g9NCl
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFGwB2Rxsz2ygd;
	Thu, 29 Oct 2026 06:03:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1046"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793214186;
	cv=none; b=XI5RJDmF0md3Ktpe9x72YUZx+FCmn9po5RVUALxSTmM/XcB9KV6Gon/2rqCSZzUA9P9ysHYikyQyz4yeRpWBvl5r13UYXDPY4b5BpiUYRWvMkJ+QH8ijOgxQ9HF0uf5QTDWH0lq4doQcgIeBRSyk08U5iaX7HDs11dsx4dFrrjkfcWOdStniYj5ZJxuhLwrpV6N8jDH7Kj1EATYwCYwVZlgjGpzQwjXEO7EXn3yRTMZTgkuwkHi+EqTsXRhNMqnS5oioca5LNu3ndxcj3bwJw1YW14uvMJiw7onykcI3Z5WHboSjbwyAjxXy33sShisW0ly7tgL+G+kU55hg/t5pVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793214186; c=relaxed/relaxed;
	bh=LaqWhYbOMD7sY9Ovf2nEN4IH4sn07uRJnSek/bjgEtY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aqdq4i/0aFTLcsxm2cYkmsVuVlIflriULpAXHnWrU91uEdrLvvxWFA5k7rvmHBEl2AeDaoDDBk+q4mtoIKLDJmlgnLOWtQJ6bqPtL/hD3HsR4hgU6UQF0mElwg9kQTG1Kja0CYhz2AT8CReNFQ/aPB+hE4d9327wsBidO7xt7QlwoFQ09vjkOS7Gf/ZL1XJqWVgkYWxvpYYfUKDB60ceT6Xlr20tAya9KTaXby+0rh5Eb8EzBdslEUIudUsQI8LvrIZ6ZE779zN37SE9LbwT1JT6Q+HCty3k5ZgLyrAmxxWpoZiLi//Sy8cpkGQMfL1JHjZL6QotDR7elJp0g0E7CA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UB9g9NCl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1046; helo=mail-pj1-x1046.google.com; envelope-from=35kbiagykdfsl73gc59hh9e7.5hfebgnqii5-67oeblml.hse34l.hk9@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UB9g9NCl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::1046; helo=mail-pj1-x1046.google.com; envelope-from=35kbiagykdfsl73gc59hh9e7.5hfebgnqii5-67oeblml.hse34l.hk9@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1046.google.com (mail-pj1-x1046.google.com [IPv6:2607:f8b0:4864:20::1046])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFGw915tfz2yWy
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 06:03:05 +1100 (AEDT)
Received: by mail-pj1-x1046.google.com with SMTP id 98e67ed59e1d1-3ac77c3ff6aso1841253a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 12:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793214183; x=1793818983; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LaqWhYbOMD7sY9Ovf2nEN4IH4sn07uRJnSek/bjgEtY=;
        b=UB9g9NClqyp+GWeFVzTo8YK6nMq/q57M4MYXh2+UDFHv2AANjrf2vh9/vmQpI88Gxc
         mk4LXAYFb8R//fMB4UXkR1APVE8wReOQLO70SDiLdEQ2dF6/OlYsnMZgo0RqhTMT5Kk+
         D/4v9tDHJVMjCX6TMwAJwGbRC9bxODmARDUjjCCK6CCpvlOiF4CXDywThvWmLFK4h+1D
         fsk8rqG7arSHSIwAD8HQ4OP6oT9+QB9IijXzv/WdbpZVlWzGwowQuSczKucpoBuNxKIg
         fK2RrgvjVJMQ30h175tXDI1SIoCIoUBDic4KejMOerp682akSX0iylD3xfLTEBEb6O+/
         T+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793214183; x=1793818983;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LaqWhYbOMD7sY9Ovf2nEN4IH4sn07uRJnSek/bjgEtY=;
        b=sDs4yKx4a9oizbirfnBGoGZytJO/jYovQTt4I+fM5dro+Wnsbc8Uy+/rljIz2PIlBt
         6NuyMcBuCcjHcK5Wz5q37trlIPLWrgRakFC/z8vyImli8kr/LlD5F6t02sn6QcVk5py2
         lW5FtO9ljvuaMMPpJNjGB00nlhbZx/WM/r8LDXhoaobEG+A6DRB8kAp3U8CKtKRec3qy
         juMkWDblTTw/k7nLa2frRPJS0XZ1bkznl36CBBYeTTKe3r1MuteClH/Ayk0bdQHQClfT
         oGV7KsJ+y1HBvAnLEMuqBi8KjASXBxhb8TD+xnFZWFx+Asq5GvBVcFaFCUbH7nzP8O/g
         b+4w==
X-Forwarded-Encrypted: i=1; AKwUvBy9RlPspakHA4nhWYrPbs/wikjIEW9GqaKqJvLrX046N4GAoG8VD2MdiRN831TRv/W3WOI8FmkHzAh3fMA=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLnO4UGCvqdmhI2tBjAExEwpURPpYXtmlHDXpWd8C6gvfq6Slm5
	zryoUCeopDIRYwWIBh7P+9ud4GYXzDC0ZbTYTthxBW9TeNTC65vkyhOvDOe2L5yA1DkpqtN/CSl
	LLKbyIg==
X-Received: from pjbmh6.prod.google.com ([2002:a17:90b:4ac6:b0:3aa:f38e:cb2d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:264d:b0:3ac:9d83:8856
 with SMTP id 98e67ed59e1d1-3ae57e3d6c1mr2423992a91.9.1793214182870; Wed, 28
 Oct 2026 12:03:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Oct 2026 12:02:53 -0700
In-Reply-To: <20261028190259.1819571-1-seanjc@google.com>
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
Mime-Version: 1.0
References: <20261028190259.1819571-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261028190259.1819571-2-seanjc@google.com>
Subject: [PATCH 1/7] KVM: s390: Drop unused and unreachable kvm_arch_vcpu_should_kick()
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Drop s390's kvm_arch_vcpu_should_kick() stub as the one and only call site
is wrapped with "#ifndef CONFIG_S390".

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/s390/kvm/s390/s390.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index 18fb200f854a..9900a1a1c148 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -3922,13 +3922,6 @@ bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
 	return false;
 }
 
-int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
-{
-	/* kvm common code refers to this, but never calls it */
-	BUG();
-	return 0;
-}
-
 static int kvm_arch_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu,
 					   struct kvm_one_reg *reg)
 {
-- 
2.56.0.313.g2479322e68-goog


