Return-Path: <rje@valleytech.com>
Received: from theodore.atlantic.net (theodore.atlantic.net [209.208.106.130])
	by ozlabs.org (Postfix) with SMTP id ADD1BDDE1C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Dec 2007 12:57:15 +1100 (EST)
Message-ID: <475DED86.1040409@valleytech.com>
Date: Mon, 10 Dec 2007 20:53:10 -0500
From: "R. Ebersole (VTI - new)" <rje@valleytech.com>
MIME-Version: 1.0
To: David Hawkins <dwh@ovro.caltech.edu>
Subject: Re: mmap + segfaults on MPC8349E
References: <475B5680.30303@valleytech.com> <475B68AE.5000302@ovro.caltech.edu>
In-Reply-To: <475B68AE.5000302@ovro.caltech.edu>
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



David Hawkins wrote:

> Hi,


Hi.

>
> You haven't really provided enough information.


Sorry about that.  I grabbed one of the h/w guys to help out.

>
>> We wrote some simple drivers/modules to mmap() FPGA registers to user 
>> space.
>> At the moment, for testing, we reserve the upper x-MB of RAM, and 
>> mmap() there, instead.
>
>
> 1. The FPGA is located where? The local bus, or the PCI bus?
>    What frequency are you trying to operate at? 


On the local bus frequency is 33.0 MHz. (66.0 PCI_CLK_IN).  See the 
attached .cfg script for memory map.

>
>
> 2. If its on the local bus, do you access it using GPCM or UPM?
>    Have you setup either correctly?
>    Have you confirmed the bus timing with a logic analyzer? 


GPCM.
We have confirmed the timing both in functionality (in the debugger) and 
with a logic analyzer (plus oscope for setup and hold times).
We have stand-alone C-code that runs in CodeWarrior that bangs away at 
the registers of this device and the hardware runs perfectly using the 
.cfg script settings..

>
>
> 3. Have you created a bus functional model of the processor bus
>    that you have then run with your FPGA bus in ModelSim to
>    confirm that your FPGA performs correctly. 

Yes, we have.  Also, checked in h/w (see 2 above)

>
>
> 4. Have you tried burst and non-burst access by either using
>    DMA, or treating the memory area as cacheable or non-cacheable?
>    Have you checked those cases with simulation and then
>    with a scope or logic analyzer?


Always non-burst at this point.

>
> 5. Did you try running stand-alone tests in U-Boot, to go for a
>    more bare-metal debug approach?

I assume the bare-metal debug approach is using a JTAG debugger 
connection and CodeWarrior.  We started there and now are trying to 
access the same device(s) via linux drivers.

>
> No point in debugging software if you have no idea whether the
> hardware behaves. So confirm that you have tested your hardware
> first.
>
> My board design uses the MPC8349EA, I have an Altera Stratix II
> FPGA on the local bus. I use GPCM to access flash on the local
> bus via the FPGA, and UPM to access FPGA registers. I don't
> have boards yet, but I've got a pretty good handle on how the
> interface should work.
>
> Cheers,
> Dave
>
>
>

-- 

Sometimes I feel like a red shirt in the Star Trek episode of life.

--

This message contains confidential information and is intended only for the
individual named.  If you are not the intended recipient you should not
disseminate, distribute or copy this e-mail.  Please notify the sender
immediately by e-mail if you have received this e-mail by mistake and delete
this e-mail from your system.
