Return-Path: <linuxppc-dev+bounces-19242-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE75CD6AB1F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 23:52:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmzDZ1Vz9z2yYJ;
	Fri, 03 Apr 2026 10:52:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::449"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775173950;
	cv=none; b=ITdboY8LPbCNpLDKMQbBtj+0JFxGesYKeEcuqWWaqThjORIZ7PA6xUzapIVwD5WmHyEC/ELm30KCuvzkdGEQm9nk0ABH6lgrXYMGU3Xv34Wb6diy+k74RyTVO9KAntvpRmAIjMVYoO6ClvEiZf2X7TKlRL2ImffC50ZtgS6UWtXaXOTOdqN13vWv8Rf5PLxaOhJc05PVK24P5Q2mWd4ZTvZE5co4wLQz1M13xA55JkP9anKgujTMkNMceW4mDHuLc6vcZo9oj6zoPrQWA8iuKUjdkXcyhJFBAfQwnaCn0ylg+G19+xY8zZnI8Pl0D9pQ5+NGGg73KRcyqbuprEWFDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775173950; c=relaxed/relaxed;
	bh=NRFfWyW5OJQnxYPyWhMs1ziwQUg0nXafSfiE/IeYP3E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O8SAF/Ogdo+wMC9gERL3QCjML59BXmV3bJ0Pu0mebTUO0GAM0InX0nV4ATAbHFgy4ovP/b/Vej3zwcu9v0JsbIl6AkByRbipWgLFXv+xTkHOROuMhI7EHhqscSv4Q7t8NRre90egLiEw0VsPvIoQbIWiqh9VzDCxQxcE4gG9WruKicFvqjK7b/z0rSGiUIeN2nDWpdpylmXPn0wS4JP2qN0bErkSaUzu5oFgVr+u9sm+v51SRbDhykRP0LjuDk03Wn5CFz73eWn89C522S5pVL8umc1VgUQmFbG2gAfsPRnt2FnuxryYhAM3pGFdWdI+vVmmLQz757QNv8m0+qXcqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rN2OtOA6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::449; helo=mail-pf1-x449.google.com; envelope-from=3oqhpaqykdmwaws51uy66y3w.u64305cf77u-vwd30aba.6h3sta.69y@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rN2OtOA6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::449; helo=mail-pf1-x449.google.com; envelope-from=3oqhpaqykdmwaws51uy66y3w.u64305cf77u-vwd30aba.6h3sta.69y@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmzDY0n5Dz2yVv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 10:52:28 +1100 (AEDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-82c646e980bso751688b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 16:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775173945; x=1775778745; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NRFfWyW5OJQnxYPyWhMs1ziwQUg0nXafSfiE/IeYP3E=;
        b=rN2OtOA6pBNYoNGzb8OXwq/5ZHlwLVAL/hxOdNUp1ErdcsSk6CZVMjqznGFDaRAHuf
         qMlp2w5Lqy87XMTVwlYm44KQK+G7tvx0t/Hj9m0ZoDvg02NxUaKJEJIp72TP3LyQ+KQc
         R9elZ3wMr17MyfvS+rgirER3FgZ8XzgvJ/1Oy4G779upgMOHyo5D9MK/MROf5CRsbaQA
         vne3/To20qeD/+9Qiq0R6VkKgBM1xOSMp1BD85yzPoc2jP6HKRMgemSEbUqLx6U9SIq0
         be3bSmLaDEN3oM0+SuXH2iYNQqFiYtHlnzlfoDp/ZEiDF5wa08UYAItNpStHncZyDn85
         CgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775173945; x=1775778745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRFfWyW5OJQnxYPyWhMs1ziwQUg0nXafSfiE/IeYP3E=;
        b=gK9ywctnPuKGvkgUn6+DRkAUUZRE7FLszANJTpEjw+VeEmlbup9t3zSDTfE1NNd/Jf
         udigeCsZRbyzQq21YZkqnr/duHGYlHOpgUaWvJm6/JYmVpX0qIUSbRRZuf4AMwBsjBOj
         DTtUKkwkIzXFFdu6/RGxstKexrvru/bD9u3elE3CpAlhOlDVCXl1LZNYk6zMevjGT0aq
         /McLDZ204/LqCMa5otcSf6pfZRrkE02lk6o/qF2HQactCiSRc/sqDRNIKVSaRGw/DnwZ
         p9NeToRkLJC/nACBQOc43IuUng3yjsv2lC5fwidNWnectDrXkBw/9wQfIG2NxWTfuKe5
         uiWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEYlVlvIBwG3CtTRC2ea5A2qkLzJr+V6T3/OJVWwpTd4rG1lIPf1D2By0DZoEEMLJwC9noJch/l9obHow=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy1CL3fX66jMCCCM8xcf9OtPNeZl7mbJOssjDkRhP7MHtkNKrfP
	FX3cm3B1GiOsYYHhKI/pz03kQNCyuVIS8U4DTTRBVZQ7tL3BMrcHBZ8peEC/GHLSIvRsPfFflp0
	khqoIQg==
X-Received: from pfqf9.prod.google.com ([2002:aa7:9d89:0:b0:829:700a:a1d2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1f0e:b0:82c:26a4:df02
 with SMTP id d2e1a72fcca58-82d0db8b083mr815883b3a.42.1775173945247; Thu, 02
 Apr 2026 16:52:25 -0700 (PDT)
Date: Thu, 2 Apr 2026 16:52:24 -0700
In-Reply-To: <acxjMsx/UixNa2R/@pedri>
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
Mime-Version: 1.0
References: <20260325092001.613025-1-peter.fang@intel.com> <acsvbxIdtlQzUw4q@google.com>
 <acxjMsx/UixNa2R/@pedri>
Message-ID: <ac8BOGXIPMnJ7kIg@google.com>
Subject: Re: [PATCH] KVM: Fix kvm_vcpu_map[_readonly]() function prototypes
From: Sean Christopherson <seanjc@google.com>
To: Peter Fang <peter.fang@intel.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	KarimAllah Ahmed <karahmed@amazon.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 31, 2026, Peter Fang wrote:
> On Tue, Mar 31, 2026 at 02:22:47AM +0000, Yosry Ahmed wrote:
> > 
> > Most callers are converting a GPA to a GFN, I wonder if we should make

Not most, all.  The two outliers just do "gpa >> PAGE_SHIFT" instead of
using gpa_to_gfn().

> > the function take in a GPA instead? But then we'll need to the GPA not
> > being aligned to a page boundary (either do gpa_to_gfn() in
> > __kvm_vcpu_map() or fail if it's not aligned).

Just do gpa_to_pfn().  If someone gets confused, we can add a comment explaining
that kvm_vcpu_map() maps the entire page containing the gpa, but that should really
go without saying...

> Thanks for the feedback!
> 
> Mapping guest memory into the host feels more like a GFN-based operation
> to me. struct kvm_host_map is also designed around GFNs/PFNs so I think
> using gfn_t in the function prototypes seems more natural. The caller
> can handle the offset-in-page cases without creating a lot of complexity
> in the APIs. But I'm happy to rework this if there's a desire to make
> them more GPA-friendly.

I vote to rework the APIs (after first fixing the prototypes) to take a GPA.
I agree that mapping a page at a given gfn is conceptually more natural, but
as Yosry points out, requiring literally every caller to convert to a gfn doesn't
make a whole lot of sense from a code maintenance perspective.

