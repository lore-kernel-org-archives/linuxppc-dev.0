Return-Path: <linuxppc-dev+bounces-25439-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFA9C55174
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 12:26:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFV5r6gMSz2ySW;
	Wed, 05 Aug 2026 22:26:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785932816;
	cv=none; b=HvFGuQODzlcs0fL27gDa2o3owW8uVdfMvqjU7U/IXgXNYyPivpQ7fXzGDtI3Y1zpRorw+WZXBK593m3IvPDuBhercJ/aXvsf1jaIeZge2CcAXB1bwQfjm26H8wAwkBdtl8M5+r6eFb9GIYPvTt6VgEcVgRR7YxheasjqWjlFPbETgakYeaOc8nJiOGER54iFdb3aujPVkYYN0DGjliHHxGnamtji1yaEGZhExR/87UBMaZLSxYHQEJRXA5cZAVuXzOU39BO3Po0RA5mrxo96zBOKsMyxI6JmwRIFb/Nw1Mvtw1eWYN6fqNYXB4RqdbmbZtF+FoqT2Gkd62OPEWYohw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785932816; c=relaxed/relaxed;
	bh=4zSS6W/f7vcLMC+n78G1WtF8yNf9UtnQtPxTkVsbxTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cs3RSXqMCo9Hs/DEGp8VdH8nlHekkGhfuewsNXpDPRllPvyS8TK746aUV60CwupNwQAx2sy+BeAOB855jjVrSoeKoJgtYKwoKPbwujhuJGCQrCnD52moB+tVy9FbtHuS7wUtsjOohRPlmAf4CZ8os0w0l4M0GGp5pyQaoJjBxWxrKVH71D/QRdBAu46LlO6FNX3yYewibRRGDAIwYXNeKSpONJLlMUpgOtyzsvqKwoCtYP4JLQ4c4X8L4pM9ExJeHA866wicmxMNLq1dmffvOf2Hw6DLV1BoY9/TCqMxCLYOlEgSPM6rJCG7t7f5zjuI/aAsPyJm/I/EtCSgohD8rg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pjKUN/8I; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pjKUN/8I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFV5r0WbNz2yMl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 22:26:55 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-38759bcd877so951294a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 05:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785932813; x=1786537613; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4zSS6W/f7vcLMC+n78G1WtF8yNf9UtnQtPxTkVsbxTU=;
        b=pjKUN/8IyO46S/miNnhGg6rgPsrO43gqrGbTDX0L+1SqrwhmmNUmryNQwPGk5mO4KI
         oH8GPXui0ntcbPmsmWEIcu6MPqKGF/FjsSkCR29bSBxIs4OcTZUGB9ok3+MolViSExDV
         jf69CabL2oZTcGUabY1oCyxB4TCytNouVd/iVHnuH0vyhrjWwKjp0hjYAp7s3V7+2iNF
         bCHMUb+xTbjD551vn98feM2Ho1DdM8+o5Q/hqaTjoSFNOVnyjAWrKrWltv9TQviJwFUA
         h6IlLE9rQt+JwhdQfVs22Mnonwo+nqmePKcCW8i7nhDioeenvYDSlRuzAzqwfVZc6tOr
         8Lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785932813; x=1786537613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4zSS6W/f7vcLMC+n78G1WtF8yNf9UtnQtPxTkVsbxTU=;
        b=pvIeCn1A8gi/i3ATV92Jzi7AYeWQ+bAm0y8VQq2Xcz5PI326vojTMG5clIjai9k2cU
         ZIDKbdXApYok7V8BZf36mM0lMCTbDb/eOMME2Bqh4WkEH/9xYiHaSHo2pOTtVFHA996X
         C8D9iAl1dztwrhq/7igNqroGAjwfIbJI9Z/6aZpXjM5BV+tWoS7h8UQQbmbqwY4Dd/7s
         bPFQBnjo1qrau3oHhH36/TZVbstqSUq45fUEZ2/FlCCJICyloboVdInmt1FJwX1m0Zyc
         F93PXDGAe24WZBx06UMbOPs+Z2dVlP/77a982bE+/L9HFcjorHzUwWWZPJxyG6P/gzpI
         gBQw==
