Return-Path: <linuxppc-dev+bounces-28930-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8120BCA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 13:40:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hz0rr3jTvz2yTP;
	Tue, 06 Oct 2026 00:40:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791207644;
	cv=none; b=Mqp0lFosNQXw7IJah0s3IlgIWRfyMqlLKzV5v13NPsIkepls/u4wenkG5jwq4ruZjlWEyvoOzKs9uFzIgA+zvm1n8OGzyidpnqscAgeAWMTOA1umf86A/9Aiw2lGZ7xAf8Hn/h7dOwf4+R+EsjfsvgjNT3AqvYGuOmImTgxGGx/HbnsMO9IzW2aC3m24GIYwlYyMi2Hs1cPeTY6DGN8BTS/OSUSGskE042qaQF0K0Eg9ZkqVxGPY3C9kEmq5E+iqPPPfnVUvIzYxa1whc9nNt1eBHuCpdFPQ7hIb3DNCjfFPDxPmXijk9wqbrNmrSxofHTK9+8U5pWpoqaIh0j5uKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791207644; c=relaxed/relaxed;
	bh=xcVeQf+7BvvJau/SIVYSD0F0OxAJkDKz3X1xVomNTxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBi7e70+x8Ay526ZSnB/1blTQMwwxeKSqbU+lbQjdIciEOs9VBr316Oiv79OF7F/NvzTEt9/4Um2y2G/3arA0h2xPuo/3lV8d7brr/+L/OfseisELYfoszyzVMY8facIQp390YYn+VOWi26CuIjJ4r80JJupZAz/idKMTfy6n23PoqftZfYcwqpbxSUvRLuVOIse22wbdAySKlQ4QXr0/YmsgOW2RJYe/UvqEdFLBgiBitLLuAjS2yX/PoOUpfK7S+DYejExj3Zxc/p42uwcmmddM7vF+teiAzYGCdQzmHaPXgzniU9PWbd7xOLq+WY/XraY7esubEmemd3pJ2xYiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YxthRWqB; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=vkoul@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YxthRWqB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=vkoul@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hz0rq0Pywz2yMD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 00:40:42 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AABC060A64;
	Mon,  5 Oct 2026 13:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE9A1F000FF;
	Mon,  5 Oct 2026 13:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207639;
	bh=xcVeQf+7BvvJau/SIVYSD0F0OxAJkDKz3X1xVomNTxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YxthRWqBIZWtFN7pZzyzeejRM1DF0EJzUmIMI1CLOiA42FQ59PtA9aAk4FQPpt4yg
	 01dyIIaItqlAtjjinAWBg9y2RWoME/sQtWu0tHJmx2HlP4dCPwYS+OuLmyeErTx+9Z
	 ecFyYsgt86Ue+R3vIouq5kc/M7CZtHhZBo7aH0hzDfVRXLa9YrMv1e8A9fB0l5hB5U
	 a0U/DUIXHCOPlfKei45Bj445bWSChytE43RsGLyPr0iLVDlYL+vxlK8WD/DtbsOjQs
	 P+kC8Hf+bhh09jb8EcpYEYpIrDIecFld2jbkiK7wYhM1alYphnUtAaP3qw257kimg3
	 N5Jd1xKzWf6MA==
Date: Mon, 5 Oct 2026 15:40:36 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Julian Braha <julianbraha@gmail.com>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	Frank.Li@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	kernel-janitors@vger.kernel.org, linusw@kernel.org, kees@kernel.org,
	colin.i.king@gmail.com, rosenp@gmail.com, joao@joaoff.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v3] powerpc: remove dead 440SP code
Message-ID: <asOo1HzrYIysrWF_@parshuram>
References: <20260901152341.1219343-1-julianbraha@gmail.com>
 <ar7J3nl2pNW-B7AO@lizhi-Precision-Tower-5810>
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
In-Reply-To: <ar7J3nl2pNW-B7AO@lizhi-Precision-Tower-5810>

On 01-10-26, 17:00, Frank Li wrote:
> On Tue, Sep 01, 2026 at 04:23:41PM +0100, Julian Braha wrote:
> > The 440SP config option can never be enabled, making all references to it
> > dead code.
> >
> > The only board using CONFIG_440SP was IBM LUAN, which was commented out by
> > commit f65573314e4e ("[POWERPC] Re-organize Kconfig code for 4xx in
> > arch/powerpc") then removed by commit ff5f483f3091 ("powerpc: 4xx: remove
> > commented out Kconfig entries").
> >
> > Let's remove support for 440SP, since nobody can be using it anyway.
> >
> > This dead code was found by kconfirm, a static analysis tool for Kconfig.

> >
> > Signed-off-by: Julian Braha <julianbraha@gmail.com>
> > ---
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
> > Changes since v2:
> > - cleaned up preprocessor condition
> >
> > Link to v2:
> > https://lore.kernel.org/all/20260901150645.1199097-1-julianbraha@gmail.com/
> >
> > Changes since v1:
> > - added historic details to description
> >
> > Link to v1:
> > https://lore.kernel.org/all/20260816125615.985387-1-julianbraha@gmail.com/
> > ---
> >  arch/powerpc/boot/cuboot-katmai.c   |  2 +-
> >  arch/powerpc/include/asm/async_tx.h |  2 +-
> >  arch/powerpc/include/asm/dcr-regs.h | 10 +++++-----
> >  arch/powerpc/kernel/cpu_specs_44x.h | 12 ------------
> >  arch/powerpc/platforms/44x/Kconfig  |  3 ---
> >  drivers/dma/Kconfig                 |  2 +-
> >  drivers/dma/ppc4xx/adma.c           |  9 ---------
> >  drivers/dma/ppc4xx/adma.h           |  2 +-
> >  drivers/dma/ppc4xx/dma.h            |  9 ---------

Can you send dmaengine only parts please.. or if this goes thru ppc
tree:

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

