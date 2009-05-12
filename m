Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-131.bluehost.com (outbound-mail-131.bluehost.com
	[67.222.39.21]) by ozlabs.org (Postfix) with SMTP id 3E2B0DDE0D
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 12:41:37 +1000 (EST)
Message-ID: <4A08E050.9000302@dlasys.net>
Date: Mon, 11 May 2009 22:34:56 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	linuxppc-dev@ozlabs.org
Subject: Re: device trees.
References: <4A0457BC.3040408@dlasys.net>
	<fa686aa40905091351k140c64a0w27eb44908218814@mail.gmail.com>
	<1242007203.7767.28.camel@concordia>
	<fa686aa40905102108l5c964893y2dfb84763e13511@mail.gmail.com>
	<4A07C664.6040609@dlasys.net>
	<fa686aa40905110651r1c18b78bpe8ffebe041726695@mail.gmail.com>
	<20090511155232.A30671B6005D@mail89-va3.bigfish.com>
	<4A08593C.4010503@dlasys.net>
	<20090511183638.F07C01438054@mail184-wa4.bigfish.com>
	<4A08C599.2030100@dlasys.net>
	<20090512005554.EEE1019D009B@mail129-dub.bigfish.com>
In-Reply-To: <20090512005554.EEE1019D009B@mail129-dub.bigfish.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Neuendorffer wrote:
>
>> Many of our systems are LX systems but currently we are not running
>> Linux on them.
>>     
>
> Master SelectMap, I presume?  What FPGA family?
> Does the FPGA have access to the CPLD after boot, other than through the
> configuration pins?
>
>   
One of the skills I have not had time to develop - because Pico has
plenty of qualified firmware/hardware people and not enough OS people,
is fluency with Xilinx tools.

FPGA Families - currently Spartan, virtex 4 and virtex 5.
LX & FX, in all kinds of sizes. So that as an example our E14 (1st
generation cardbus) comes in FX40's and FX60's and LX## .......

I am presuming that is what you mean.

Access to the hardware on the cards can be weird. As our cards are often
hosted, that means the firmware is often setup to allow host and target
access to hardware. In others only the host or only the target does.

What I know is that if I send a few magic values to the CPLD and then
start reading the bit file out of flash, I will trigger the CPLD to
reload the FPGA from the bitfile I selected.





> OK, so that means the boot monitor can open sector 2 of the flash and
> read info, right? (Or wherever else the bitstream is coming from. 
On powerup the CPLD boots from sector 2. IF it is rebooted by the host
or target it can reboot from any flash sector.
In the "normal" setup the target has indirect access to the entire NOR
flash.

>   Can
> the CPLD store one 32 bit int that the new bitstream can come back and
> read later?
>   
Off the top of my head I do nto know, but if you are saying I need to
find someway of preserving a 32bit value through rebooting the FPGA I
can find a way to do it.

>
>
> OK, so the key question seems to be *when* the bitstream is associated
> with the
> device tree.  If at bitstream generation time, you can prepend the .dtb
> to the bitstream.  As long as the dtb doesn't contain the magic
> bitstream start code, you can go back and access it later.
>   
You really mean prepend ? I was presuming that things would work better
if it was appended ?
Regardless, I have the means to know exactly what bit file is currently
loaded, and I can then look it up in the NOR Flash.
I can glue the dtb and the bit file together in anyway that will make
xilinx happy.

If it is prepended the only case I care about is the power up sequence,
because that must start loading the bit file at sector 2.
We do cope with the scenario where the sector 2 bit file is completely
screwed up. The CPLD STARTS trying to load at sector 2, but it will
continue to the end of flash until something actually loads. The dead
card scenario is sector 2 is the start of a valid but non-functional bit
file.
At that point you must load a bit image using JTAG and then write a good
bit file to flash.

Alright lets say I prepend. I am loosely familar with the magic start
code. Does that need to be aligned in anyway ?

And just for the sake of argument lets say I append the dtb. Do I need
some padding between the bitfile and the dtb to keep the
FPGA from loading the dtb as firmware ? Is there a magic stop sequence ?
Is the load terminated by the length of the bits.


> Is this sounding reasonable?
>
>   
I am sure there is something I can work with here.

Thanks.



> Steve
>
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
>
>
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
