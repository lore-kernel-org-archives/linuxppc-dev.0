Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id AA6D1DDE02
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Aug 2007 01:02:45 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so95175anc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 08:02:44 -0700 (PDT)
Message-ID: <fa686aa40708300802jdae99c0s8c34b49c02ce45d9@mail.gmail.com>
Date: Thu, 30 Aug 2007 09:02:44 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Robert Woodworth" <rwoodworth@securics.com>
Subject: Re: Xilinx Virtex boot
In-Reply-To: <1188485072.8717.42.camel@PisteOff>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1188430494.8717.26.camel@PisteOff>
	<fa686aa40708291729j3f63a57dl32e5d4df647326b5@mail.gmail.com>
	<1188485072.8717.42.camel@PisteOff>
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

On 8/30/07, Robert Woodworth <rwoodworth@securics.com> wrote:
> On Wed, 2007-08-29 at 18:29 -0600, Grant Likely wrote:
> > On 8/29/07, Robert Woodworth <rwoodworth@securics.com> wrote:
> > > I'm trying to port Linux to a new Virtex Platform.  The kernel will not
> > > uncompress, I get the following on the console:
> > >
> > > loaded at:     00400000 004FB19C
> > > board data at: 004F9120 004F919C
> > > relocated to:  00404054 004040D0
> > > zimage at:     00404E50 004F8409
> > > avail ram:     004FC000 04000000
> > >
> > > Linux/PPC load: console=ttyUL root=/dev/xsa2
> > > Uncompressing Linux...
> > > zlib_inflateInit2 returned 00506530
> > > exit
> > >
> > > Any ideas what causes this error??
> > > Is something mis-configured on my EDK project?
> > >
> >
> > Possibly, do you know that EDK has your ram is configured correctly
> > (ie. have you run a memory test application)?
>
> Yes, I ran the sample memory test application that EDK builds
> automatically.  It ran fine.
>
> The fact that the above prints on the console, tells me that the
> zImage.elf is getting loaded at the correct start location and that its
> partly executing.
>
> What is the return code that I'm seeing??  I have been unable to figure
> that out from the source yet.

IIRC, the return code is the result of the CRC calculation.  If it is
non-zero, then the CRC was incorrect.  That says to me that you've got
either memory or download issues.

I have seen corruption in the past when downloading zImages larger
than about 1.2MB over JTAG.

> > > I have 64MB DDR on the OPB *not* the PLB.
> > > Is that a problem??
> >
> > It shouldn't be the problem, but why are you doing that?
>
> We are building an image-processing application inside the FPGA.  The
> application is very memory intensive.  I have been told that the PPC
> always has priority on the PLB and that if I want to have my FPGA module
> have priority on memory, that I should place the memory and my FPGA
> module on the OPB.  Yes, this can significantly slow down the PPC, but
> in my case the PPC is only used for UI and networking.

<offtopic> You might want to take a look at the MPMC ipcore.  It
allows multiple PLBs to address a single memory region.</offtopic>

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