X-Forwarded-Encrypted: i=1; AHgh+RpdSPZlk6HKkPFsEgqtsHBZOeo+otsHXxOGsAC74ijDs5Wb3eBxFjZg7S+D0vRPGzKay3SxRM3yYbybev8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyUTVneZYq9/5EbImZXxx1sCU8hOiz03nVoMhhH02DDi35CrigB
	rJmmCsLgxUCnZY6MwEonQbAzLcvtSSDntzejiwbt+QzTyExbCR4D4hqZ
X-Gm-Gg: AR+sD13bn2ZvAem7w7FSaVWchSvt8IA47qiKis2IG1URy4BjZRjW5UY5wF+K1urCVui
	9nIf8MWXQqQpbmGRimJrHnohuxJkCyTb6Bw+xO2AEqmvZIJXhLAWh8O54E/WuwmgSsUAxZlzc/a
	IjBVJ7nYVREAp5KadCmNet1KHyo1DBm0sktfv8ln8ewqOQArPZCYgmrHd+VUcVgPh5tXynlikpL
	ZTfbx1KHDYys2KKUBBZ6grKhfNw/NYlpMWQm7vZ4H4SssBOgECTRb6CfbsH7/iLq9QAn3Hnrslx
	LwxGkeDO87C8NgY9X0YDqIBifH2sZsdicbH4HKSn+u4S4V3E3A3gyZ0IbWMoytWIXsb/CIkJgJ7
	v6ehW6AJUaQni/PErhZMk0kZvMu0sC2FKJyf5o4+Lmu4vcW2BFU87LS+e9dvLPinrZpwgr7rtxm
	KpTtaO9wxfIcTBhBbQck0rhCuG5BGVQco/CoVYmu/qKKIZ729Ty5IO9ectegr2dFgbOiVAOrUHE
	xhhLapmt4uArsccunlVAiTdtali7JhOogayzFx/CbwoYKg=
X-Received: by 2002:a17:90b:5683:b0:381:26f:8f05 with SMTP id 98e67ed59e1d1-3903c5380f7mr6328805a91.3.1785932813141;
        Wed, 05 Aug 2026 05:26:53 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.161.124])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39039002882sm3109185a91.0.2026.08.05.05.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:26:52 -0700 (PDT)
Date: Wed, 5 Aug 2026 17:56:38 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Link Mauve <linkmauve@linkmauve.fr>
Cc: Nathan Chancellor <nathan@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com, 
	rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, boqun@kernel.org, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com, 
	tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, ndesaulniers@google.com, 
	morbo@google.com, justinstitt@google.com, fujita.tomonori@gmail.com, 
	joelagnelf@nvidia.com, gregkh@linuxfoundation.org, prafulrai522@gmail.com, 
	nsc@kernel.org, japo@linux.ibm.com, lina+kernel@asahilina.net, j@jannau.net, 
	airlied@gmail.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH V17 0/7] Rust Support for powerpc
Message-ID: <anMry3IyjSKhuGI3@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260708082454.1254320-1-mkchauras@gmail.com>
 <178574013457.29744.6211258618175255546.b4-ty@linux.ibm.com>
 <anG67Q6Y59kDqh-c@desktop>
 <20260804202217.GA1109939@ax162>
 <anMnoT0KLd5PRGmX@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <anMq59xoOrusKKl2@desktop>
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
In-Reply-To: <anMq59xoOrusKKl2@desktop>

On Wed, Aug 05, 2026 at 02:21:59PM +0200, Link Mauve wrote:
> On Wed, Aug 05, 2026 at 05:40:42PM +0530, Mukesh Kumar Chaurasiya wrote:
> […]
> > For these warnings below diff should fix it. I'll send out a patch soon.
> > 
> > diff --git a/rust/uapi/uapi_helper.h b/rust/uapi/uapi_helper.h
> > index 06d7d1a2e8da..acec2d2fede7 100644
> > --- a/rust/uapi/uapi_helper.h
> > +++ b/rust/uapi/uapi_helper.h
> > @@ -6,7 +6,7 @@
> >   * Sorted alphabetically.
> >   */
> >  
> > -#include <uapi/asm-generic/ioctl.h>
> > +#include <uapi/linux/ioctl.h>
> >  #include <uapi/drm/drm.h>
> >  #include <uapi/drm/nova_drm.h>
> >  #include <uapi/drm/panthor_drm.h>
> 
> You likely want to keep the alphabetical sort here.
> 
Yeah, Thanks,

I'll take care of this in the patch.

Regards,
Mukesh

[...]

