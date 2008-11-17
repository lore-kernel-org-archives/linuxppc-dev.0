Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 13ED3DDE1B
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 10:22:21 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mAHNLmRj029012
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 16:21:48 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAHNMHgI039186
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 16:22:17 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAHNMGbZ006683
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 16:22:17 -0700
Date: Mon, 17 Nov 2008 18:22:04 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Large stack usage in fs code (especially for PPC64)
Message-ID: <20081117182204.0940d3a8@zod.rchland.ibm.com>
In-Reply-To: <1226963596.7178.254.camel@pasglop>
References: <alpine.DEB.1.10.0811171508300.8722@gandalf.stny.rr.com>
	<alpine.LFD.2.00.0811171300410.18283@nehalem.linux-foundation.org>
	<1226963596.7178.254.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 18 Nov 2008 10:13:16 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > Well, it's not unacceptable on good CPU's with 4kB blocks (just an 8-entry 
> > array), but as you say:
> > 
> > > On PPC64 I'm told that the page size is 64K, which makes the above equal 
> > > to: 64K / 512 = 128  multiply that by 8 byte words, we have 1024 bytes.
> > 
> > Yeah. Not good. I think 64kB pages are insane. In fact, I think 32kB 
> > pages are insane, and 16kB pages are borderline. I've told people so.
> > 
> > The ppc people run databases, and they don't care about sane people 
> > telling them the big pages suck.
> 
> Hehe :-)
> 
> Guess who is pushing for larger page sizes nowadays ? Embedded
> people :-) In fact, we have patches submited on the list to offer the
> option for ... 256K pages on some 44x embedded CPUs :-)

For clarification, that workload is very precise.  Namely embedded 44x
CPUs used in RAID cards.  I'm not entirely convinced bringing 256K
pages into mainline is a good thing yet anyway.

64K pages, while seemingly insane for embedded boards that typically
have less than 512 MiB of DRAM, help for a bit larger set of
workloads.  As a KVM host is the primary winner at the moment.  But
given the small number of TLB entries on these CPUs, it can pay off
elsewhere as well.

josh
