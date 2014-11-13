Return-Path: <benh@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C006B1A00AF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Nov 2014 07:35:53 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8F6F2140079
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2014 07:35:53 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Fri, 14 Nov 2014 06:35:50 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8B9282CE8057
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2014 07:35:49 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sADKbiXh39387322
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2014 07:37:45 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sADKZlVF005321
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2014 07:35:48 +1100
Message-ID: <1415910941.666.15.camel@au1.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Support OPAL requested heartbeat
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Paul Clarke <pc@us.ibm.com>
Date: Fri, 14 Nov 2014 07:35:41 +1100
In-Reply-To: <5464E388.6060507@us.ibm.com>
References: <1415772194.5124.37.camel@kernel.crashing.org>
 <5464E388.6060507@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jeremy Kerr <jeremy.kerr@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-11-13 at 10:59 -0600, Paul Clarke wrote:
> On 11/12/2014 12:03 AM, Benjamin Herrenschmidt wrote:
> > If OPAL requests it, call it back via opal_poll_events() at a
> > regular interval. Some versions of OPAL on some machines require
> > this to operate some internal timeouts properly.
> 
> I don't see any reason why not, but wanted to ask to make sure: this 
> daemon can be bound to a core, correct?  At least manually by taskset or 
> similar?

I think so... it's a kernel thread, but I haven't tried. It should be
akin to the existing khvcd.

> It sounds a lot like the RTAS thread, which I was happy to see go away 
> when running directly on OPAL, and don't want something else to take its 
> place.  It was not bindable, but ran periodically on EVERY core, err 
> hardware thread.
> 
> (Just looking to avoid latency blips.)

Right, I know where you come from. But you'll get those blips whether I
use a thread or an interrupt. Basically, I'm trying to get the HW guys
to give me a modified SLW engine image that I can use to request time by
setting up a delayed interrupt.

I'm trying to reduce the work done in there, and in fact I'm hoping to
only schedule my internal timers that rely on this (or the SLW
interrupt) for cases where we have a pending i2c or IPMI command, and
possibly only on machines without a functional external interrupt (so
lab bringup) or when accessing Centaur i2c (very very rarely).

But I do need that source of time...

Cheers,
Ben.
