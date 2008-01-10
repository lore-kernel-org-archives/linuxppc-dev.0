Return-Path: <linasvepstas@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id 87C2ADE159
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 03:34:52 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so165137anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 08:34:51 -0800 (PST)
Message-ID: <3ae3aa420801100834r6bd2750eqa7c8d29877350463@mail.gmail.com>
Date: Thu, 10 Jan 2008 10:34:51 -0600
From: "Linas Vepstas" <linasvepstas@gmail.com>
To: "Olof Johansson" <olof@lixom.net>
Subject: Re: [PATCH 1/8] pseries: phyp dump: Docmentation
In-Reply-To: <20080110162120.GA4831@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4782B985.2090508@austin.ibm.com> <4782C026.8080302@austin.ibm.com>
	<20080109042911.GT14201@localdomain>
	<3ae3aa420801090731r2e25e42awcae385b448e20b16@mail.gmail.com>
	<20080109184437.GU14201@localdomain>
	<3ae3aa420801091833i6cf32616o2a060579be1f3191@mail.gmail.com>
	<20080110031723.GA22168@lixom.net>
	<3ae3aa420801092012m5e47cbd7lc7a5f91842074af7@mail.gmail.com>
	<20080110162120.GA4831@lixom.net>
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, lkessler@us.ibm.com,
	Nathan Lynch <ntl@pobox.com>, strosake@us.ibm.com
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/01/2008, Olof Johansson <olof@lixom.net> wrote:
> On Wed, Jan 09, 2008 at 10:12:13PM -0600, Linas Vepstas wrote:
> > On 09/01/2008, Olof Johansson <olof@lixom.net> wrote:
> > > On Wed, Jan 09, 2008 at 08:33:53PM -0600, Linas Vepstas wrote:
> > >
> > > > Heh. That's the elbow-grease of this thing.  The easy part is to get
> > > > the core function working. The hard part is to test these various configs,
> > > > and when they don't work, figure out what went wrong. That will take
> > > > perseverence and brains.
> > >
> > > This just sounds like a whole lot of extra work to get a feature that
> > > already exists.
> >
> > Well, no. kexec is horribly ill-behaved with respect to PCI. The
> > kexec kernel starts running with PCI devices in some random
> > state; maybe they're DMA'ing or who knows what. kexec tries
> > real hard to whack a few needed pci devices into submission
> > but it has been hit-n-miss, and the source of 90% of the kexec
> > headaches and debugging effort. Its not pretty.
>
> It surprises me that this hasn't been possible to resolve with less than
> architecting a completely new interface, given that the platform has
> all this fancy support for isolating and resetting adapters. After all,
> the exact same thing has to be done by the hypervisor before rebooting
> the partition.

OK, point taken.

-- The phyp interfaces are there for AIX, which I guess must
   not have kexec-like ability. So this is a case of Linux leveraging
  a feature architected for AIX.

-- There's also this idea, somewhat weak, that the crash may
   have corrupted the ram where the  kexec kernel sits.
   For someone who is used to seeing crashes due to
   null pointer deref's, this seems fairly unlikely. But perhaps
   crashes in production systems are more mind-bending.
   (we did have a case where a USB stick used for boot
   continued to scribble on memory long after it was
   supposed to be quiet and unused. This resulted in
   a very hard to debug crash.)

   A solution to a corrupted
   kexec kernel would be to disable memory access to
   where kexec sits, e.g un-mapping or making r/o the
   pages where it lies. This begs the questions of "who
   unhides the kexec kernel", and "what if this 'who' gets
   corrupted"?

   In short, the kexec kernel does not boot
   exactly the same as a cold boot, and so this opens
   a can of worms about "well, what's different, how do
   we minimize these differences, etc." and I think that
   lead AIX to punt, and say "lets just use one single,
   well-known boot loader/ boot sequence instead of
   inventing a new one", thus leading to the phyp design.

   But that's just my guess.. :-)

--linas
