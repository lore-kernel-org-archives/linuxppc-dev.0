Return-Path: <linuxppc-dev+bounces-19908-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC5AF94CA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 17:47:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0VDN70Yhz30Tx;
	Wed, 22 Apr 2026 03:47:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776793636;
	cv=none; b=iyusEo0PXpY6OUX1ij9uNNHIwyqTN8Q11IPJ0aTEB6FYzLR0onv8vN3DgwsTekP0CArLWbu5NkQC3O57Y1qQAEQbBXyeC8sn0SZJBeEsjk+sCFnGdwgq9gOWw9116GT2FCxS6JkE8NdguQBJy7gKs3TEZuUIoA45z/W9Q5lWyNUhYMlFvCJPmIywq/v/W1O2lTvNoKy8zDnYzj/dKfWcG8uefyGqORAFJYNu9czWchB0LRVptqGEvUJpPE0FV3upSGdHEXAnYNbI/j6TcTLnRrUyQU+RPs9wdNe/CL6WKVKDLirEJe0m4iHcS7qWz7HInlAPiUjNQQHRGu0yLAj3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776793636; c=relaxed/relaxed;
	bh=H/mDrKOFxxuG8D7mTy6jMBe8ODvCnPyqTfBHZNb5vVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZk8XZTuIeOEUAyhEr5zeBGb8xoxJxvfn117mZJsl0NLIoG/94jHdD2Ei7OlfV0i89V5FqkZ7l5VCW3CEq6pInx6q7nprgmY6kwC2VkYk3x99E8+EOWZKVCYYGozNykIPDmSXcU8mL7PwF5UrRdEcUL4YMKy4a8eJYTScR+qGr9zNnCBqvXM5RcYLP+n8FwS74kd53fdnVtR9Ba2iJzm21+fphvhuFhXydb5Y0DGu8hG7OQB5R6uugKvG2cxTOu5W7SPIwZwqa/n0Gz/qBWyBWN2mYhv+HD2KU3sBykFfjUIWCEzR7GRVAbfGmtCAJZWpU3eWEltPctSK8UJ9IsXZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ff3TauZg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ff3TauZg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0VDM41rbz30N8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 03:47:14 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2b24fede2acso28947245ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 10:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776793633; x=1777398433; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H/mDrKOFxxuG8D7mTy6jMBe8ODvCnPyqTfBHZNb5vVA=;
        b=Ff3TauZgUN+RUKw+FjJY+r8BhI9+o4Zl9Xr4vmpjcu+Q4pR57W80NXmn+MTE9yi5Wz
         +yzKEBjmEuUmQZYKLpHJ5zs4Qg6CM7ubp7GoXrpfj87D5eb64tMtiLyqyemC+nxvBIBV
         a8ANPeOjW6xIXKzHb5Ye50AnnYTWV5FxCNFNWBr0f50c0C5gRN2c8QaDzBZzrnS5Ufao
         tX21FmkUJraV06buicwoYYBK0ixyFn99UmEVhlTYU/nyaldA6LxDe9Yzt4h+jBYPvaFK
         YDdjB7EEgx/MNuoaT3xEDTh5gIU02ohlMaY87DxAHIUOLg5AlMTqQ/MVPjNRWc2/ltyk
         jN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776793633; x=1777398433;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H/mDrKOFxxuG8D7mTy6jMBe8ODvCnPyqTfBHZNb5vVA=;
        b=E0OXIyRWCu/ydrC/lK3H2n6r7cpGI5IQokiSPDziyGkl627RT1bRaOIi0RMzDvW+Do
         PKBD0F2BkMir/X+uLwyobM5+ANXjl5+8IH0VWOCA95PmT97JMvLDgtad064rfXJudUdB
         Y2RSW6Wl3DBfZNGnLS3kXKgiWt1teF56MfyYdWW7bhQEtcwwAW75aa9w83yE1yQFzeQ/
         tnVw0dbLMoBH6DJVfu2mCkwqEM94DuZTMPGtmJMi6pBEEeMsPaNAlVOMQL3hjghW2JB4
         EVoVsakODziS+t9+JqPNGuIGhLmFY9EN1n8paxRzjMJ4wQgci1/aQkyaQ2oeGhWeYYx/
         YGow==
X-Forwarded-Encrypted: i=1; AFNElJ+U6IlQxs7mWCZtMQympjN0qxY2SXj7qv6JiIhBM2k2T6IH3GT9PLSa5bOG/M/1v/lKQTQcUZxOC8stlxA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyyJLqMaOmpItfhzAgOaLCo6Aa8xVlEm90zuBy4r1TxYHIw2qcB
	K5zzdL+AQ41Pux5ESMVx/RNHmMJmPkwKreGsUWJBSeOIkr9NQVEgaeWX
