Return-Path: <SRS0=o62n=O6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E16CC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 23:54:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55044204EC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 23:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55044204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43M57r5DwnzDqYL
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 10:54:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43M55b1Y11zDqXZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 10:52:18 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id wBLNq2Mq030885;
 Fri, 21 Dec 2018 17:52:03 -0600
Message-ID: <01fde905930d89ce8a9f0ae47b58625ad3849807.camel@kernel.crashing.org>
Subject: Re: trace_hardirqs_on/off vs. extra stack frames
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Rostedt <rostedt@goodmis.org>
Date: Sat, 22 Dec 2018 10:52:02 +1100
In-Reply-To: <20181220210257.743426dd@vmware.local.home>
References: <e43c141da0ed2c3c6136c09c32afe91698ccce21.camel@kernel.crashing.org>
 <20181220210257.743426dd@vmware.local.home>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc dev list <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <michaele@au1.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2018-12-20 at 21:02 -0500, Steven Rostedt wrote:
> On Fri, 21 Dec 2018 12:11:35 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > Hi Steven !
> > 
> > I'm trying to untangle something, and I need your help :-)
> > 
> > In commit 3cb5f1a3e58c0bd70d47d9907cc5c65192281dee, you added a summy
> > stack frame around the assembly calls to trace_hardirqs_on/off on the
> > ground that when using the latency tracer (irqsoff), you might poke at
> > CALLER_ADDR1 and that could blow up if there's only one frame at hand.
> > 
> > However, I can't see where it would be doing that. lockdep.c only uses
> > CALLER_ADDR0 and irqsoff uses the values passed by it. In fact, that
> > was already the case when the above commit was merged.
> > 
> > I tried on a 32-bit kernel to remove the dummy stack frame with no
> > issue so far .... (though I do get stupid values reported with or
> > without a stack frame, but I think that's normal, looking into it).
> 
> BTW, I only had a 64 bit PPC working, so I would have been testing that.
> 
> > The reason I'm asking is that we have other code path, on return
> > from interrupts for example, at least on 32-bits where we call the
> > tracing without the extra stack frame, and I yet to see it crash.
> 
> Have you tried enabling the irqsoff tracer and running it for a while?
> 
>  echo irqsoff > /sys/kernel/debug/tracing/current_tracer
> 
> The problem is that when we come from user space, and we disable
> interrupts in the entry code, it calls into the irqsoff tracer:
> 
> [ in userspace ]
> <interrupt>
> [ in kernel ]
> bl .trace_hardirqs_off
> 
>   kernel/trace/trace_preemptirq.c:
> 
>    trace_hardirqs_off(CALLER_ADDR_0, CALLER_ADDR1)
> 
> IIRC, without the stack frame, that CALLER_ADDR1 can end up having the
> kernel read garbage.

You're right, I was looking at a too old tree where trace_hardirqs_* is
implemented in kernel/locking/lockdep.c and only uses CALLER_ADDR0.

> 
> -- Steve
> 
> 
> > I wonder if the commit and bug fix above relates to some older code
> > that no longer existed even at the point where the commit was
> merged...

