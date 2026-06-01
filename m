Return-Path: <linuxppc-dev+bounces-21807-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FE1CD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2026 09:56:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTTqv3cP7z2ytV;
	Mon, 01 Jun 2026 19:56:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1:d65d:64ff:fe57:4e05"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780307771;
	cv=none; b=LdgtWtydrV+FVNtLQcB+dXUYom7ciBClntO5JPOoZYgn9DYFUcGR+mrWoCZ/NeF6Zl56Uq4WnFCJ1wC//Hzi8ooEEI/Vau/5penhhxw6dM5hFpei+E8xOqR922U3JI296JpbQUaPeq1MjdU8Vc96BTEzsp+o/LejnlPR/H/BRRjfhz8ugjPtdna+KFIPbcFGTdhi5rODHea9OQWFRx8QwCRuvU2TOdmLidFPguFRFr1nBKF0DE4PYiWXQvzANX2xe4it/iLFLlBntd+ktJjVXuNvxZ7iZ/orYmF6eUQWaNrHrexWMEO6dj5bRnnPuHP/0W2xpfl1WB4/XFxvWWoBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780307771; c=relaxed/relaxed;
	bh=ZlMyHu3BbzXPD3yTxJTwuhSJEfIF8/AcS4QYjKsn584=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjLXOlBBOWx/OVMpI6fk0pEE9C9OTwQ6TZ5UOOj1LhLi3eQyBpcnb0RYblhHbwR1lp/2bfcfOffvxq7TsKD4Q/cnXAo12y7Dou8RKu7ffehvsxBF5tSqh+okAIiMqPNXfb2WInrkbZiy/bzkfMq8w7rroOfViroF4Qt9elXWN36V0GCb33DFT3vr+F6CJhRP9Nl/n1R97GrV3xUyAZ04WLGpbQN0g9rqfjqA+C/4RCEouBCKnWAvjdE5IW93HEnQ0eMTrUWBD3YGex2epyHulntqVckp+Hlub6RR+WBlzTnEp/G7O8bSLl918gYUNRXXoLb2c4ZKlEqRKkkwHhsxxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=ktCYaxpp; dkim-atps=neutral; spf=pass (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=ktCYaxpp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTTqn5WLCz2ysb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 19:56:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZlMyHu3BbzXPD3yTxJTwuhSJEfIF8/AcS4QYjKsn584=; b=ktCYaxpp58lXdrmnQHlo87Gp1s
	N6MDXY6IPPxiXE/N3ALh3O6z6PiGKjQd4H7MS/rQU8v45IydRc4GeOVmaZgFnNMVjuNjnAkvpvily
	IzAW2iLH4R0uw6fqE7OrKnDGnGYYgfyz6swYKwyuJmtdCp02MkrFYN6H2eMhc71DhBRrAzwdoaruh
	G4Qt8BSpsq82ackG+GgoW+H4sZ4yYQo48X/K+55QQ/HkAdgz6ADpFSqElT9HotGFXzTl5hQNKpCY+
	8PEkRw48oT6ep+1xcpYZNwm7etR0JNyjcp3wnZdpLRb2kV1B4IDvSdWVXc5GUmCNaI95rTo9ELCvS
	AuuQqy9w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTzNJ-00000006JL6-3shb;
	Mon, 01 Jun 2026 09:56:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9C602300454; Mon, 01 Jun 2026 11:56:01 +0200 (CEST)
Date: Mon, 1 Jun 2026 11:56:01 +0200
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
Message-ID: <20260601095601.GN3102624@noisy.programming.kicks-ass.net>
References: <7904105b-9dfa-4efd-a5ef-bc0276ed255d@linux.ibm.com>
 <2f8c3d75-de2c-48bf-bd05-46b816d55c69@linux.ibm.com>
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
In-Reply-To: <2f8c3d75-de2c-48bf-bd05-46b816d55c69@linux.ibm.com>

On Mon, Jun 01, 2026 at 02:46:24PM +0530, Shrikanth Hegde wrote:

> Ritesh, Mukesh, Is below possible scenario?
> 
> do_page_fault seems to enable irq's in the interrupt handler?
> is that expected? if so, one might see
> 
> -- do_page_fault (enter kernel mode)
>    -- enables interrupts
>    -- gets interrupt - Sets need_resched.
>       -- irqentry_exit - Sees it is kernel mode. Just checks preempt count
> 			 and calls preempt_schedule_irq, which catches both
> 			 preempt_count and !irqs_disabled. Hence the panic?
> 
> Should do_page_fault do preempt_disable when it enables the interrupts?

No, it is expected for page-fault to be able to schedule. Specifically,
it must be able to sleep to support loading pages from disk.

Please check the value of preempt_count() (does it perchance have
HARDIRQ_OFFSET?). Also, if the fault handler does enable IRQs, it must
also disable them again once done.

Notably, I see ___do_page_fault() do interrupt_cond_loadl_irq_enable(),
but I'm not seeing a local_irq_disable() to match!

