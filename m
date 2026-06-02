Return-Path: <linuxppc-dev+bounces-21841-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3763CCD6E57
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 07:16:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV2Dq1YmHz2xy3;
	Tue, 02 Jun 2026 17:16:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780384571;
	cv=none; b=JN4Qd7YVEAvNyaItTJGhHrW1qKjeJcdy6I4dJ2Uob6ESZes9ykqMe2ePSK2/xmgveHp45Asfz9ghXrVtDSOGUGnjJqEtrQJsgxnuysVvXUcdwKbCA1fAd4ZinI258MFg3l55x1b3WZlAsRqTo2K703vmwkOz+Me+hM9VgTP0waKlZManPkkXqxZ9VspNhDtf/RsCGHDSVzyf93awug4bl3/23RwX4228Dq61Y8+kEKVjQl2/CSfqqf2fPTxiG1PLWXiU07Oca0pjKMT8TeCGSHOP0G0hk7HuJSMDGk+i68sB+PLaC6BZvdjPGLuELmSuHzp4MFz1Tv+ar0e6xu5Jyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780384571; c=relaxed/relaxed;
	bh=+tr7lju0eN0VwcHqpO/c52DT9rHJ2kZQnj1NlP5AASY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzKDXPEr2W7jBKWGhCGXGOTVBoC+NyHP0tHJywLJeTeH9sz7ga5p0G9MRWf59cKtH4tOI8u6hVve+Z2vNt6v/75Ycl5gPSTbbUU6J7p+tG5mi+tqVqxqZV70p6scMv2GnbL1xCY0gNOmRKErDEvRsxOhMeuLKkdSBAHWNLGh7o+LWmsiu2HdRQCi29wvyx5x+qgfelX2pP6/NBFID4dOQYTuRoEbPbN66lvcz+lk69fTWEBnJv3Wu86caSOfGcycmDbOssIZ+oGRP7UTM7ieM3NgNS6pBxiO7BRPgHTyU8cg3hDGkBCX384xG6DiqYJLlJR18Mq1LPrEjvrqSI87cw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s4Qs8BIk; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s4Qs8BIk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV2Dn3jP4z2xmX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 17:16:08 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-36d98c9b596so1452159a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 00:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780384566; x=1780989366; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+tr7lju0eN0VwcHqpO/c52DT9rHJ2kZQnj1NlP5AASY=;
        b=s4Qs8BIk94FtFWq4GdifsA8ujZN69Yc3RcoHppPQXX0I+fOqqRXVKF1G73l2lJJoEG
         tZHT6rVwH6ma1tFzHeirPVsDp/zyX5jaSFHdsVcESkkQ6J0YJCS2pPVM020DfNp8dMvR
         YtFEsjl5KfbcuPkRTvKZWsT/yvtXMONghhYaXjrX93AG1wIO2rMu5BnQeW4p3X1vPwZr
         Ew+2NGCHeyT/8zR4FSgf1WevKkwAEBO11BuB1rzrUJEcMj/xOcSoJhc0LZ1BsXPBneqF
         MeKJCFxb2yXsmv4CeAILVsdVUj2tkfWAjHqd3qyjZwanW2u52/TrOiVPWC0K1g1nNMUc
         8a8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780384566; x=1780989366;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+tr7lju0eN0VwcHqpO/c52DT9rHJ2kZQnj1NlP5AASY=;
        b=bMXB3JELS3kmzOJkECi3NREhtD7goGoC1FoSCGH6tcCSYW0ihjIu1rW6f+91EHNdXw
         vHrQ0oDRwIU+FppEWwY8bJRqB0/j+qh0HxdfRRVfzNXMnMSPWLdsdL4gscYNOAGFKjQB
         OvvdSVBACl8e0jKxV+yzYgVZOdKIXqtByp7sEc3Oj/5/Em5UEZENjiUdAkG4HBgjhACV
         G7AKbnGWG8QwmPb3Uw3Fcy1DT2dEhAprKwNxXUJEb/mDp98w3QT63q2MGxEsnlSuyxDs
         +ZsK2pizhJpA4GKaL3FsU2rMfALRpi0WXQ3vrEj7ijY1EekQ8inJsFPCRXSSU45EI12k
         8bKQ==
X-Forwarded-Encrypted: i=1; AFNElJ9788QTwrzDBCqCQJWte6Rz3eXI+2cchzrrxVDq75J97lbOqzLnDX1nR0ldWeuOsQooSQ3JiRwA2SwidO0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxcPDiK4Kw5xZeSrHhyshXpEnh/xHeod0A7d8NFhR+VY/z4DF6+
	ebViBG5sUCQenSdMR3yvAQVkcXC8k4RZ2ybDbbHXqrxJyQ/T38p/0hKR
