Return-Path: <linuxppc-dev+bounces-19004-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BEFFB3CE5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 09:22:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkm3l6SPxz2xpt;
	Mon, 30 Mar 2026 20:22:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774862531;
	cv=none; b=V8BeKtDnRkEB+btPgs97OtL8dWizPABxGrEUmlmoMXTZ+6ziz3rAWLSAt00zV6UXGdc/eQBszw7KfBI5VfIxkyVt2mry/rfXxLAFoF+p/Ou7Ki32rVHoMM2GABZKGBqQHLPrXTERWNdXSJiGebM1z3Tk7BTxRLnUDWfaMak/se+BAC/+7/0GnZU1zeDwJLkOMDjYZY38ARmc2Aq4de8dIh834zyY0Y6w+MpmnE1PNQUvmIa871Wk8deiGckDp6PSdbAYentkFvKicthogYC2wiFH8wCncUPGOIlvAXARi9tYyM5k66KPidevdNcl26dSIVRh+eMqohBqz/5H1sdTJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774862531; c=relaxed/relaxed;
	bh=jVgspVbKSqNvps5mZhjeK8culZtZFhhekIg4FPbzFto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xqiscf9Eiqx90tNlbcJBQvV10AGn0MdPY4pvr/2j7yYYvNt/pbvBG7N4ECycbdpBb12iFXLpLHu96x5RenhCUhkGinI8XnRu517D78LXNyQyXDdSvuyBCT0TI/vbfMVnV9cIQHbx9uAJDzdT60k4RBdKX4ssbSjfZMmtFa0PgZZTXfnKYN0RiOixBZ3OzvpOuyHcu4yyP/3TA5pYHT5ROq8MTXbk7svBCYpdqmgMzZM50WPWC9iLtE775opmW4m8e+SzAYkGcFba4MWrDFclHysDfolp73MtoT3gfH2YcH8to6pbuR2cM/OmKRbKkzW8CQEKn1rJeo2Mc4zHY+g0BA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KYkNF1j/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KYkNF1j/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkm3l0hRbz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 20:22:10 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2b2429f98d0so11133105ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 02:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774862529; x=1775467329; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jVgspVbKSqNvps5mZhjeK8culZtZFhhekIg4FPbzFto=;
        b=KYkNF1j/tw7KPDVXkkSOlnMxKKXqiOp6Mm2E9XLst766gCY7PA3MQ4vmN2WF6m0npx
         LhV4e3MzNb1/01n0KDYb5Szw/dtVVV205y1XyBgd7+vyQwlG26j9m5FuehDfYMd3Q/Hy
         VfxG9OQGPxoin5HXDeeMl+vlprKa9ADBru2qMnlnQN1GPiG3XzMOioWxY8NOmMly92qg
         +XNW8JOP2E+BBFsoT+6TerigefQ6dZRtWI7vU+XMT0NtuJAlpRbxq1e7uKulH7CPXb4D
         SEwo6DPOA1sx0XV6IKmf2DuT4GBHgY8PKOOadvwEpRMF32yfNrY/uiGLs8G4GoqECY9X
         irJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774862529; x=1775467329;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jVgspVbKSqNvps5mZhjeK8culZtZFhhekIg4FPbzFto=;
        b=h32ABCkQ1XUuQksMlG8y9tXCuWTThAEcUY0HKLI4PSzuqYO1B6PVkK8rL9JxdrfCct
         ZwhtenN5maRPDYBY+O2QQVClNuW0VdC8tvURYBMNtGpv+POdlFTDnDpf5PwoPRPWtDZ4
         Ddxif20U5CLAbwPFWTyok8CiEwvLqK9oSrbM9JyU5pJVcZfdAWdgRp9dlJLolEkdUtLw
         3TX9P8+6Io2aLMgTd3yU2tD4PBQjA+QJbSOcbT59PYHD5PjviqciymVBkAwOseATeH1d
         xlN6B9f9+jHnukJg/9FWDpBkEAgmV6aEEockyde3sGM3CaaTPN3aUzZoYsavLfM4xuy6
         THOw==
X-Forwarded-Encrypted: i=1; AJvYcCVlHf3HH4P2TMZtlzkvfPsHynIiu4o/n/OGO0BWztWyPcczbd/M+SAlzPCNZqMUYBpgAfi7gVuLD4oSqjk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyVim2I+KDj7AfmJcQbbl8U3BL1aV4P8YMjNj8zDeCGNa2jvsaL
	q0dTvD65Ze2s6Ey8bwZh1DaIDe+R9WR06BGh7DssJfyIOeNrJEHndZFI
