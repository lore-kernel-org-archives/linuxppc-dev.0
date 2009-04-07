Return-Path: <mikey@neuling.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 52CB1DDFAC
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 18:05:06 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] powerpc: Keep track of emulated instructions 
In-reply-to: <alpine.LRH.2.00.0904070926001.17130@vixen.sonytel.be> 
References: <alpine.LRH.2.00.0904031404450.32353@vixen.sonytel.be>
	<3DA386C6-F26A-4929-8609-FE468DF01572@kernel.crashing.org>
	<alpine.LRH.2.00.0904061430090.11076@vixen.sonytel.be>
	<12794.1239057838@neuling.org>
	<alpine.LRH.2.00.0904070926001.17130@vixen.sonytel.be>
Date: Tue, 07 Apr 2009 18:05:06 +1000
Message-ID: <12579.1239091506@neuling.org>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



In message <alpine.LRH.2.00.0904070926001.17130@vixen.sonytel.be> you wrote:
> On Tue, 7 Apr 2009, Michael Neuling wrote:
> > In message <alpine.LRH.2.00.0904061430090.11076@vixen.sonytel.be> you wrote
:
> > > On Fri, 3 Apr 2009, Kumar Gala wrote:
> > > > On Apr 3, 2009, at 7:08 AM, Geert Uytterhoeven wrote:
> > > > >Finally (after ca. 1.5 years), he're an updated version of my patch to
 k=
> > > eep
> > > > >track of emulated instructions.  In the light of Kumar's `Emulate enou
gh=
> > >  of
> > > > >SPE
> > > > >instructions to make gcc happy' patch, he probably also wants to keep 
tr=
> > > ack
> > > > >of
> > > > >the actual runtime overhead.
> > > > >
> > > > >Changes since last version:
> > > > > - arch/powerpc/kernel/sysfs.c is now compiled on ppc32, so we can pro
vi=
> > > de
> > > > >   counters in sysfs on ppc32, too,
> > > > > - WARN_EMULATED() is a no-op if CONFIG_SYSCTL is disabled,
> > > > > - Add warnings for altivec,
> > > > > - Add warnings for recently introduced emulation of vsx and isel
> > > > >   instructions.
> > > > =
> > > 
> > > > pretty cool.  Do we think counters should be sysfs or debugfs?
> > > 
> > > What do you prefer?
> > > 
> > > On MIPS, unaligned exception handling control is in debugfs.
> > 
> > Would per process counters be too hard?  Stick them in the thread_struct
> > and export them via /proc/<pid>/emulated. 
> 
> But they go away as soon as the process exits, right?

True.  

taskstats would be better then but you'd have to start touching generic
code for that.

Mikey
