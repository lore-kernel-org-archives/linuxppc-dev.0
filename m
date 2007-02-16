Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D2DDEDDD08
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 15:27:53 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l1G4REoO028760
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 23:27:14 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1G4RoDv545084
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 21:27:50 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1G4Ro6o007136
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 21:27:50 -0700
Date: Thu, 15 Feb 2007 22:33:00 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [0/16] Preliminary Ebony (440GP) support for arch/powerpc
Message-ID: <20070216043259.GB1038@crusty.rchland.ibm.com>
References: <20070213060904.GA6214@localhost.localdomain>
	<1171381565.4003.48.camel@zod.rchland.ibm.com>
	<1171469183.4003.96.camel@zod.rchland.ibm.com>
	<20070214231204.GB16279@localhost.localdomain>
	<20070216021956.GA1038@crusty.rchland.ibm.com>
	<20070216025302.GF21654@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070216025302.GF21654@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 16, 2007 at 01:53:02PM +1100, David Gibson wrote:
> On Thu, Feb 15, 2007 at 08:19:56PM -0600, Josh Boyer wrote:
> > On Thu, Feb 15, 2007 at 10:12:04AM +1100, David Gibson wrote:
> > > > I still have this issue, just haven't had a chance to figure out why
> > > > yet.  Likely because the openbios code is leaving garbage somewhere.
> > > 
> > > More likely simply because openbios just puts different things in the
> > > registers on entry, and we're assuming it uses the same method OF
> > > does.  Need to fix the entry path, and get rid of the hardcoded a1 and
> > > a2 junk.
> > 
> > I looked a the openbios code this morning.  For all intents and purposes
> > the values it pases in r3 and r4 to the zImage wrapper really are
> > garbage.  However, you're right in that we need to fix the boot wrapper
> > to not assume all firmwares will follow similar conventions for the entry
> > path.
> 
> Yes.
> 
> > Is there a compat property or something similar that could be defined in
> > the DTS that the wrapper could look at to determine what to expect?
> 
> I think that's getting way too keen on generality.  I'm almost ready
> to send out a patch which alters the entry path to the zImage code to
> let the platform code handle the entry parameters.  Then we can just
> make the Ebony platform_init() ignore the r3 and r4 values.

Oh good.  I thought about that first, but was afraid of the bootwrapper
generality police ;)

> Err... except, are they really both junk?  I thought at least one gave
> an address for the openbios callback to grab the board info structure.

Not from what I can see.  r3 is used to ensure the data cache is flushed
before jumping to the application, and r4 is used to determine if the
openbios debugger flag is set.  If that flag is set, then control returns
to openbios.  If not, then nothing else is loaded there and it just puts
the entry address of the application in srr0 along with the msr into srr1
and does an rfi.  Neither register is set to something other than that
prior to doing the rfi.

There's also this comment at the top:

"Note that (in the first case) the application is getting
 control for the first time since being loaded, so no
 GPR/SPR values need to be restored (though we do enable
 machine check exceptions in the MSR before returning from
 the interrupt)."

I can look again more closely tomorrow though.  Right now I need to sleep
:)

josh
