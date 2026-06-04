Return-Path: <linuxppc-dev+bounces-22059-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827E4CD6E77
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 17:52:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWXGB014dz2yT0;
	Fri, 05 Jun 2026 03:52:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780595553;
	cv=none; b=as1rx2vSr1nvgTVrIE5u89yPay7IXfyF+qEldYlI1SAeVi5tz4HOoNetqKwZEqb6tJb/qZuZLerm8URNpaNRB+i60kSyuwC24F8C4xMj6kmyNmAg8a/grcU9uoJHzpcYB1Hbs3BWTv1dLPm0lpdXRkkwbLbxV6v4fp9w+jcmSVioeppi016B0Ow/b9hJWV+aBp8aa+lgxPcQv7iY+yu0otmHMAgbDCvMyD7MN1fjqyuPehHBojSb3vOJhi95al4eTR6uX7zMMFpW1623XjQbS37kC4AuKykC7yH/X/d4/8oQUPWlzD79v/fwfmH9smW6zgu1k/JKrOs/KnvIhnqesg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780595553; c=relaxed/relaxed;
	bh=yIZOM8XiZdWa6LxoAZleH3/zdJaMoVyrCZRUBkfkt5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2aAprvnvQsLk8MpFeccZyR2pdo/IsWY7GScnb6TOjw5dfAmOXbD53wmGT1mGO2s/wsZAK4U5AoxNs8r4leQZju/ygc8Vy2hZeaoJcyBjAy9t0Ve8TymrgIrAAG6P/+oNcZf6prwV4FAAsrw/VQ2xVdHJ9kdq+es2keBHwZ487EkfAI8oodiQG+IBBo0a/BgHAf4dx6GMNJ7fipf1xJuxztAG5xrYYBuiiB0ZqEomGXWbqjjT/k/E7Hi21aADWFc39ovTdnrvrRHIqY1mBIQuYrwCBzQ8JNZXyPGgZ8J/Re1JXjPQpvJaMnfQ/kCMNlERK6NUQgQQEsbuULjfL8HeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqOJToLo; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srs0=mimd=ea=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqOJToLo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srs0=mimd=ea=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWXG92nshz2yRn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 03:52:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EA64843E8C;
	Thu,  4 Jun 2026 17:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49C91F00893;
	Thu,  4 Jun 2026 17:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780595550;
	bh=yIZOM8XiZdWa6LxoAZleH3/zdJaMoVyrCZRUBkfkt5A=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=LqOJToLoWaofqbF+1W7AswL0DOqwOhFcamVp4Z4e0y5H5/tIo3iuARaG5PUSx/F1Z
	 gLGX3JYNSayOyQ5k0BR3oY00sYYt4SWnuz+JlvTI51hAsLjx1tjv+bn5ssm/Nc+RhM
	 PICZvFDrVRfD2Ml4glSYhHS2WWJP3tiVJczCGV6v7itIPM20g7rAcFGGw0CXPn+ll+
	 DQeaOfdMsv06WTl3a3Nc/h13j2Ovdb3flfpwur01+O0c/+X2PpAafxNsUoY4nqIqbp
	 iwAjPAMS3free9/DMotuJJDeokyWm8MjCyXWlJopCIQQLr/CCsjBCOs+UREajBuP6B
	 A5Ff1MV5hR3og==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6BDD0CE0555; Thu,  4 Jun 2026 10:52:30 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:52:30 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Mark Tomlinson <Mark.Tomlinson@alliedtelesis.co.nz>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"yury.norov@gmail.com" <yury.norov@gmail.com>,
	"romank@linux.microsoft.com" <romank@linux.microsoft.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"riel@surriel.com" <riel@surriel.com>,
	"joelagnelf@nvidia.com" <joelagnelf@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] smp: prevent soft lockup in smp_call_function_many_cond
Message-ID: <1b8351a3-dc3e-4e5c-8935-43ad574492dd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260527031618.2940365-1-mark.tomlinson@alliedtelesis.co.nz>
 <7a0693c5-8bda-403e-9889-f65f7f768356@alliedtelesis.co.nz>
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
In-Reply-To: <7a0693c5-8bda-403e-9889-f65f7f768356@alliedtelesis.co.nz>

On Tue, Jun 02, 2026 at 09:18:39PM +0000, Chris Packham wrote:
> (adding others suggested by get_maintainer.pl)
> 
> On 27/05/2026 15:16, Mark Tomlinson wrote:
> > Using the PowerPC P2040 (e500mc) CPU, soft lockups can occasionally be
> > seen in smp_call_function_many_cond(). The conclusion is that this CPU
> > does not process the doorbell interrupt while in a data-storage (MMU)
> > exception. If more than one CPU in a multi core environment is calling
> > this function at the same time, it is possible for a deadlock to occur.
> >
> > The fix for this is to call flush_smp_call_function_queue() before
> > waiting for responses from other CPUs. If there is something in the
> > queue, this is a good time to process it before busy-waiting on other
> > CPUs. On other architectures this call will quickly do nothing, as the
> > queue will be empty.

OK, I will bite...

How do we know that another entry will not get added by some other CPU
just before this new call to flush_smp_call_function_queue()?

							Thanx, Paul

> > Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
> > ---
> >   kernel/smp.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/smp.c b/kernel/smp.c
> > index a0bb56bd8dda..3c4467654ab0 100644
> > --- a/kernel/smp.c
> > +++ b/kernel/smp.c
> > @@ -884,6 +884,8 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
> >   		local_irq_restore(flags);
> >   	}
> >   
> > +	flush_smp_call_function_queue();
> > +
> >   	if (run_remote && wait) {
> >   		for_each_cpu(cpu, cfd->cpumask) {
> >   			call_single_data_t *csd;

