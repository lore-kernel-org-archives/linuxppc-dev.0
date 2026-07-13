Return-Path: <linuxppc-dev+bounces-24121-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AD0C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 16:19:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzSMF2KB0z2xJT;
	Tue, 14 Jul 2026 02:19:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783959593;
	cv=none; b=UhIF1Ss5jaSHBUUV38+sWAU3adTvQi/hJJNi3Ya+l5HOJHcvFlqyP8hDxIcrYlSH8uD2VjlBu+K8M2hVS0H48ZY6uBBgtgn3d+kEvBUpV9eW0w0LSelCXPz0e+5C3IQP8tkxUvzqei+0p7lRy8DrzlaOGoiWtPWKlz7FrmKgCl/bRG/k6otbQkPpV/I2z8ONzMnuwqQ6wr5RA1bZjosmK7WC8eJzUp7/pWhYOcmvje/Y1a5LfPrwzWdHCyKDaI7suJiatBpQ3VZaBF9vDSJ4lxUxg6+RygW8Yt3qq2c/T5WmTtwcBsgYlGtcMPJwgFGiJlUN6hJxcObG4aaUM941JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783959593; c=relaxed/relaxed;
	bh=z6q8XmEubJ3GvXQaxRj4lMsNn/x2kGXa807Wdz3pI08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2pgtciKRjPBa+B6DgApaRM6z3x5XGphfpXlkfq4SUqheEp5S4az2CrVzBeja2/z0PpgH1L4qjxF0LygqDpm/+uTBaH/SxyU/F/e0oedFwiNGXvPhiUroiRXjQMcZdnELP1kGlDycVxi88RoD+dkN9LzY6EA5OpiEnokGdzLAjkHrS8PLSEmiPsGMXq/8I16Gv6zdnLAwz441wmK69n8+WLb7icfeheiWcfgOZM9FfItar1FEgBEQdDuHxCb81Cffm+Uef5oAoWCDcvopMOBfrA5mF524GLfec4DZdH2D/+X8CircKU2c/DjAiGDo1M/r7MXqUKNmhowcD5Exrqvkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=neN59K/r; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=fuchsfl@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=neN59K/r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=fuchsfl@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzSMC3GTqz2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 02:19:50 +1000 (AEST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so25210375e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 09:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783959587; x=1784564387; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z6q8XmEubJ3GvXQaxRj4lMsNn/x2kGXa807Wdz3pI08=;
        b=neN59K/roC0fT3fZ7C+MC13gplOwzKZCkAoEsSGXWXwNomzqKl85SPeE1PLxcaXPg7
         2qWAHAaC7CQY8wrFDja9kYr8Sir4DeUSbU4903rxxtM1lo+do/0J77ilIvqBQIlCRQwX
         Pg00+h0mOj/aDxeEcsjZTFnOqTeEaK8ek9hhVHFJ8fhQVJbBDqmRxmbSeZAuX3/iaUNk
         vylhVF5fkdPCoDHqo1M7X+y+OmQPjMuJVmm8tpz5OnFiMv+ZpL+x09KPBFtn6ofSfR7T
         qFRzJBBtknLpXNu9T3BJ4I2wu6pGou422WQtI1IXl2YDxXSC61uxK5HY0KArlvzLIMzA
         d03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783959587; x=1784564387;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z6q8XmEubJ3GvXQaxRj4lMsNn/x2kGXa807Wdz3pI08=;
        b=ss4qYBoD3QiTQSOBlgm6V9TppRscF0XMgWU9UaDa+btJTCWAsGb7yWKPnpyF6FOTYL
         sJoCHUAUNQZXAYOHieM+bw3ZXa+TwIFD3bDrqQJBWCMOauDF6Y4sQ5TcPEzRh3Pu4nYR
         jqZDFO4hreG0zHeG+qkTpQrQHWFUDgMwe+RVxaSOI2U9eallTnMLHenIntgFewCTpFG+
         EeFOuKWakWp2uwocuMi0dbJsIc8oHrPeEX7QbqahAUXKtnsfkfsWErKy+gjxTckld+Lf
         A+uQmMwjXLu2b+PFEbQiI0iXJa5g+W+WFxlY51fOW/wl0w95wtlG9XD8zx59OQPoGXp2
         ciZw==
X-Forwarded-Encrypted: i=1; AHgh+RoTHyhCIyDTy/p/97ay0AZqW+LKhr4M8gDiYUR6jljkzNzFkqidoL3wVIBzIvqu04XpZlaMt+A/WFT7uaY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yym2bWoYaH6xbfEE3YFS/AOhSKUcOUsCPqlWOSDRliIMxQ1BgZJ
	a1LWQU88q4be0XR+wGs6Npmt+ge4RuYk+elRBZ0bbooiheDR5V8vW5Q=
X-Gm-Gg: AfdE7cl97V6dhgAB9YQ/serUF0PschaJtkz3n2cewf6K5I7FXlZ8BJMYkX+jF9//Dat
	Smh1Z4UHmm6gCaW9n6/Zg0pIoWL1SLyfrVGBlubT8jaZ4vFEO4mWYZlh4lNVcqt8N4Xd3mZAa9E
	ESNcFtR6u+v8vHr1oYAtomT3+8qOYsEeU7WGMdH+2pvOPt/KO1nGaPIV9nAPcxbXr13PV9rkQjk
	vfpevLGjm7UXm64Pz82kYChWd4AmREPA14UbvKbOBrixb6NaIcfWsxhdbBd7YW3HbQ2xRBArl0N
	j+ZYQcbhXaHBHn5wtwtlZcfor8BLc+Ee8Bc7W/L9Sg6rshlpDI8qJ5yLJBoSspt+qzTpihd6p5w
	yEX8Ato2hiPpkhMBKDTdzOSCzthalKBf+slIfP6EmC7/SFZkvsBZJnmSPavrSsPKtlW0/nxp6cI
	oL+WhKwGEAnWscGRLAfVLlMYjGqahGOl+NGP+bLeHHlVxYu5F9voCDo/z2B9hd2KKaNA==
X-Received: by 2002:a05:600c:3143:b0:492:5e22:ef18 with SMTP id 5b1f17b1804b1-493f87ebbbemr104433225e9.9.1783959586422;
        Mon, 13 Jul 2026 09:19:46 -0700 (PDT)
Received: from lithos ([2a02:810d:4a94:b300:ceac:ba6c:1653:e93a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a974csm554519f8f.18.2026.07.13.09.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 09:19:46 -0700 (PDT)
Date: Mon, 13 Jul 2026 18:19:40 +0200
From: Florian Fuchs <fuchsfl@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
	Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Paul Mackerras <paulus@ozlabs.org>,
	MOKUNO Masakazu <mokuno@sm.sony.co.jp>, stable@vger.kernel.org,
	Geoff Levand <geoffrey.levand@am.sony.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ps3: Fix map failure path in dma_ioc0_map_pages()
Message-ID: <alUQHB7VvXIABLHb@lithos>
References: <20260711130931.740719-3-thorsten.blum@linux.dev>
 <ik6jukrj.ritesh.list@gmail.com>
 <alT_fEu9AtQT9PxU@linux.dev>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alT_fEu9AtQT9PxU@linux.dev>

On 13 Jul 17:08, Thorsten Blum wrote:
> On Mon, Jul 13, 2026 at 06:08:56PM +0530, Ritesh Harjani wrote:
> > Thorsten Blum <thorsten.blum@linux.dev> writes:
> > 
> > > If lv1_put_iopte() fails in dma_ioc0_map_pages(), the error path
> > > decrements iopage but keeps using the failed mapping's offset. As a
> > > result, it repeatedly tries to invalidate the failed IOPTE slot and
> > > leaves the already installed IOPTEs valid.
> > >
> > > Recompute offset and invalidate the installed IOPTEs instead.
> > >
> > 
> > Nice catch! I wonder how did you catch this?
> > Do you have ps3 console where you somehow ran into this ;)
> > Or was it a manual inspection?
> 
> I do have a PS3 somewhere, but I stumbled upon this while reading and
> trying to understand the code.
> 
> > I wonder whether PS3 consoles are still being used?
> 
> Not sure.
> 

Yes, indeed, they are :-) But I'm not sure on how to test or inject the
error path, so I can't add anything useful to that. Beside, thanks for
keeping an eye on the good stuff.

> > > Fixes: 6bb5cf102541 ("[POWERPC] PS3: System-bus rework")
> > 
> > Looks like this was from 2007.
> > 
> > However, the change looks good to me. So:
> > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> Thanks,
> Thorsten
> 

Regards,
Florian

