Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D1F31A048F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 11:58:25 +1100 (AEDT)
Message-ID: <1421110704.26626.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Reword the "returning from prom_init" message
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Clarke <pc@us.ibm.com>
Date: Tue, 13 Jan 2015 11:58:24 +1100
In-Reply-To: <54B40403.1000202@us.ibm.com>
References: <1421056096-20043-1-git-send-email-mpe@ellerman.id.au>
 <54B40403.1000202@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-01-12 at 11:27 -0600, Paul Clarke wrote:
> On 01/12/2015 03:48 AM, Michael Ellerman wrote:
> > We get way too many bug reports that say "the kernel is hung in
> > prom_init", which stems from the fact that the last piece of output
> > people see is "returning from prom_init".
> >
> > The kernel is almost never hung in prom_init(), it's just that it's
> > crashed somewhere after prom_init() but prior to the console coming up.
> >
> > The existing message should give a clue to that, ie. "returning from"
> > indicates that prom_init() has finished, but it doesn't seem to work.
> > Let's try something different.
> >
> > This prints:
> >
> >    Calling quiesce...
> >    Shutting down Open Firmware, booting Linux via __start() ...
> >
> > Which hopefully makes it clear that prom_init() is not the problem, and
> > although __start() probably isn't either, it's at least the right place
> > to begin looking.
> 
> I'm very much in favor of anything that increases usability or decreases 
> confusion.
> 
> I worry about confusion caused by any phrase that begins "Shutting 
> down.."  Even if accurate, I wonder if something more positive that 
> indicates that, at least at this point, things are continuing to proceed 
> along would be preferred.

True.

> Perhaps something like "Transferring control from Open Firmware to 
> kernel (via __start) ...".

Yeah, that's not quite accurate either :)

Linux already has control, but up until that point it is running alongside OF
and using its services. After prom_init() returns we take over the machine
entirely.

Maybe "Leaving Open Firmware, booting Linux ..."

Or just "Booting Linux ...".

> (Do we know for certain that what is about to be invoked is "Linux" 
> per-se, or can it be something else that has a "__start"?)

Yes it's Linux.

Although we treat prom_init() as a separate thing, it's just linked into the
regular kernel binary. So the "transfer" here is really just a function call.
But it signifies a switch from code that runs alongside Open Firmware
(prom_init()), to code that doesn't (the rest of the kernel).

We have talked about actually linking them separately but we've never bothered,
it wouldn't buy us much.

cheers
