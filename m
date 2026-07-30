Return-Path: <linuxppc-dev+bounces-25099-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5BFC55165
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 12:09:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9p0C6jzPz2yhb;
	Thu, 30 Jul 2026 22:09:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785413355;
	cv=none; b=b4vci+N+V5siQmKjfXOO2s1kfKhaU2Pa7G1DiuqNQ40WmJYGSWCPTED+gSr27hjg+2/v5u38YN9GQ5PGBv45Lps+WhdkXuy8APJOTpIeuFYB/cDa3ob0FCCKjJyOxchq0qP8bHA6EA7OSgQ5+TFk+98X9khXDfW5CrN/GfHJFutoZNbJ7pmzExtHGBctkPORuHK6UDnCc6QBh07TRXcZxGN9dHRecyOMonG5MFv2uoIVmkKvF6gNU8fPNG/NphPugCBnsp3zz1fE4N+G+3duYBJCRwCEnupNO2TcIjuQ0llmN0m4EKBt8leFgdiez+E1JUYzH8lijla/oDMx1AABww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785413355; c=relaxed/relaxed;
	bh=kAQpSVKvvs9TtZoqg/MZORQ5mgn+hmqRVVXp7BGRT/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5qw+iHHt5x/d1LxYH9xemF4GKI6Oa8NMy5eOOjP/IEBAVvumHGBdIx9lBkgvbf3QK3gy7NlXxUkd/pxzxl/xlMDUzS933NCzek4aUxAFLj1rpEGQ8iU2+9PgacVRpcNrsj1UbZ1sBYXyQ9Pp3hYRiBaqdPuwV6jL1M78XF4oJrt6naJhMJioiW+6n4wWh6bd6+D/sx5xajnHBoZdHqJ5lDhO9L/W9qKAIPtGWn+udC/c89vcUimAJBQl2QyhvI7JsIl41dXg39ENQoF6O7MZXv5s1+YrGjCQg74w99rTw5NHOo8mehfpLp85gmGMjeNNPfcyb1a+RzCwgTpb6JEhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bAknPYtm; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bAknPYtm; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bAknPYtm;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bAknPYtm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9p0B5RBpz2yYd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 22:09:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785413350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kAQpSVKvvs9TtZoqg/MZORQ5mgn+hmqRVVXp7BGRT/c=;
	b=bAknPYtmT8/0V7rPE8fKf16M9U/qTNDf3wYRC/zgVVZX8hCMqZowlYjDGksBr7bK9WM7a6
	2TvLiW8TcthYq/VNDpmMXu1/QXeUDu456+mqMmGsl3XZm38qnbddL5uHawjCnl74oM3D1j
	KXybHwQFggPuKgaeJ+KKwtIaoAvq+YE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785413350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kAQpSVKvvs9TtZoqg/MZORQ5mgn+hmqRVVXp7BGRT/c=;
	b=bAknPYtmT8/0V7rPE8fKf16M9U/qTNDf3wYRC/zgVVZX8hCMqZowlYjDGksBr7bK9WM7a6
	2TvLiW8TcthYq/VNDpmMXu1/QXeUDu456+mqMmGsl3XZm38qnbddL5uHawjCnl74oM3D1j
	KXybHwQFggPuKgaeJ+KKwtIaoAvq+YE=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-fnaqApQRP1ysvlr6IDXbkg-1; Thu, 30 Jul 2026 08:09:08 -0400
X-MC-Unique: fnaqApQRP1ysvlr6IDXbkg-1
X-Mimecast-MFC-AGG-ID: fnaqApQRP1ysvlr6IDXbkg_1785413348
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5c134f0501aso352702e0c.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 05:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785413348; x=1786018148;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kAQpSVKvvs9TtZoqg/MZORQ5mgn+hmqRVVXp7BGRT/c=;
        b=noihH66zGQ+gdguw/uq+ryb339MjBPMEVAMm+BtO+Wtx1z3lvKeeZM4EKiKH7bBBTm
         IL9TWX3oVujNP9N6/NVEKrfx0NQJ+AJbYjB1x3hKre+3c9U0V2BTFdvZcl61YILXAd+y
         LT5nBCSrBQ9upallJlaWS7t7XXOmri7jZIh9UVrIqIQZNWG0FvLnhO1oAfWnQF2s6ZXm
         s1iKoV9QV0t0w/0cRpDYjSP5pmkAp8IypdiFOpkC3jf2YSYDlQZjHjKERoO6GpfNMdcE
         K4CldL2L9Z/c4sw9rQFwfazs4G/9K1tPQgIMvcWVcnuUjuS1TUc5twgMKBKuZOfHaq3r
         obWA==
X-Forwarded-Encrypted: i=1; AHgh+Rr0lRm/jFi6DZ7LlcHruxkrWDM3Yy1uy3yQT3F1AqSO3QOEwfKQa4NnPYrdYjg+xOgGZzq8LHKefwLTe64=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzSgdW91/0Xjnh0+zNus+x+A65h4hFH3D7MA92NZjBPws9TlR9U
	8My1tK0FHR6zz0e3TFEvwFGC3luotM/ERGcByfn0lp+5ZxnI4GCh1noW3RelaNSRP4gvetq+Jvn
	Ss400phuNBR7EHDqjHx4T1Yg+9XqX8Vvs5lgoc2LTbyWFmGSRP7DCDAoZjNyXf5DsB3bCaYqVLn
	kiFjU+6BgSn9WlL26PUTsYFXwZdvkHl+Nr6Y82YDHVag==
