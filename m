Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4161CB70A3
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Dec 2010 08:07:59 +1100 (EST)
Subject: Re: Change in PCI behaviour
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gary Thomas <gary@mlbassoc.com>
In-Reply-To: <4CFA38D8.3060209@mlbassoc.com>
References: <4CE69AF6.6090408@mlbassoc.com>
	<1290203218.32570.48.camel@pasglop>	<4CE95E11.1050606@mlbassoc.com>
	<4CEA3F87.9080102@mlbassoc.com>	<1290457615.32570.67.camel@pasglop>
	<4CEBD33D.7020603@mlbassoc.com>  <4CFA38D8.3060209@mlbassoc.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 05 Dec 2010 08:07:49 +1100
Message-ID: <1291496869.2820.8.camel@pasglop>
Mime-Version: 1.0
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-12-04 at 05:49 -0700, Gary Thomas wrote:
> On 11/23/2010 07:44 AM, Gary Thomas wrote:
> > On 11/22/2010 01:26 PM, Benjamin Herrenschmidt wrote:
> >> On Mon, 2010-11-22 at 03:01 -0700, Gary Thomas wrote:
> >>> I have a bit more information on this. I'm pretty sure that the failures
> >>> are only happening in my SCSI (SATA actually) code. My board (8347ea)
> >>> has
> >>> a PCI bus with a SIL SATA controller. This combo works perfectly in
> >>> 2.6.28.
> >>> In 2.6.32, it will run for a while (possibly quite a while), then
> >>> timeout
> >>> trying to do a large block write - typically 256 blocks. Once this
> >>> timeout
> >>> happens, the SIL controller is stuck and accesses to it will eventually
> >>> cause the whole system to hang (as above).
> >>>
> >>> Was there any major change in how PCI or DMA was handled between 2.6.28
> >>> and 2.6.32? Given the ephemeral nature of these failures (multiple runs
> >>> all eventually fail, but never the same twice), my only hope of
> >>> fixing it
> >>> will be to have some ideas what might have changed.
> >>
> >> Maybe the changes you did to the PCI outbound windows are now breaking
> >> DMA ? Make sure the outbound and inbound don't overlap for example and
> >> that all RAM is reachable for inbound.
> >
> > Here's what I did to work around this - in my DTS, I set up my PCI as
> > ranges = <0x02000000 0x0 0xC4000000 0xC4000000 0x0 0x1C000000
> > 0x01000000 0x0 0x00000000 0xB8000000 0x0 0x00100000>;
> > Before, I had it as
> > ranges = <0x02000000 0x0 0xC0000000 0xC0000000 0x0 0x20000000
> > 0x01000000 0x0 0x00000000 0xB8000000 0x0 0x00100000>;
> >
> > I wasn't sure how to reserve the memory (based on your earlier suggestion),
> > so I just narrowed the window. Note that I did not change the PCI hardware
> > registers (maybe the FSL code does?), so the outbound window should still
> > be the whole 512MB.
> >
> > If this isn't viable, perhaps you could explain a bit more how to reserve
> > such a chunk of memory so that the PCI mappings remain the same.
> 
> Any ideas on this?  I'm a bit lost as to how to reserve the memory like
> you suggested and what I've tried so far has met little success.
> 
> Thanks again
> 

Look at pcibios_reserve_legacy_regions() in
arch/powerpc/kernel/pci-common.c, it "reserves" the legacy IO and VGA
regions on host bridges. You can make it reserve whatever your
device is allergic too.

Cheers,
Ben.
