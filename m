Return-Path: <linuxppc-dev+bounces-21867-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22336CD6E57
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:04:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV5yc43y3z2xmX;
	Tue, 02 Jun 2026 20:04:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780394648;
	cv=none; b=fdcBxuPTf9AeN7tl3ZjuS5/U0p9fNjrwiXc2UDKhCuNgZofCBMvPS8y0CoeS26oUiHrHcRzr11vF0XM2J9KyZsdBCzOgWhSFE9hWZCh95KjF6K3/5hWmvzNW68RH+PMGki+ryNLbpGddNEUBf6GSMU6+sm9kXe7OPn9BbHD1D6osBp9IMLS7gFV2s76jxicmf8XMAAx1lqYs/4bqkqL1IkQGGXy5o+LzL6fgnTlJa4QbThnvJr4fa+L1KnQKvGoN545NTH91LTo+BWeAAMiPcYRK+FZiO1UyhAyS5gQUYekFdTQ8pACxh10D49XX9v9oh+SpOINuLf5rnMZyT1lwKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780394648; c=relaxed/relaxed;
	bh=H0LfyS7uBbZOoMI62xV1G8UaPtPNqlEA8QKL5L+YCUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWZXh9ZdnlNTiNVO0+zdqiRjYuI+yKq6YDQwXvx0TOUwOxKwMpU68fumoYgLJ3OfQ0ZX4GGg1WxtmaHhF1qwEFcsw/mmBQf1pGC3uLwRGJ9KqZ+aC4knpzeGXxZo7J/eqVsHdIACNMoFvDGF2+dBt0yDhZqrHFHsAxuPD0uLanqg6uQ6lXj1sPdLcfhpIMAHgVfawHSmLL50lCcQD37i1wn+nzR/opB5dHh5TYChVFgyoDDqUBSb1r88e8yZSTBxvthfGvIj+fdojtIcdb9e/HbWdmlGz0UsaMlX0ULCG4gRBGMurMAJKH3vB/HyHMXYXr92F66IfUP2BOOhMw+ImA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=VglPKMhO; dkim-atps=neutral; spf=pass (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=VglPKMhO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV5yX6WT3z2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 20:04:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=H0LfyS7uBbZOoMI62xV1G8UaPtPNqlEA8QKL5L+YCUU=; b=VglPKMhOzXIscGEz4J8knswe6Q
	cdjs8+uECbmjwVwx8OSRizqSmdBIoSn6MIuRKqYM0glZ3UD+nJO7vdvDrWksJt5wZshSE7u0R9jLq
	srdHL1T90V+zY33DFYG1i4TcXpCLXXtOWRsNWrWSFpVQM96a2OUs8X9Zc2W3Ce37KXUvBwgtMrvmD
	VJrZP394dF4Pm2/S2dV95PRoUPmcsBJINqM6EK6b75Q5PWWfuCW+VoPoUNltZoRR0vGHp5PjF2qBl
	CyzeI88UaR25kEBPtiXlw1Sm9v40vxZ5EIGWRjsPm+45eoGIll9VbON4VFYmmi7cOV3zScyhFDrv2
	D3DD679A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wULyZ-00000001jQm-1fzp;
	Tue, 02 Jun 2026 10:04:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8E9D53001D0; Tue, 02 Jun 2026 12:03:58 +0200 (CEST)
Date: Tue, 2 Jun 2026 12:03:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Srikar Dronamraju <srikar@linux.ibm.com>
Subject: Re: [linux-next20260529] kernel BUG at kernel/sched/core.c:7512!
Message-ID: <20260602100358.GQ3102624@noisy.programming.kicks-ass.net>
References: <7904105b-9dfa-4efd-a5ef-bc0276ed255d@linux.ibm.com>
 <2f8c3d75-de2c-48bf-bd05-46b816d55c69@linux.ibm.com>
 <20260601095601.GN3102624@noisy.programming.kicks-ass.net>
 <37e69c39-564b-4ca9-bb27-1b99faab540c@linux.ibm.com>
 <20260602081845.GX3126523@noisy.programming.kicks-ass.net>
 <b0211b41-a41b-4367-ae85-86cc2d6dd4b6@linux.ibm.com>
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
In-Reply-To: <b0211b41-a41b-4367-ae85-86cc2d6dd4b6@linux.ibm.com>

On Tue, Jun 02, 2026 at 03:26:11PM +0530, Shrikanth Hegde wrote:

> > I would suggest trying something a little more focussed like so:
> > 
> > diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> > index 806c74e0d5ab..b002c179415c 100644
> > --- a/arch/powerpc/mm/fault.c
> > +++ b/arch/powerpc/mm/fault.c
> > @@ -589,6 +589,7 @@ static __always_inline void __do_page_fault(struct pt_regs *regs)
> >   	err = ___do_page_fault(regs, regs->dar, regs->dsisr);
> >   	if (unlikely(err))
> >   		bad_page_fault(regs, err);
> > +	local_irq_disable();
> >   }
> >   DEFINE_INTERRUPT_HANDLER(do_page_fault)
> > 
> > Since only ___do_page_fault() will enable interrupts, you only need to
> > disable them again on its return path.
> > 
> 
> Seems there are more...
> 
> do_program_check (called by program_check_exception, emulation_assist_interrupt)
> alignment_exception
> SPEFloatingPointException
> facility_unavailable_exception
> 
> 
> Many looks like it can recover only if hit in userspace.
> Hence i though it would make sense to put it under arch_interrupt_exit_prepare
> which is called just before irqentry_exit.

Ah, fair enough.