X-Gm-Gg: ATEYQzxMAIJnWDD7clg/G/VEniJiCnDrdOLI4r2O+F0XjnPc196YOyZmmGQhy0yDv0x
	8cRTl3mAjk39fxEMjEMsTMPzz7FnvBRnD7IHDHtX0ioTdAMsxkfAB0ADtrLngw7ADYUqFbjHVfK
	aNuFrDtIGB3SXBqtTQ1VSYodt3djTSmQAF4YF9jN7q4jAydEhjKdpRt0bTCdRv5GMl5vghfY/xQ
	pR8Jk2KMfcQVEeWLO2eJtITQ0ycTDCiPxnUp9P7m3q7VO8kRaOp6WtiCvDgfmWDdqXsAJj+xUP6
	4/N4QAfPJRF17V10rhEuQlbYeYahu5M8g/vCzC/a4oeWGlBBPT+7M5HCt1wT+Jf1sjOqJLDw0Lc
	E4sC64m0Ggljzi478iFoeyEwl+SVSKknEQwQVea8wgU17o2cbiVFCZHtGuG6B0YL5hkemlGgh8/
	fAIMW1Qk2ZicPxN3O9m2508PCCf3394ZoBcyUGlrETAGif40p3lm3pzDjcYD/GHkIm1mg=
X-Received: by 2002:a17:903:8c4:b0:2b2:5091:1c1c with SMTP id d9443c01a7336-2b250912298mr35392955ad.18.1774862528535;
        Mon, 30 Mar 2026 02:22:08 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24277fb50sm71477125ad.56.2026.03.30.02.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 02:22:07 -0700 (PDT)
Date: Mon, 30 Mar 2026 14:51:57 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, peterz@infradead.org, 
	jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org, 
	ardb@kernel.org, ojeda@kernel.org, boqun@kernel.org, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH V7 1/4] rust: Fix a race condition in Makefile
Message-ID: <acpAVwKiHwFfenZ7@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260329160254.2592207-1-mkchauras@gmail.com>
 <20260329160254.2592207-2-mkchauras@gmail.com>
 <CANiq72nxgwPUv1AJhRQSFNWtV+w_a-VqK3VWtjaKncRJkNNETw@mail.gmail.com>
 <DHFH7TSMMSLB.355ANAWQS0N7B@garyguo.net>
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
In-Reply-To: <DHFH7TSMMSLB.355ANAWQS0N7B@garyguo.net>

On Sun, Mar 29, 2026 at 07:26:55PM +0100, Gary Guo wrote:
> On Sun Mar 29, 2026 at 6:25 PM BST, Miguel Ojeda wrote:
> > On Sun, Mar 29, 2026 at 6:03 PM Mukesh Kumar Chaurasiya (IBM)
> > <mkchauras@gmail.com> wrote:
> >>
> >> When compiling with -j1 flag in powerpc, the libproc_macro finds the
> >> libcore.rmeta both in toolchain and local rust directory. libproc_macro
> >> should use the toolchain provided libcore.rmeta.
> >
> > By toolchain, do you mean the sysroot one or something else?
> >
> > We should make it such that `rustc` does not try to use them to begin
> > with, e.g. we added `--sysroot=/dev/null` to prevent that in the past,
> > please see:
> >
> >   71479eee9da8 ("rust: Suppress searching builtin sysroot")
> >
> > In other words, we should try to avoid adding dependencies (even if
> > order-only) to workaround the issue, but instead we should get rid of
> > the root issue.
> >
> > Otherwise, after a build, if we rebuild only one of them, wouldn't it
> > find again both? i.e. this is not really a "race condition".
> >
> > From the original message, I see this was happening when building the
> > host libraries, because the targets happen to match, i.e. you are
> > doing a native build on powerpc, right?
> >
> > Perhaps we could put the host `.rmeta`s separately, or something like that.
> 
> Yeah, we can either remove `-L$(objtree)/$(obj)` and specify `--extern
> dep=path-to-dep`, or we can store host libraries to something like
> `$(objtree)/$(obj)/host` and use that instead.
> 
Oh now i understood what Miguel was trying to say. Thanks for the
explanation. 
> The latter should be an easier fix. Also, I can see that we're already having
> `-L$(objtree)/$(obj)/test`.
> 
I'll try this.

Regards,
Mukesh
> Best,
> Gary
> 