X-Gm-Gg: Acq92OG9BJS2SA6HZhR2kGrJDyCHYiX/JLL8nilL921WM6Pj8CfZ6fNtXSVkg/igZuU
	XVN124H3wqpWc2u9escBVFgfZaqSjDLSaM6TwS/L1g8jIfNoN3LlfIo7yQ/NpayuLlZyupQHCgP
	M6UF51r56ucv49BLdaW7NuFLWa/DiE953/oESwrtaqhs54Mpkdj9U33gCUBiLkE0h9BVBcpdlV3
	ObX3Q0138FMhk+M8QAEKpa5ep04Tj7CmBsEik7RDVMkVcwcbeh6AyHw2V7OpiIa3ZborF74VK0S
	P9vuBl3tL42Pk6EC3LFchECEzqRzc4wVHLinhLuiC51A3cgMC6UAEv8lodUy6GqA2vc6lK1F04X
	3ExBstcOZK8dKCjFQ8NPwWBAtVs3QB6RXlFExyTz/XgE+/vU5HsKB3p/Z1g1x55OxFzvRV/kHIm
	as8+vl2fsVlAUKBkYrHIJ/RAb+PbFS02TY6k8G8gAHNhIbauK1wEQeF877/nz4f5GizfmNO5T5C
	6Htzw==
X-Received: by 2002:a17:90a:c2cc:b0:368:147f:bd2b with SMTP id 98e67ed59e1d1-36c5020a69fmr13824981a91.23.1780384565532;
        Tue, 02 Jun 2026 00:16:05 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36dd98797fesm1680774a91.13.2026.06.02.00.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 00:16:05 -0700 (PDT)
Date: Tue, 2 Jun 2026 12:45:33 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, peterz@infradead.org, 
	jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org, 
	ardb@kernel.org, ojeda@kernel.org, boqun@kernel.org, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
	justinstitt@google.com, daniel.almeida@collabora.com, acourbot@nvidia.com, 
	fujita.tomonori@gmail.com, gregkh@linuxfoundation.org, prafulrai522@gmail.com, 
	tamird@kernel.org, kees@kernel.org, lyude@redhat.com, airlied@gmail.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH V16 4/7] rust/powerpc: Set min rustc version for powerpc
Message-ID: <ah6CsIo3N09q0Kj9@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260520064630.1785283-1-mkchauras@gmail.com>
 <20260520064630.1785283-5-mkchauras@gmail.com>
 <CANiq72nPOMkZXpMpwTLFg4xjFfmyf_O_x2FN_nrNBsxeNu178Q@mail.gmail.com>
 <ahVb4k-2rC4EYZF9@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <DITEZRMNTOX2.1DKO9U58508S8@garyguo.net>
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
In-Reply-To: <DITEZRMNTOX2.1DKO9U58508S8@garyguo.net>

On Wed, May 27, 2026 at 12:15:39PM +0100, Gary Guo wrote:
> On Tue May 26, 2026 at 9:52 AM BST, Mukesh Kumar Chaurasiya wrote:
> > On Mon, May 25, 2026 at 08:16:53PM +0200, Miguel Ojeda wrote:
> >> On Wed, May 20, 2026 at 8:48 AM Mukesh Kumar Chaurasiya (IBM)
> >> <mkchauras@gmail.com> wrote:
> >> >
> >> > Minimum `rustc` version required for powerpc is 1.95 as some critical
> >> > features required for compiling rust code for kernel are not there.
> >> 
> >> Which critical features?
> > Hey Miguel,
> >
> > Right now i can only think of inline asm. I can rerun the whole thing
> > with 1.85 and figure out the issues with 1.85. I'll get back on this.
> >
> >>
> >> > For example Stable inline asm support which got merged in 1.95.
> >> 
> >> It is not needed that the support is stable, but rather that
> >> everything you may need works.
> >> 
> > I wanted inline asm be stable, I was skeptical about inline asm to be
> > unstable and potentially messing up the whole system. That's the reason
> > I waited for the stable support to get merged before sending out this
> > patch series.
> 
> AFAIK inline asm is only unstable for archs for their surface syntax (i.e. name
> of register and classes). The rest is just LLVM inline asm. If there're codegen
> issues, you should gate on LLVM version instead (Rust supports multiple LLVM
> versions in a single release and distro may use different LLVM than rustup's).
> 
> Best,
> Gary
Hey Gary,

Sry about delayed response.
I'll check if the codegen has any issues. If yes we'll put a guard on
that. Meanwhile i'll also test out the 1.85 for any other issues. Thanks
for the help.

Regards,
Mukesh

