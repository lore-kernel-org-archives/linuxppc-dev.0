Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D03606A31B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 00:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bFNfn5jG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jK5c21GhGz2xpv;
	Wed, 04 Nov 2026 11:17:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::447"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793751442;
	cv=none; b=XFktia7xebYykBs9+36c5ZUq2JWcY7oLDFpNwGNjAa8UeBl5Zls48TwKLQgiEN3XBb0R0FzQRKH5D+DJ3WccChW6EsXAlH8X2/8idVCgASJNR8dG80oBsYp7c+b4iwbs19yzNqLpmFoj1lumc5cQ+heTwIPm4rRLaugijL+hD0dL9SB9Oduv+YhDweR6LXP1hGhoVnTOmmPEtStF/NnkLeEGj6JahvWxCxnOYQ/Bg0IFVBbEDU+TrBuwiEFsADGtX9CIiBHJWWQSYO5JouP+T5GOzhR2StBaDwmYFlQ5tJVCufePGKZriI0vpM3QJa8HGTDFeB+KnD3luhLOzA5X7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793751442; c=relaxed/relaxed;
	bh=LhyvKds25xNhoCjxUA6XF46cL6FC3po2ea3t+x75DYw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fplQtE10W3WkasN/nWDaNM+T8SQ96qvqP8Usqwv1ol1lGy0mr5oS/HBz2kPNrXTSrU9RZa7O17OAKR+qOz5tLlpM5VRtkUCvJ8F5kC5tqj4//2ZCshqXcx5IPWrXOziorKcJl/0uvu38wNIXuppEKIbBXwMcRQ46nGN0aXiCb/q5+EcC+aVLSmlFbOwmZtEMMoscDJLqzLuabR7ZqrmeilRijeiyNicShg2V4IItNVRkdCiTYT/bGba1caJa6wBRWe2bNDhogu+K6l5I6tPdJLXEAPajrzSB1ifCvY5GRfKIFB0atvtvy9UW2dv4X1U/odhFF9gyGsOj8Ic+2EmOjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bFNfn5jG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::447; helo=mail-pf1-x447.google.com; envelope-from=3jhnqagykdic3plyunrzzrwp.nzxwty5800n-op6wt343.zawlm3.z2r@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bFNfn5jG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::447; helo=mail-pf1-x447.google.com; envelope-from=3jhnqagykdic3plyunrzzrwp.nzxwty5800n-op6wt343.zawlm3.z2r@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x447.google.com (mail-pf1-x447.google.com [IPv6:2607:f8b0:4864:20::447])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jK5bz5kTBz2xKQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 11:17:19 +1100 (AEDT)
Received: by mail-pf1-x447.google.com with SMTP id d2e1a72fcca58-8a0619b1fe5so182041b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 16:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793751436; x=1794356236; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LhyvKds25xNhoCjxUA6XF46cL6FC3po2ea3t+x75DYw=;
        b=bFNfn5jGhfdafVyxQpGu+JcM5YmgIiOd7RwmP60zy+Ym2Zyeg/THxZ9UfFk3jFlWkF
         /jpOMdu4yHoILqARHqhh8XxcgZLJlu5jqsmmnFKsdXF6BTamyZgXxv21z65eqczoh0uA
         7ifcasRrmuEMv3IuCN1fja4H6uUTNojmHWmoAx6ZTlZx/osj3e5ztNeXizfU356CRox5
         SCEV+ALPnq9WwVlK6HPdtKsPGkAwPlzsZf9ui3gPunylfRuExxijfqqDjbvUrolx6qnn
         KmNbk0X/EwCbee9NKxKAwN/HNQKBIR8b0fKbKROg9NO0xoBOuBqoRrkl+CRV2ZxIOJiG
         5rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793751436; x=1794356236;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LhyvKds25xNhoCjxUA6XF46cL6FC3po2ea3t+x75DYw=;
        b=dRt2nIZJDSd8Aqo1QMOd2Jix5wk4wyYeV7l85T2RTA6kWR5Tcggfj2gzxUAhJiAKnL
         0wm1fniREY7eb31tKkCtLycbrLpwNBy3SYrMClghYu9/VFDUs2TK/90RPwTo4ZR61OjQ
         vAvvc8bHb/1QRcAayxWrsmSDRgYtKTUlwWpeSOSk9jBNeIGSmtNDHcSpNbKkW48dk+e7
         G3iqViqa7bNxP2ifiKUZN8OQ0Psyv44Kw+LDHvxJJwx/lSeAl38TjFBGEg8xYl9z6eP7
         VtVB5b47fFrCNK9Hnwq1qUI5ZJCK7OU4RMkNlke7IiJtKnZfOnoYztT0kInKmMaD+tB+
         gnBA==
