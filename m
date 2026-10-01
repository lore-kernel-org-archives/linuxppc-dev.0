Return-Path: <linuxppc-dev+bounces-28701-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09F9CA5FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 21:29:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwlR62tZRz30DY;
	Fri, 02 Oct 2026 07:29:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:30::e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790890146;
	cv=pass; b=Hz91n8BPof13o/YAFRwoGh2OfnG/M2xv5XwbKnpJzmT6dcwyUbrg/yewdnIQuGKOc8gUEIwUSH2Vmi2QFU+IpDgn2HzJrFBcFPR37O8ZzZ2A0enwrKuGaslbBXhryrhPtrLTT4KDtCpEuYKOl+ZdvssiRC4CkxpwswbhdXpvPYilyRVul4P2YxnoV7eOufkySlo+3DdgXqxiTwabQhUWnVpw2UU0tnA4rSEF9Qw3kZcaXk0roOW+ZDlhscsm7OoLZ1kR0DpbDxo0cc6IHpLGUxmBCpEd+cE5bQ0RmfLlQ73sTlLkIfKrzUB+1XZxNUFaDOy7iG2bXIFrbeFTcX6HDA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790890146; c=relaxed/relaxed;
	bh=WQ1yE7SGQ1qvkGbYQM1t2aSAp7h/GwrmhNcmVEqa4TM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXFC+g3QD8ull2X8SgMiaiUYosQM7QsISBUZYpbsb1ZCtxxMV2YgLAjzel/aUWPOT0Ib8BnteL4gsmoCvQTP6v/LFhs/Ckuj/WZgaSbIz4U2H0jisO1QEROOaE9cL2kuywxhP7HsVFqJ1slyDZPUz3+hOuqkp+DpXwQn7BHazRSrDvtAu/DCkxcNVge8hEB7iJ95t69JJK84hTxFX43OhODLh5n58q5BXL5mmfKo5hItzBWCE+8T5H8xf6uArp+tBjHujz/YWCr4KqxnevGyJgxkKtl9p5yAIXRrP25nspj1I48GLUHF/wfwXXvKjIfvgjvZa6db7FKkGwBPIXqDNA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=JX/w/Mu1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:30::e; helo=mail-oa2-x0e.google.com; envelope-from=jthoughton@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=JX/w/Mu1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:30::e; helo=mail-oa2-x0e.google.com; envelope-from=jthoughton@google.com; receiver=lists.ozlabs.org)
