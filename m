Return-Path: <chmeeedalf@gmail.com>
Received: from mail-qa0-f50.google.com (mail-qa0-f50.google.com
 [209.85.216.50])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 59AF3B6EEB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jun 2012 13:31:34 +1000 (EST)
Received: by qafl39 with SMTP id l39so2308944qaf.16
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jun 2012 20:31:31 -0700 (PDT)
Date: Sun, 10 Jun 2012 23:31:27 -0400
From: Justin Hibbits <chmeeedalf@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PowerMac PMU programming
Message-ID: <20120610233127.1284fec0@narn.knownspace>
In-Reply-To: <1339369393.24838.101.camel@pasglop>
References: <20120610092932.38857c77@narn.knownspace>
 <1339369393.24838.101.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 11 Jun 2012 09:03:13 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Sun, 2012-06-10 at 09:29 -0400, Justin Hibbits wrote:
> > Hello,
> > 
> > I'm working on various PMU bits for FreeBSD (I know, not related to
> > Linux), but running into some problems, which the Linux crowd may be
> > able to help with, as it's already solved for Linux.  I've managed
> > to get it to sleep for performing the sleep operation and for the
> > CPU speed switch on MPC7455-based machines, but it goes catatonic,
> > not waking up.  I've installed the reset vector pointer at 0x0080,
> > which both OS X and Linux do, and flush the caches, but no luck.
> > During development of the Linux driver was this ever encountered?
> > Any assistance would be greatly appreciated, I've been banging my
> > head against this off and on for about 8 months now.
> > 
> > Thanks for any assistance.  I'm not subscribed to the list, so
> > please keep my address in replies.
> 
> Yes it was :-) pretty much any bug even minor during that process will
> cause just that :-)
> 
> One thing paulus did that helped us a lot initially was write a little
> synchronous version of the PMU send command and use it to blink the
> PMU LED very early on when resuming from sleep, which allows us to
> debug a bit.
> 
> It takes quite a bit of work (see the code in radeonfb) to get the
> graphics back, so most of the time you come back with nothing on
> screen.
> 
> If your machine is not a laptop, there are other possible
> considerations, such as the need to restore the PCI-PCI bridge that
> might be above the macio chip very early on, before you try to restore
> macio itself (we don't do that in Linux at this stage).
> 
> Cheers,
> Ben.
>  
> 

Thanks Ben,

I'll settle on just getting the CPU speed change working, losing 333MHz
on my TiBook is a few too many MHz for the poor thing to lose :)  I do
have a desktop, but that's my development platform, so needs to be
at least somewhat stable, so my TiBook is my guinea pig.

I've googled everything I can think of, but do you know of any
definitive PMU documentation?  Or can you give me any hints on what's
needed just for that simple operation?

I noticed that you wind down the ADB queue before killing the PMU.  Is
this necessary?  I only disable the interrupt by writing 0x10 to the
IER, but our interrupt model for the PMU is different from the Linux
one.  Is it also necessary to disable the interrupt input, even though
the register write should be disabling the PMU's asserting of the
line?  There doesn't seem to be much more different than that, and
setting the openpic priority, Linux sets it to 0x0f but I didn't see
anything in OS X doing that (might that be a problem, too?)

I would love to get my TiBook using the full 1GHz.

Thanks,

Justin
