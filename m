Return-Path: <rwoodworth@securics.com>
Received: from securics.com (dns2.securics.com [128.198.58.14])
	by ozlabs.org (Postfix) with ESMTP id D4396DDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Aug 2007 00:50:44 +1000 (EST)
Subject: Re: Xilinx Virtex boot
From: Robert Woodworth <rwoodworth@securics.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40708291729j3f63a57dl32e5d4df647326b5@mail.gmail.com>
References: <1188430494.8717.26.camel@PisteOff>
	<fa686aa40708291729j3f63a57dl32e5d4df647326b5@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 30 Aug 2007 08:50:36 -0600
Message-Id: <1188485436.8717.47.camel@PisteOff>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2007-08-29 at 18:29 -0600, Grant Likely wrote:
> On 8/29/07, Robert Woodworth <rwoodworth@securics.com> wrote:
> > I'm trying to port Linux to a new Virtex Platform.  The kernel will not
> > uncompress, I get the following on the console:
> >
> > loaded at:     00400000 004FB19C
> > board data at: 004F9120 004F919C
> > relocated to:  00404054 004040D0
> > zimage at:     00404E50 004F8409
> > avail ram:     004FC000 04000000
> >
> > Linux/PPC load: console=ttyUL root=/dev/xsa2
> > Uncompressing Linux...
> > zlib_inflateInit2 returned 00506530
> > exit
> >
> > Any ideas what causes this error??
> > Is something mis-configured on my EDK project?
> >
> 
> Possibly, do you know that EDK has your ram is configured correctly
> (ie. have you run a memory test application)?
>
>
> >
> > I have 64MB DDR on the OPB *not* the PLB.
> > Is that a problem??
> 
> It shouldn't be the problem, but why are you doing that?

I did notice in my configuration, that when the memory is on the PLB it
has an interrupt flag and when it's on the OPB it doesn't.  What is the
interrupt for?  DMA's?

Could Linux be doing a DMA in the uncompression where the lack of an
interrupt causes and error?