X-Gm-Gg: AR+sD11yjGSrjq3iMEepGc3ewmx9Lh1RmY0o60k8OL7lFud2wAh5HoFUh+ghKXVdoeN
	k+tWSNfVbhO5UvgXrChFKzQcxW+0q7GO2EiNUr/rT3QipAcuXlpjR35TeozwBI5zf9TAaI/cIHf
	5sgNHrp6k7TiUc9pAfly7tUIVXi6nhYjYW8hEcuGFxu6ctZrUjYJWLEMW4
X-Received: by 2002:a05:6122:8b04:b0:5c1:2150:9de7 with SMTP id 71dfb90a1353d-5c36624b938mr533188e0c.12.1785413347961;
        Thu, 30 Jul 2026 05:09:07 -0700 (PDT)
X-Received: by 2002:a05:6122:8b04:b0:5c1:2150:9de7 with SMTP id
 71dfb90a1353d-5c36624b938mr533176e0c.12.1785413347527; Thu, 30 Jul 2026
 05:09:07 -0700 (PDT)
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
References: <20250210184334.567383-1-sshegde@linux.ibm.com>
 <20250210184334.567383-2-sshegde@linux.ibm.com> <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
 <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com> <500d8e8c-088c-4e6d-ab53-868ade6b0eda@paulmck-laptop>
 <CAE4VaGDGS8wkZj4SF5XVC3-1yDmvJxjUjThTPqVw3kxg56ssQA@mail.gmail.com>
 <e013e88a-6137-4de8-9dfd-925b707f2e01@linux.ibm.com> <CAE4VaGAJ9mT8-V=GRPYj8h0RXuNf6S5icrmqeOOFDnkpPMQjaw@mail.gmail.com>
 <a1e04751-eab5-465b-8238-c9f4cd40e472@linux.ibm.com> <CAE4VaGCaN6uBBGqbGAsxudSxMC0JdXYn2vpuDJZPFR3xxJgMYA@mail.gmail.com>
 <29a407ab-268e-4443-96dc-8f5f933cb63c@linux.ibm.com>
In-Reply-To: <29a407ab-268e-4443-96dc-8f5f933cb63c@linux.ibm.com>
From: Jirka Hladky <jhladky@redhat.com>
Date: Thu, 30 Jul 2026 14:08:54 +0200
X-Gm-Features: AUfX_mw2TupqXdnuICK_yIvM86KdIHXo5DhfTYjcBswkAN2cZ0ean7n4GjhPiSU
Message-ID: <CAE4VaGDzVa3+MKUbwH4LFj_mHZ721fd=7cWEd+G5=eVNWLePsg@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: paulmck@kernel.org, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	christophe.leroy@csgroup.eu, mpe@ellerman.id.au, npiggin@gmail.com, 
	bigeasy@linutronix.de, will@kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VPzqh5KuTS7jxHQ98KDvse4ht_8KVVNfF-mTrWuXsEM_1785413348
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 8:44=E2=80=AFAM Shrikanth Hegde <sshegde@linux.ibm.=
com> wrote:
> From the above, it is quite evident that main cost is cost of
> preempt_disable/preempt_enable due to inc/dec of preempt count
> itself.

Thanks for the deep debugging, Shrikanth. This changes the picture
significantly.

So the chain is:
  PREEMPT_DYNAMIC -> PREEMPTION -> PREEMPT_COUNT
  -> every preempt_disable/enable becomes load-modify-store with barriers

And the __rcu_read_lock/__rcu_read_unlock overhead I measured was
actually the preempt_disable/preempt_enable inside them, not the RCU
logic itself. That explains why removing PREEMPT_RCU only recovered
~5% -- the remaining preempt_count operations throughout the syscall
path are the dominant cost.

> The cost of preempt_count is likely un-avoidable with
> DYNAMIC_PREEMPTION for all RISC architecture.

Agreed. On CISC (x86), the preempt_count update is a single memory
inc/dec instruction. On RISC, it requires load-modify-store plus
barriers for the atomic update, which is fundamentally more expensive
per operation.

> Also given that after 7.0, all major archs including powerpc, can
> have only full/lazy preemption. None/voluntary are no longer possible.
> So making any sort of optimization for preempt count is not useful
> since it has to be there for full/lazy.

Right. With full/lazy, PREEMPT_COUNT is required regardless of
PREEMPT_DYNAMIC.

> Also, evaluate it with any real life workloads, IIRC i have run
> hackbench, schbench, daytrader(db2 workload) this cost wasn't visible.

Good to know. I reviewed our full CI results across all benchmark
suites on ppc64le and I don't see regressions outside of stress-ng. The
stress-ng kill stressor is a worst case -- a tight syscall loop that
hits preempt_disable/enable many times per call through the SELinux
AVC path. Real workloads that do actual work between syscalls
amortize this cost.

I'll update our internal tracking with the corrected root cause.

Thanks again for your persistence on isolating this. Good to have
the real root cause understood, even if it's a fundamental RISC cost
we have to accept.

Jirka