X-Gm-Gg: AeBDiesL35RIhQWFL1TULPsQ5Yco1E+npuslS1L4acbQec1w16uXv6/TJgTUg4A1zvh
	74X3qfxnZ5y32EHGBKuWL4sN9e2tz1g/jxI7FC4OVnwoVef/p886vz0t2+TjV4iDWh9bNRayFwD
	IMAY4lJKet2ZobDKBK3fG1nDGzm+6YKPkJ45r0PkMYOH0VDsW2+nBeOBkCdrlrtIJIyEheDlox+
	9K4Ft076JmtKA2dJ1WDa9WME4/rKIVkTYv1SgLS9XpGBxhyQ2tzjxST4yZy4dvG5GX6bsVPTvqp
	DBkwZnPZQApMuJfFk6+Enb4ZkN9O6LF0udWd7uycqfw7nrL3eSwrm2nbPSLHbx+VadiDyiqFyWM
	FgksRzxvrI/GjyOssztQb3kmyI+yK1xgN9FCaf6YcZ4uZMSX7hFb4rV/JXIjZ4yPT+lTxqw2PO2
	C5YRuvDnH9Spd1aRqxTBvJ7/pmZvSZgRyWGt6i4eboeR9Zs9HZW0mKthU6/3tJkTO617I4x6RfZ
	AM7UB72wJvb4rBPoLcY
X-Received: by 2002:a17:902:f712:b0:2b7:88d8:efde with SMTP id d9443c01a7336-2b788d8f36cmr33715215ad.7.1776793632622;
        Tue, 21 Apr 2026 10:47:12 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.164.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0d0f8sm132131255ad.47.2026.04.21.10.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 10:47:12 -0700 (PDT)
Date: Tue, 21 Apr 2026 23:17:01 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: Link Mauve <linkmauve@linkmauve.fr>, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, peterz@infradead.org, 
	jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org, 
	ardb@kernel.org, ojeda@kernel.org, boqun@kernel.org, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
	justinstitt@google.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH V11 1/4] rust: Fix "multiple candidates for rmeta
 dependency core" error
Message-ID: <aee3ivM9VkbqdQby@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260417152253.2312961-1-mkchauras@gmail.com>
 <20260417152253.2312961-2-mkchauras@gmail.com>
 <aedFgEicDW6LAcuq@luna>
 <aedJGuF9P2V1lOCZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aedQ629D0x-5KuKw@luna>
 <aedpk1iaeYyKPSOI@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aeds6_8Mr_w38oYI@luna>
 <aeec_IzVJwlfarN5@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <DHYYG7A745M5.VQY4GMDJNC1Y@garyguo.net>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DHYYG7A745M5.VQY4GMDJNC1Y@garyguo.net>

On Tue, Apr 21, 2026 at 04:57:49PM +0100, Gary Guo wrote:
> On Tue Apr 21, 2026 at 4:53 PM BST, Mukesh Kumar Chaurasiya wrote:
> > On Tue, Apr 21, 2026 at 02:26:19PM +0200, Link Mauve wrote:
> >> On Tue, Apr 21, 2026 at 05:49:32PM +0530, Mukesh Kumar Chaurasiya wrote:
> >> > On Tue, Apr 21, 2026 at 12:26:51PM +0200, Link Mauve wrote:
> >> > > On Tue, Apr 21, 2026 at 03:25:22PM +0530, Mukesh Kumar Chaurasiya wrote:
> >> > > > On Tue, Apr 21, 2026 at 11:38:08AM +0200, Link Mauve wrote:
> >> > > > > Hi Mukesh,
> >> > > > > 
> >> > > > > This patch doesn’t apply on top of mainline, which tree did you base it
> >> > > > > off?
> >> > > > > 
> >> > > > It was on mainline v7.0 tag.
> >> > > 
> >> > > Great thanks, they do apply there!
> >> > > 
> >> > > I needed three more patches for the kernel to build on PPC32, I’ve
> >> > > attached them but they are absolutely not patches which could go into
> >> > > the kernel (except for the second, enabling asm_experimental_arch).
> >> > > 
> >> > > What do you think we should do about them?
> >> > > 
> >> > Regarding the 2nd patch you sent, As the support is experimental as of
> >> > now, Let's wait till we get everything stablized, till then we'll use
> >> > nightly build for all variants of powerpc. Once we mark it as
> >> > maintained, then we can try to push that patch.
> >> 
> >> Enabling the feature is mandatory even on nightly or with
> >> RUSTC_BOOTSTRAP=1, otherwise no asm!() macro can be called and so the
> >> kernel crate can’t be built.
> >> 
> > The stable support is available on nightly.
> > Refer https://github.com/rust-lang/rust/pull/147996
> 
> In that case you should add the feature with a comment that it's needed for PPC
> only and is stable in 1.95.
> 
> Best,
> Gary
> 
There are some other build errors apart from this on 1.85. So few months
back in the meeting with LLVM team we concluded that for sometime
powerpc will be ahead of other archs at 1.95 till others catch up.

Regards,
Mukesh
> >
> > Regards,
> > Mukesh
> >> > 
> >> > Maybe Miguel can comment better on this.
> >> > 
> >> > Regarding other patches, I am planning to work on ppc32 once ppc64le
> >> > stabilizes.
> 

