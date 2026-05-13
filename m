Return-Path: <linuxppc-dev+bounces-20921-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494EACD37AC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 17:33:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gG0tg5kYJz2xld;
	Thu, 14 May 2026 03:33:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::549"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778693627;
	cv=none; b=bRYBVw7QB9vHa2DMo9KkeMd8SL80BojfLSnpKo8HtjV0zU+pzW5xXBJiu+cNVsKp2qMO1Aiqq5bk5WzRpYjbGZOaY54X3AeGc9Uev7kI3tFDH8//JWzEdAXJPM036daq/0fQb1v9FnVptPqGBfcO3IYowR6At8l/z3NAvHqd7ixiOJlS4mD/ujxISBIREhLS0wd5A2sRKZNVoJqrUQahuJi7tJKIbJ3Yviz/zerh6MCL5Zt0hKc8xc0/lFLr/rzOEIk8uynuFk7IeeqX8jKjLYYcGXsu+7naB6xOQzvrzWP+tET9q4IPZj1Uqar2qcZBWTFHrwhjPAiqa2MhK0PYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778693627; c=relaxed/relaxed;
	bh=jMEgM1iZspGG7I35Q8gjdtCOP5swckX6p2O9sp5dK20=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gjnjDBnHIJPKfDSBpY2zhBaZzMW+EzW3Vlcct7a9O5btOi6kv3cBwzHqKC+t/vFiudTN8S9igChje+dApg2PJLigdwdoQhAdU32OvxTf4yL/9HLIM3Nzt6Q2ghGFKuun1i3Ov7Pj8f/s9RGptrPRGsziQcR9M0mT1XNRrrzmvnujAngeDopRPrmoskxQADOLH9gOY2Ysdxuvt7PjKHjcAr0JePr01ONHUrQ2wVQbE7p/ecjtxIV8G/uIlscmbkELlVbe6+VxyrepeAcWpSC5wqQCbJdZXyiCOl6+YVrcfywF3NaI7KrDortkiXuCxhEPcAVxygQ3Q7fW4jbNKjONLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=B3K06FIr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com; envelope-from=39rueagykdms9vr40tx55x2v.t532z4be66t-uvc2z9a9.5g2rs9.58x@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=B3K06FIr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com; envelope-from=39rueagykdms9vr40tx55x2v.t532z4be66t-uvc2z9a9.5g2rs9.58x@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gG0tf1J1mz2xlV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 03:33:45 +1000 (AEST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-c827c880e39so2456629a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 10:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778693623; x=1779298423; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jMEgM1iZspGG7I35Q8gjdtCOP5swckX6p2O9sp5dK20=;
        b=B3K06FIrw+gzxcBByZ5BkzNjBFp1ffTQIbNRvIJj4NnaP5Qb0ma7XQmYwQhyiKDwZT
         MOxfkt+D1varztwPdtzgYA4tJAdOA5cegWlT0eUJWIH7uUo6XehTXh/MaMatGXEIgw1G
         L0CXGIvor8N4DPBWMvGE6QS+HvI0gvqc0dw0b7hdjrH37p5zh4HHqUbXkbW47JM4nc6w
         yJJ98Jpp9QCXIspmv8m7d/nLvyLtbJuujyByh9rvh/SvZYt6Gu2KUSIDLdhhu9TI9lBo
         nZ8yGgUrS4DIBuHW3K2j/PLmjjStWiwZNW3MKtheiLqjYzh8S4s1ZHMJT2RQTJZHiIni
         Jpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778693623; x=1779298423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMEgM1iZspGG7I35Q8gjdtCOP5swckX6p2O9sp5dK20=;
        b=lQWo7UvnO+mRQOo02Mxs786FTWHeAovPLR1gKBPX7KNwMV1uLla0dUwOJapEXcLz6l
         lY99o8etG9eup+5VQ1407i+qX1fSttBRIZYLIfVkD0ptCJPMRvxTd3qoynapKeudvofR
         1qOMdvt+iUJyG0CEAmDUQ6I19hqqhtC7Nlt35mg8ItO4JSSZoIPD6w1XSJjh4jXgAwNy
         KQl4enMs3Nf5ZCjsx0cDOvfKAY4PXJp3Il0s2NjAziuXjdlp8EOnK+HqishIQtK1AsIF
         ++sXxkwCtHsxsGnizhiBjbXrpb9esKDZkQYV1+bFf7jCn3BZXwt2HT1doxBxRYI2I0ZH
         b1cQ==
X-Forwarded-Encrypted: i=1; AFNElJ93KsCDt2BwqiRpr8tudQ1cVNhpcMHs+X12l6CpLq39k1k2vLBcyrly7P5d8kVcvS7KRURz8vZH6EFxZr0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywz28H+m6R87SgnwchzOaYWuP4PZAidQVgwYzxkHTObNp3jF4Mc
	nHGyY68Gm/zd9L0cAG4b11Ve625W8q1kImRbkGQVz93H30LF/GDwFePjG3c2jgbQ0guiAKIfmhy
	BnRS/7w==
X-Received: from pgc19.prod.google.com ([2002:a05:6a02:2f93:b0:c79:83b3:cdf8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9982:b0:3a2:d79c:4161
 with SMTP id adf61e73a8af0-3af8248bdf4mr4453790637.47.1778693622726; Wed, 13
 May 2026 10:33:42 -0700 (PDT)
Date: Wed, 13 May 2026 10:33:42 -0700
In-Reply-To: <20260507081855.GA362060@pedri>
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
 <c2fad21764d2561469151f5dd5d35833ae8f76e6.camel@infradead.org>
 <20260427080554.GD1733452@pedri> <afjeahNaSG0zsMgx@google.com> <20260507081855.GA362060@pedri>
Message-ID: <agS19k6eWBR9Xv3v@google.com>
Subject: Re: [PATCH v2 0/3] KVM: Fix and clean up kvm_vcpu_map[_readonly]() usages
From: Sean Christopherson <seanjc@google.com>
To: Peter Fang <peter.fang@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Fred Griffoul <fgriffo@amazon.com>, Yosry Ahmed <yosry@kernel.org>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 07, 2026, Peter Fang wrote:
> On Mon, May 04, 2026 at 10:59:06AM -0700, Sean Christopherson wrote:
> > On Mon, Apr 27, 2026, Peter Fang wrote:
> > 
> > > Thanks David!
> > > 
> > > I think I'd need at least input from the maintainers on this but just by
> > > code inspection, the kvm_vcpu_map() usage in sev.c seems a bit tricky.
> > > Unmapping doesn't happen until right before switching to the guest, so
> > > this might fall into the "keep the mapping around for a longer time"
> > > category [1].
> > 
> > It definitely falls into that category.  But that code is also rather gross, i.e.
> > could use some cleanup no matter what, so I don't think it's a good argument for
> > keeping kvm_vcpu_map() around.
> > 
> > To avoid a bunch of pointless work and churn, let's hold off on hardening and/or
> > renaming kvm_vcpu_map() for now.  I'll take this v2 as-is; even though taking a
> > gpa instead of a gfn will conflict with the nVMX series, it's dead simple and a
> > worthwhile cleanup even if some of the conversions get discarded shortly after.

I had a change of heart after looking at the applied code, and after going through
Fred's gpc+nVMX series.  I don't want to have a discrepancy between kvm_vcpu_map()
and __kvm_vcpu_map(), even for a "short" amount of time, and I do think it makes
sense to pursue switching to gpcs for the nested code.  But, I also agree with the
changelog's statement that __kvm_vcpu_map() fundamentally operates on gfns, i.e. I
don't want to "fix" the discrepancy.

The other thing that swayed me is patch 2; I have a separate patch (amusingly
related to gpc stuff) to extra gpa_to_gfn (and others) into kvm_types.h, and so
I don't want to take patch 2 either.

Long story short, I'm going to grab only patch 1.