X-Forwarded-Encrypted: i=1; AKwUvBxLiTzezuKeKG5fUImxMVfNDdJTGSa+O5sFrHV5JF3lw6MXyBuDTwiER+xupshvBP6b3CMVrthInAu2neA=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9LbOgylgeCmdHLtKSsDuRd/0Ou3p786HvJnWXqpGL0Vx2Han2j
	p3hbffbQhKcyqvS4Hy2T0L0XoXZMcRMKY3pdqN9q9gfX/q5VdQxGksTAK/fqOgi+WOAr8gl7Lbn
	Gifj8NA==
X-Received: from pfgg3.prod.google.com ([2002:a05:6a00:bd83:b0:8a0:cc:2b89])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b4a:b0:89e:cfbb:e8af
 with SMTP id d2e1a72fcca58-8a9ba8fb9c0mr10230607b3a.6.1793751436089; Tue, 03
 Nov 2026 16:17:16 -0800 (PST)
Date: Tue, 3 Nov 2026 16:17:15 -0800
In-Reply-To: <se1h6b4t.ritesh.list@gmail.com>
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
References: <20261030212112.2598640-1-seanjc@google.com> <20261030212112.2598640-13-seanjc@google.com>
 <sashiko-outbox-191627@kernel.org> <auitWWkOopYYbBH3@google.com> <se1h6b4t.ritesh.list@gmail.com>
Message-ID: <aup5i73T5aOKqcYS@google.com>
Subject: Re: [PATCH v4 12/23] KVM: Destroy memslots immediately after
 mmu_notifiers are unregistered
From: Sean Christopherson <seanjc@google.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org, 
	Gautam Menghani <gautam@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026, Ritesh Harjani wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > +Gautam and PPC lists/maintainers
> > On Fri, Oct 30, 2026, sashiko-bot@kernel.org wrote:
> >> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> >> - [Medium] KVM: PPC: Book3S HV: rmap_nested memory leak in kvmhv_release_all_nested()
> >> > @@ -1310,12 +1329,10 @@ static void kvm_destroy_vm(struct kvm *kvm)
> >> >  		kvm->mn_active_invalidate_count = 0;
> >> >  	else
> >> >  		WARN_ON(kvm->mmu_invalidate_in_progress);
> >> > +	kvm_destroy_memslots(kvm);
> >> > +
> >> >  	kvm_arch_destroy_vm(kvm);
> >> >  	kvm_destroy_devices(kvm);
> >> > -	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
> >> > -		kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
> >> > -		kvm_free_memslots(kvm, &kvm->__memslots[i][1]);
> >> > -	}
> >> 
> >> [Severity: Medium]
> >> Does hoisting kvm_destroy_memslots() above kvm_arch_destroy_vm() leak
> >> struct rmap_nested allocations in slot->arch.rmap on PowerPC Book3S HV when
> >> destroying a VM with nested virtualization enabled?
> >
> > I don't think so?  Patch 3[*], "KVM: PPC: Flush/zap all memslots on kvm_arch_flush_shadow_all()",
> > should free the rmaps in response to kvm_arch_flush_shadow_all().   From what I
> > can tell, the page tables have to be in radix mode, and so the rmaps are freed via:
> >
> >   kvmppc_radix_flush_memslot()
> >   |
> >   -> kvmppc_unmap_pte()
> >      |
> >      -> kvmhv_remove_nest_rmap_range()
> >         |
> >         -> kvmhv_remove_nest_rmap_list()
> >
> 
> That's correct. Maybe, I think Sashiko didn't consider patch-3 of the series
> during review of this patch-12.
> 
> > And if that doesn't work, it means memslot deletion on an active VM is completely
> > broken.
> >
> > However, it means the memslot code in kvmhv_release_all_nested() is
> > dead code,
> 
> Not really. I do see a caller of this, for when we switch from radix
> to HPT. So we still need it.

Oh, nice, I somehow missed that.  Yay, less work to do!

> INCOMING CALLS
> - f kvmhv_release_all_nested
>   - f kvmppc_switch_mmu_to_hpt    [arch/powerpc/kvm/book3s_hv.c:5591]
>     + f kvmppc_alloc_reset_hpt    [arch/powerpc/kvm/book3s_64_mmu_hv.c:144]
>     + f kvmhv_configure_mmu       [arch/powerpc/kvm/book3s_hv.c:6330]
>   + f kvmppc_core_destroy_vm_hv   [arch/powerpc/kvm/book3s_hv.c:5930]
> 
> 
> 
> So FWIW patch-12 as such looks good to me from PowerPC perspective,
> since those rmap entries will get freed up as part of the
> mmu_notifier_unregister() (after patch-3). Agreed that Sashiko
> comment does not look correct.

