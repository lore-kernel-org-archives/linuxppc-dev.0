Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id CEC95DDDF9
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 02:02:10 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 4 Sep 2007 18:02:06 +0200
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: "atomic" 64-bit math on 32-bit ppc's?
Message-ID: <20070904160206.GA12698@iram.es>
References: <46DD3CE2.4060301@genesi-usa.com> <20070904113937.GA3994@iram.es>
	<46DD500B.4020207@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46DD500B.4020207@genesi-usa.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 04, 2007 at 01:31:07PM +0100, Matt Sealey wrote:
> 
> Gabriel Paubert wrote:
> >On Tue, Sep 04, 2007 at 12:09:22PM +0100, Matt Sealey wrote:
> >>Hi guys,
> >>
> >>The Solaris PPC code drop included most of these functions for 32-bit ops 
> >>on
> >>32-bit PPC architectures but the 64-bit operations are not present. What I
> >>a not clear on is the operation of lwarx and stwcx. and if they will work 
> >>if
> >>you are doing operations on two words at a time.
> >
> >No. There is a single reservation for a single word.
> 
> This is what I gathered from the programming environments manual at least.

Well, that's because it is fundamentally impossible to 
have more than one, what would the hardware do if the second
update fails after the first has succeeded?

> 
> >the 64 bit operations inside a spinlock on PPC32, and then select the
> >number /location of spinlock(s) based on your needs, from one global
> >per machine to one per 64 bit variable if you find excessive contention.
> 
> Okay that makes sense, but it would have to be a super global big lock,
> I don't think the code is there in ZFS to give every 64-bit variable it's
> own dedicated spinlock (kind of an overhaul) and I'm trying to be fast..

I don't know at all the ZFS code, not any filesystem code for the
matter. But how many spinlocks would you have to take and release 
per actual disk operation?

	Regards,
	Gabriel