Received: from mail-oa2-x0e.google.com (mail-oa2-x0e.google.com [IPv6:2607:f8b0:4864:30::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwlR53S3cz308H
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 07:29:05 +1000 (AEST)
Received: by mail-oa2-x0e.google.com with SMTP id 586e51a60fabf-49e0f8c0e59so477124fac.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 14:29:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790890142; cv=none;
        d=google.com; s=arc-20260327;
        b=DMe/w2/gLTo+aDQ9i5xMTCazg3oYIaLFO7aK3VHD9X6ejdtSR/1O9ogkw8uCOC+gD+
         Sz+rP6sAwILmIwez+7tQTncDDm4ScChqEehK3i7c9M5yi2Uwx4dO6AKtmxl4VNatqKxt
         PX1IGfOTNa8utDVQc5SKeiyEOm1oY7oJDJBt9vWEoDhbdg3ezieXO4sGWfwSlLOte5lm
         OBGPBdJKDtxt6u2hXkWl4PNOIYgPnL6DW+Q2Ryr30VWHDOTdI2wu0tn1HT5OMSoRKyVR
         mRps7R3/dCSLw7rNr/BdBN+vWx/8HPnu8xADX2msayRigx7TTU1EU+XstwOjkEueiF1S
         AbGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WQ1yE7SGQ1qvkGbYQM1t2aSAp7h/GwrmhNcmVEqa4TM=;
        fh=jaWmHAOJ9aujzVMGDFuE2xUO4dp9asUm8KPqPZhzaNo=;
        b=QLQt1XMoJOOPI6ddUX60sUhGjZEoP/f7PA0tw3BDCa5GFJpNXqyg8lgess6aaHlWpo
         L0gjtG+ZKJW1fprcM3G3Pm4C2q05WX6xwpFe/LFscbe8mFvqE+TvfN5MUv9PUbMNItdw
         mly4ta9LToPzL1nURmwaN3KJtly1dT+uR1zbHYs+Eol6T3r5s+b9vj+VclL9kWYMClwA
         5gUCzEgZpZeUpaKH1o3U660gl0mLohVTRTtS7+4uufhVYiqcQKzJGpsA//G8xVcBP50b
         H6N2Tv7OsGtZgIbBeV4KE9n8C5NVbFi7EU+FNlVcRZ4Yg5bMwJQgEahAkT7nYSI0hjcq
         30Vg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790890142; x=1791494942; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WQ1yE7SGQ1qvkGbYQM1t2aSAp7h/GwrmhNcmVEqa4TM=;
        b=JX/w/Mu1r71Rvn02llIlqqvMja0pNGYh3j5AuGlFUMKZEGhUMZhIE0YIwWKRnWfLb/
         luaVx+jctMuv12w3Y0o5Hh4RaodnwT/YLsvmBO8L7c1IXKkIKXWmhv2i9D3rVzQhedLQ
         S8XJDpkJqiPt/nOhZqHYIByLtpr1g2OhGbaVV3p5LRPJUggl6BBcECNyZR8EroCkyhC0
         7rmbF1YyabqWZdjnIA0lvlA5gEPZ2VD6SxFvlkQ04sf0po5ZpVZugAfei4Dj6T7gg9Ss
         BEG03xOwahgiCMWoBZR1odrGae00Axa4AVgxHHC+R8kKdmaJP3WZXG56YXBDc+YPzIYx
         fciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790890142; x=1791494942;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WQ1yE7SGQ1qvkGbYQM1t2aSAp7h/GwrmhNcmVEqa4TM=;
        b=CCec7fGrIwVhxjLSYFsZFw096QX62P6JFYYG3f6TLuwV0An3fkB9/VLtAKemrS2Iw7
         DDrkbEY3Rg4PXaOjpk1SOOudXkvt+JJxXG6/g799OJzZJ9syMj4kZlggrFQsZnzELrrr
         xsSpZfL6W6s6kPuq9s3XmhPWdNXvx60VG6OYcB3qUSUewBbV8uLdRCexyebuApOII6on
         1ey71guc9UB8crRVp47YDkGzYXrQ1iyYNY5pAksq49XSN1owHKMsAwtsFPUT5b8IKUYT
         T/iBZKzfSOE77SOIWHLIsDqRZES68kSFZJhuxhPX7TD7CL9emLD1ek1RcbSbxJX+MnUz
         vKpQ==
X-Forwarded-Encrypted: i=1; AKwUvBxSwttuul+PEeTiRuaEnUXTGlYZlqMRqZ9ZBphejt17vDYwTMvB8L2kEapZPuRcz71l/ZW55paIRy2XNpU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nB1zpIcO+g8/b24BzZlGZ0KU2emlPXdx8izOjOR56V9OaEszeI
	+AxA/InjQc8PyJ6ULkzG9UpZOfrH/Bk44rufH63WoPgwqAyoaVVY/teUK9E1PRJT7mt545Vbwu6
	SHC1oTFfvmr4Bm0UBYX3wiyXaJA8me/HaoZ3e6MY4
X-Gm-Gg: AYBFou3QD/Mj/PthA5Bmh0EBtXWkQ5BYcnOP0CRlbet0+EpyMA9Z/pGl1nxzPVeMGuD
	WGSFQPGKBtNNPyLfPfJPQXUHQL9aNXnW0lfY2mKrDntIrxfRcnmR0oFCJb43plxGqFR+1C4py8Z
	JAgWkQ22lkAOMsZSEAeNPA7FrMh020F6yJdO/6ghxqanux93utm9vnIY/dvtkXZJlrgha28x632
	g/fusotJ3h3GyT7wKCH40v8Snq+zPeDSZAZ1QH3HsffDXcOj1EAqyPV9Ghvdd8gljcbEQphRobW
	ifMvT8cTDq65tgk67BjSuYrUMY97fyyr/hg1vygO0ZiHEEDTz8+KIXUF0HpP+8xQ3t9rI9r4F4T
	NLUgxWCBnkPBeucChRK5hGyEXIsyzKSZm6FHdwMVzwiJthOV3Jk2HYJOuKVFbbPFWGB5iwsFx4p
	TjCdD71/bhcRLcjvfPHhgjN4zZ7dzDHFogoQ==
X-Received: by 2002:a05:6808:c161:b0:4c4:a240:9c3a with SMTP id
 5614622812f47-4f526a4f2eamr499736b6e.4.1790890141800; Thu, 01 Oct 2026
 14:29:01 -0700 (PDT)
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
References: <20261001202234.3794060-1-seanjc@google.com> <20261001202234.3794060-2-seanjc@google.com>
 <CADrL8HWDy64UH0N4RCtvgL6zP93jnwr91xjkWerEs1MBV9JH_w@mail.gmail.com> <ar7OMwkZ9bc0tbzC@google.com>
In-Reply-To: <ar7OMwkZ9bc0tbzC@google.com>
From: James Houghton <jthoughton@google.com>
Date: Thu, 1 Oct 2026 14:28:23 -0700
X-Gm-Features: AclHuK9a_Pc6Thc4O4ojJav2PU4YvfKX_hMsholjFG7-3LGP_q73xLDGlS33olA
Message-ID: <CADrL8HX3GeCKekMoxMuvD7kM3ebHRCqEohiDHDqK-4_XX4rHxg@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] KVM: Reject user accesses to guest memory if
 current->mm != kvm->mm
To: Sean Christopherson <seanjc@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 2:18=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Thu, Oct 01, 2026, James Houghton wrote:
> > I wonder if it makes sense to add similar hardening to kvm_faultin_pfn(=
).
> > What do you think?
>
> I'm not opposed to explicitly hardening kvm_faultin_pfn(), but I don't th=
ink it
> would add much value in practice.  Far more arch code uses __kvm_faultin_=
pfn()
> directly, and that doesn't have a @vcpu or @vm pointer to do the check.  =
We could
> obviously "fix" that, but nuking the memslots (patches 3-5) will prevent =
all but
> the most ridiculous bugs.  Getting anywhere near __kvm_faultin_pfn() with=
 the
> wrong mm would either mean KVM is doing something amazingly stupid during=
 VM
> teardown, or I guess maybe the scheduler or preempt notifiers went off th=
e rails?

Yeah, fair enough. It would be of pretty limited benefit. Thanks.

