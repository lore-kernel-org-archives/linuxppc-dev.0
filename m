Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp02.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2D82CB7D24
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Apr 2010 13:54:04 +1000 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp02.in.ibm.com (8.14.3/8.13.1) with ESMTP id o3E3s0KS019435
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Apr 2010 09:24:00 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3E3s0Hj3436690
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Apr 2010 09:24:00 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3E3s0uY019272
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Apr 2010 13:54:00 +1000
Date: Wed, 14 Apr 2010 09:23:57 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Patch 1/1] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20100414035357.GA3969@in.ibm.com>
References: <20100308181232.GA3406@in.ibm.com>
	<20100308181448.GA5538@in.ibm.com>
	<1268374776.2209.74.camel@pasglop>
	<20100315062909.GA19279@in.ibm.com>
	<1270627411.2300.71.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1270627411.2300.71.camel@pasglop>
Cc: Michael Neuling <mikey@neuling.org>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>,
	David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Alan Stern <stern@rowland.harvard.edu>,
	Roland McGrath <roland@redhat.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 07, 2010 at 06:03:31PM +1000, Benjamin Herrenschmidt wrote:
> Ok so too many problems with your last patch, I didn't have time to fix
> them all, so it's not going into -next this week.
> 
> Please, test with a variety of defconfigs (iseries, cell, g5 for
> example), and especially with CONFIG_PERF_EVENTS not set. There are
> issues in the generic header for that (though I'm told some people are
> working on a fix).
> 
> Basically, we need something like CONFIG_HW_BREAKPOINTS that is set
> (maybe optionally, maybe not) with CONFIG_PERF_EVENTS and
> CONFIG_HAVE_HW_BREAKPOINT. Then you can use that to properly fix the
> ifdef'ing in include/linux/hw_breakpoints.h, and fix the various other
> cases in powerpc code where you are testing for the wrong thing.
> 
> Cheers,
> Ben.
>

Hi Ben,
	I've sent a new patch (linuxppc-dev message-id ref:
20100414034340.GA6571@in.ibm.com) that builds against the defconfigs for
various architectures pointed out by you (I did see quite a few errors
that aren't induced by the patch).

The source tree is buildable even without CONFIG_PERF_EVENTS, and is
limited to scope using CONFIG_HAVE_HW_BREAKPOINT. At this stage, I
didnot find a need for a seperate CONFIG_HW_BREAKPOINTS though.

Let me know what you think.

Thanks,
K.Prasad
