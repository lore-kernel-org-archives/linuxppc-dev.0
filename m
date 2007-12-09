Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 79178DDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  9 Dec 2007 15:04:24 +1100 (EST)
Message-ID: <475B68AE.5000302@ovro.caltech.edu>
Date: Sat, 08 Dec 2007 20:01:50 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: "R. Ebersole (VTI - new)" <rje@valleytech.com>
Subject: Re: mmap + segfaults on MPC8349E
References: <475B5680.30303@valleytech.com>
In-Reply-To: <475B5680.30303@valleytech.com>
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

Hi,

You haven't really provided enough information.

> We wrote some simple drivers/modules to mmap() FPGA registers to user space.
> At the moment, for testing, we reserve the upper x-MB of RAM, and mmap() 
> there, instead.

1. The FPGA is located where? The local bus, or the PCI bus?
    What frequency are you trying to operate at?

2. If its on the local bus, do you access it using GPCM or UPM?
    Have you setup either correctly?
    Have you confirmed the bus timing with a logic analyzer?

3. Have you created a bus functional model of the processor bus
    that you have then run with your FPGA bus in ModelSim to
    confirm that your FPGA performs correctly.

4. Have you tried burst and non-burst access by either using
    DMA, or treating the memory area as cacheable or non-cacheable?
    Have you checked those cases with simulation and then
    with a scope or logic analyzer?

5. Did you try running stand-alone tests in U-Boot, to go for a
    more bare-metal debug approach?

No point in debugging software if you have no idea whether the
hardware behaves. So confirm that you have tested your hardware
first.

My board design uses the MPC8349EA, I have an Altera Stratix II
FPGA on the local bus. I use GPCM to access flash on the local
bus via the FPGA, and UPM to access FPGA registers. I don't
have boards yet, but I've got a pretty good handle on how the
interface should work.

Cheers,
Dave
