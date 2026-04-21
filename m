Return-Path: <linuxppc-dev+bounces-19915-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135FAF94CB6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 23:19:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0dbM1vfvz2yvV;
	Wed, 22 Apr 2026 09:19:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::64a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776813551;
	cv=none; b=CUWcnmCijgzh6TwpK3SbzU8axzspMraKLRjE29BnNZli8ZOd+E1EpVog53aruGM1Dtwvx7Fgtl3K5X1gZ5klFS0eUwBrlS+54gcIyaWjF7yYU7+FIVcp83CmYLfcADmNbIPmlGKwliPgIVQWRDHzZaV8n+RD7aAwuXaPGcs4JgKBmWQTHrBzexAB0tU44ui9VknFnq10f43s/JzwB6uSf6gaL7kU2dLJ6Y6Sc5kL6P1Rl28Y0qeFBH1GhGzED1Mk2pPe2xZxQNrNTMdi3iSaMQ9x4+0GCiTyTw/4D9UY39srp0zCK40TxIpW/bXOEKa+QWUnl8uLBJkD5WUMnjpsmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776813551; c=relaxed/relaxed;
	bh=kzFNL3zJHiQW2Vbyq91237YpRLX6Z7YBrHD5R7EMXmY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NX2Gc8SSw8/3ekPW5iJikzSXlSba8mixgQbO8/HLnEaFjPkso3FLTgsEy5Wlt9LWchD1ymW9+QaTF71EoxcFFN+Qx06qg493Aekg7VDMpZUJi/nAQbgw+cp3bDLhILYGpNAmOIlLEfKHlqtnHbT22XsxiYHSRCX6WJywNwKRrRCM+ldG6oZ+sSjDrhT5stMbO4v2wCTF0zP/t9FN7nNF/A9/cG9+2koaGNvpoPPzWvx7Qj7GDzLCH8YyntlEbanTnoLsfRcf2Sdrx9LLNQMMQTwL4Tz5GHaXgvJwEJa5Z97Xu8FVjh3+IGanmWURa0W2ZzgGV2Li7+hAURNWGwzcMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=V76URM5o; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::64a; helo=mail-pl1-x64a.google.com; envelope-from=36qxoaqykdooeqmzvosaasxq.oayxuzgjbbo-pqhxuefe.alxmne.ads@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=V76URM5o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::64a; helo=mail-pl1-x64a.google.com; envelope-from=36qxoaqykdooeqmzvosaasxq.oayxuzgjbbo-pqhxuefe.alxmne.ads@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0dbK25cTz2xSG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 09:19:08 +1000 (AEST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2adef9d486bso43061825ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 16:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776813546; x=1777418346; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kzFNL3zJHiQW2Vbyq91237YpRLX6Z7YBrHD5R7EMXmY=;
        b=V76URM5o1FmmFsaQNBvZ6Px3N60I7nNTPqNCxZj19FWoR2/tJucTs6QeygHvysVfYX
         ktXzRfJrdN8urJV/nZ0eemI0Q+IlPslovcnk26DHLCyuJjuRH5MQ8W74VnuCzxSsrL5K
         jk/YAwmUGAsBetly1GaM9u/LcKkwX3H9gkfDHt1RkhEAulh0ANki79puBGHC+V1SQay3
         dtIgojJ/GTb4uW1f48vbP3lhN81QFnpjWr/8YNoSfbR/z+ycgFpSTCAIpjlaPKluKkdi
         acSpkC/z6631ucDCEPX6jzpnJSd+GP+Ozj9HbNpWrFmjwaMd9+lWtDAIgTj1LjjRfWOD
         BePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813546; x=1777418346;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzFNL3zJHiQW2Vbyq91237YpRLX6Z7YBrHD5R7EMXmY=;
        b=Eu/9AYJjWIzApgEykP6m5I/taj5TW/KyGy7jzEbVWR8M1bi5hEdmYToP0Qqjn6xv06
         xt9UiaPwETJRc0yzRWWemD5726Dh5VJqkJGTYwu+Fv0dhYR7CNqovIUrrhtWUdrNnF7R
         VuWuvcHHMXY/CF1FAFW15yBeQUDXFBDl4AxEa/ankW3FyxPam9Fem6JplWmD9K04ylMm
         cpNmZxs7udQFHSVWhSC5WddDrd3RN7ommo8sTXHoa6OlzddYIrn2WnDs/un5RAeZTnlN
         jGsQAWfNqnRUaSdzmHOO419yb8zubAve1sCZTdQZ3kavouPDpXG7Ib/Gv6nBeI7MahCN
         v7jA==
X-Forwarded-Encrypted: i=1; AFNElJ8GOLDEGAYpKaJRZspKOmo9ZrVGqAv8zfZkWEZ8FZQX+pYn4JSyHraSuqIUd5GODFXDvmVeR1CCkFjLvtE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzZf/xflmf3HUh4U8cKPTczCt54GPHU+NtzVStvmnMDZ6T9yv2H
	5QrscGBm0ubSZGRgzNQ60tDCyboczt3oo8vRc1kIyoIMpU3y4YnDYCOwuxG+nyztE4wfAMXiYkR
	AdqxkQw==
X-Received: from plu17.prod.google.com ([2002:a17:903:3691:b0:2ae:39ef:fd8a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c9c4:b0:2b2:712c:61be
 with SMTP id d9443c01a7336-2b5f9ed0b48mr140812005ad.18.1776813545519; Tue, 21
 Apr 2026 16:19:05 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:19:03 -0700
In-Reply-To: <aegDJssx-ZvbfggI@google.com>
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
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <20260408001137.3290444-4-peter.fang@intel.com> <aegDJssx-ZvbfggI@google.com>
Message-ID: <aegF59gToidudIUC@google.com>
Subject: Re: [PATCH v2 3/3] KVM: Take gpa_t in kvm_vcpu_map[_readonly]()
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Peter Fang <peter.fang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 21, 2026, Yosry Ahmed wrote:
> On Tue, Apr 07, 2026 at 05:11:30PM -0700, Peter Fang wrote:
> > Move the conversion from a gpa_t to a gfn_t into kvm_vcpu_map() and
> > kvm_vcpu_map_readonly() so that they take a gpa_t directly, reducing
> > boilerplate at call sites.
> > 
> > __kvm_vcpu_map() still takes a gfn_t because guest page mapping is
> > fundamentally GFN-based.
> > 
> > No functional change intended.
> > 
> > Compile-tested on x86 and ppc, which are the current users of these
> > interfaces.
> > 
> > Suggested-by: Yosry Ahmed <yosry@kernel.org>
> > Signed-off-by: Peter Fang <peter.fang@intel.com>
> > ---
> 
> I was going to suggest a WARN in kvm_vcpu_map() and
> kvm_vcpu_map_readonly() if the passed GPA is not page-aligned, but Sean
> usually hates my paranoid WARN suggestions.

Heh, for good reason.  Adding such a WARN would be triggered by this code:

                if (!kvm_vcpu_map(vcpu, vmcs12->posted_intr_desc_addr, map)) {
                        vmx->nested.pi_desc =
                                (struct pi_desc *)(((void *)map->hva) +
                                offset_in_page(vmcs12->posted_intr_desc_addr));

The PI descriptor only needs to be 64-bit aligned, not page-aligned.

