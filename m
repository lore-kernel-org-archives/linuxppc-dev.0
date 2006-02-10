Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 908D767B31
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 04:08:05 +1100 (EST)
Message-ID: <43ECC7CE.1010409@ovro.caltech.edu>
Date: Fri, 10 Feb 2006 09:05:18 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: Yosemite/440EP 'issues' as a PCI target
References: <20060209003459.0ED30352564@atlas.denx.de>
	<43EBD715.4020303@ovro.caltech.edu> <200602100847.54363.sr@denx.de>
In-Reply-To: <200602100847.54363.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi Stefan,

Thanks for confirming my analysis.

There's actually an additional issue with the 440EP
for my application. I'll be using it in a 5V PCI
environment (due to the reuse of the existing host
CPUs). Since the 440EP is not 5V tolerant, I figured
I would add clamps or buffers to the board design.

However, given the meager host-to-host communications
features, I think I would be better off putting an
Intel 21555 non-transparent bridge on the board.
That will provide 5V tolerance, and a full set of
messaging unit and I2O facilities. All for $50-80
or so according to the single-piece pricing from
Digikey. I'm not so happy to need to add another
chip, but if the 440EP passes all the other
benchmark requirements, then it seems the least
painful way to proceed.

Has anyone reading this list had good or bad experiences
with the Intel 21555 or perhaps some of the PLX offers,
eg. PCI 6254?

If only the GX/SP had an FPU ...

Of course there is also the option of finding another
PowerPC that matches my requirements;

   - 300-500MHz CPU
   - ~2W
   - FPU
   - three independent buses; SDRAM, PCI, external
   - the external bus will contain multiple FPGAs
     that generate 128kB of data every 10ms or so.
     The data needs to be DMAed to SDRAM, where
     the host CPU can convert it to float, FFT
     it, process, and average the data. Transfers
     to host over PCI occur every 100ms.

     FPGA-to-SDRAM should occur in ~1ms;
        128kB/1ms = 128MB/s

     There will be up to 20 boards in a crate,
     and transfers from all 20 boards need to
     complete in 100ms, so

     FPGA-to-host should occur in ~5ms;
       128kB/5ms = 25MB/s

     So I don't need stunning PCI performance, but
     I do need a reasonable external memory bus
     bandwidth.

     The 440EP 16bit/66MHz 132MB/s would just meet
     my requirement (and I can handle a 50% drop
     in bus bandwidth if benchmarks go that way).
     The PCI performance hits 50MB/s, so its ok.

     I don't want to use a local-bus PCI interface
     with the FPGAs, since then I'd need a PCI core
     in each. I typically pack the FPGAs to 90%
     with processing logic, so can't afford the
     space for a complex host-to-FPGA interface.

I think I've shown you the current boards (that
use a TI DSP);

http://www.ovro.caltech.edu/~dwh/correlator

I had looked at the MPC8245 processor a while back,
but its SDRAM interface is multiplexed with its external
memory bus, so DMA from the external bus to SDRAM
would likely be pretty poor.

Do you have any experience with features of the PowerQUICC
processors? I've tried to avoid a full-up G4/G5 processor
since they typically also require a system controller
chip, and consume a lot more power.

I had also considered using a ColdFire processor, but
went with the PowerPC since I'll be using some Virtex
FPGAs with the PowerPC in a future project.

Anyway, just thought I'd give you an idea of what I'm
trying to figure out.

Cheers,
Dave
