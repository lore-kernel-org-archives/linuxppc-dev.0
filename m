Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id D3BA6DE050
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 05:54:55 +1000 (EST)
Sender: miltonm@bga.com
From: "Milton Miller" <miltonm@bga.com>
To: Sebastian Siewior <bigeasy@linutronix.de>,Milton Miller <miltonm@bga.com>
Subject: Re: [RFC] powerpc/boot: compare _start against ei.loadsize instead
	ei.memsize
Date: Thu, 25 Sep 2008 14:54:45 -0500
Message-id: <48dbec85.18e.ff6.1930157473@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Reply-To: miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

----- Original Message Follows -----
From: Sebastian Siewior <bigeasy@linutronix.de>
To: Milton Miller <miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson
<david@gibson.dropbear.id.au>, Grant Likely
<grant.likely@secretlab.ca>
Subject: Re: [RFC] powerpc/boot: compare _start against
ei.loadsize instead ei.memsize
Date: Thu, 25 Sep 2008 12:21:41 +0200
 
> Milton Miller wrote:
>>> My current (working) solution is to move cuImage from 4
>>> MiB to 8 MiB. Something similar has been done for
>>> pSeries in 9b09c6d "powerpc: Change the default link
>>> address for pSeries zImage kernels". Would it be 
>>> appropriate to move initial address to 64 MiB as the
>>> default loading address or do we have here some boards
>> which have only 64 MiB of memory? 
>> I think there are some boards that have even less
>> (8xx?).  Is the link address a wrapper option yet?
> 
> Nope. The wrapper script distinguishes between platforms.
> Default is 4MiB,  pSeries has 64MiB, coff does 5MiB and
> the PS3 has other magic.
 
ok.  I think some of the embedded boards have less than
64M.  On the other hand, my (64 bit with drivers) kernel
static load is over 8M (close to 9).  The needed size
is obviously configuration dependent.
 
There has been talk of reading the size to determine a
suitable address, but its all talk so far.
 
There are two approaches: one is to make it self-
configuring to the minimum for the image you build, 
the other other is to make it a command line option
to the wrapper and then put platform selections in
Kconfig, hidden with embedded for most people.
 
Or we can change the default to say 16M and hope its
enough but not too much for most and not can decode
the platforms for the rest.
 
We could also add a link time check, but we need to
know which platforms, like the OF ones, have a non-
default vmlinux_alloc and don't put the kernel in
place directly (and hence need to skip the check).
 
> >> --- a/arch/powerpc/boot/main.c
> >> +++ b/arch/powerpc/boot/main.c
> >> @@ -56,7 +56,7 @@ static struct addr_range
> prep_kernel(void) >>      if (platform_ops.vmlinux_alloc)
> { >>          addr =
> platform_ops.vmlinux_alloc(ei.memsize); >>      } else {
> >> -        if ((unsigned long)_start < ei.memsize)
> >> +        if ((unsigned long)_start < ei.loadsize)
> > 
> > 
> > I think this needs to be a two part test (add
appropriate
> >     casts):   _start < ei.loadsize || _end < ei.memsize
> > 
> > .. and a comment explaining why.
> 
> okay.
> 
> > We could do better if we kept allocating more memory
> > until we got above it, but the current code has no such
> > provision.  (prpmc2800, or one of those, actually
> > decompresses the header to peek at memsize before
> starting the simple_alloc code).
> 
> I don't thing I can follow. Do you want to move the
> bootwrapper code above  the limit and recall it?
 
I'm saying the code could be changed to do better, but
am not currently requesting any change.
 
milton
