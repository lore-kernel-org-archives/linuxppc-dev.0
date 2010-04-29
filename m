Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 182B2B7D19
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Apr 2010 12:11:03 +1000 (EST)
Subject: Re: PowerPC ftrace function trace optimisation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: rostedt@goodmis.org
In-Reply-To: <1272506103.9739.112.camel@gandalf.stny.rr.com>
References: <20100429005117.GA4622@kryten>
	<1272506103.9739.112.camel@gandalf.stny.rr.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 29 Apr 2010 12:10:38 +1000
Message-ID: <1272507038.24542.154.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Anton Blanchard <anton@samba.org>, imunsie@au1.ibm.com, amodra@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-04-28 at 21:55 -0400, Steven Rostedt wrote:
> On Thu, 2010-04-29 at 10:51 +1000, Anton Blanchard wrote:
> > Hi,
> 
> > # gcc -pg -mprofile-kernel
> > 
> > 0000000000000000 <.foo>:
> >    0:   7c 08 02 a6     mflr    r0
> >    4:   f8 01 00 10     std     r0,16(r1)
> >    8:   48 00 00 01     bl      8 <.foo+0x8>	<--- call to mcount
> > 
> >    c:   7c 08 02 a6     mflr    r0
> 
> Why the extra mflr? Can't we just make it a requirement that mcount
> returns with r0 back to what it was?

Well, we can't just change that now, it's been in for long enough.

We might be able to get a new option later on that makes it more
efficient tho (for example removing the std), but let's see what we can
do with what we have.

The extra mflr makes sense if you consider that the option just
pre-pends a pre-canned set of instructions and doesn't actually touch
anything to the prolog generation. It might be possible to do a hack to
make the prolog aware that LR is already in r0 but let's look at that
after we've verified we can get the existing stuff working :-)

Another idea Alan had is that if we could have a list of call sites,
instead of NOP'ing we could instead change the branches of all call
sites to skip the 3 instruction mcount prolog :-)

Now, we do store the relocs with the kernel image when using
CONFIG_RELOCATABLE, though we might want to 'sort' them a bit to easily
find callers from call sites, but it's something to also consider.

Cheers,
Ben.

> -- Steve
> 
> >   10:   f8 01 00 10     std     r0,16(r1)
> >   14:   f8 21 ff d1     stdu    r1,-48(r1)
> >   18:   e9 22 00 00     ld      r9,0(r2)
> >   1c:   e8 69 00 02     lwa     r3,0(r9)
> >   20:   38 21 00 30     addi    r1,r1,48
> >   24:   e8 01 00 10     ld      r0,16(r1)
> >   28:   7c 08 03 a6     mtlr    r0
> >   2c:   4e 80 00 20     blr
> > 
> > 
> > This mean we could support ftrace function trace with very little overhead.
> > 
> > In fact if we are careful when switching to the new mcount ABI and don't
> > rely on the store of r0, we could probably optimise this even further in a
> > future gcc and remove the store completely. mcount would be 2 instructions:
> > 
> >    mflr    r0              
> >    bl      8 <.foo+0x8>
> > 
> > Anton
> 
