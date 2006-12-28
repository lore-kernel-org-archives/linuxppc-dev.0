Return-Path: <mark@glines.org>
Received: from squawk.glines.org (squawk.glines.org [72.36.206.66])
	by ozlabs.org (Postfix) with ESMTP id 635D3DDEEE
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Dec 2006 10:28:39 +1100 (EST)
Message-ID: <45945324.20805@glines.org>
Date: Thu, 28 Dec 2006 15:28:36 -0800
From: Mark Glines <mark@glines.org>
MIME-Version: 1.0
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: kurobox kernel
References: <fa.ne7N9dqjDz5qS4D/fowPKdPc4ZY@ifi.uio.no>
	<fa.pM17YEcICUlveSt/vbSKGv6sFWk@ifi.uio.no>
	<45902A6F.4000100@glines.org>
	<Pine.LNX.4.60.0612252128530.3424@poirot.grange>
	<459046FE.9030008@glines.org>
	<Pine.LNX.4.60.0612252349040.3424@poirot.grange>
	<45905997.5080403@glines.org>
	<Pine.LNX.4.60.0612260019430.3424@poirot.grange>
	<45918294.3080303@glines.org>
	<Pine.LNX.4.60.0612262159180.3245@poirot.grange>
	<45942EBF.5060201@glines.org>
	<Pine.LNX.4.60.0612282206430.3942@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0612282206430.3942@poirot.grange>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guennadi Liakhovetski wrote:
>> So, uh... is the *.dts file in 2.6.20-rc2 bad, or am I compiling it wrongly?
>> (And is this normally done by hand, or as part of the kernel build process?)
> 
> That's ok. You DO have the "-f" which does produce an output. The error is 
> because the "chosen" is not there, but this is how we need it for U-boot. 
> 
> It's done by hand.
> 
> So, you've done everything right! Congrats:-)

Great.  Any chance you can send me your kernel config?  My IDE support 
isn't working, and I'd like to figure out why.

Usually I get:

NET: Registered protocol family 1
NET: Registered protocol family 17
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
linkstation: disarming the AVR watchdog:
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "hda1" or unknown-block(2,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(2,0)
  <0>Rebooting in 180 seconds..

But once, just once, when booting from a RAM build of uBoot, I got:

hda: WDC WD3200JB-00KFA0, ATA DISK drive
ide0 at 0xc9006e80-0xc9006e87,0xc9006e8a on irq 20
hda: max request size: 64KiB
hda: 625142448 sectors (320072 MB) w/8192KiB Cache, CHS=38913/255/63, 
UDMA(100)
hda: cache flushes supported
  hda:<4>hda: dma_timer_expiry: dma status == 0x20
hda: DMA timeout retry
hda: timeout waiting for DMA
hda: status error: status=0x7f { DriveReady DeviceFault SeekComplete 
DataRequest CorrectedError Index Error }
hda: status error: error=0x7f { DriveStatusError UncorrectableError 
SectorIdNotFound TrackZeroNotFound AddrMarkNotFound }, 
LBAsect=140185576636287, high=8355711, low=8355711, sector=0
ide: failed opcode was: unknown
hda: drive not ready for command
ide0: reset: success
hda: lost interrupt
hda: lost interrupt

Thank goodness for netconsole.  I think it's especially interesting that 
it thinks IDE0 is on irq 20, when the old 2.4.17 kernel says:

hda: WDC WD3200JB-00KFA0, ATA DISK drive
ide0 at 0xbffef8-0xbffeff,0xbffef6 on irq 17

Hmm... 2.6.20, irq20.  2.4.17, irq17.  Interesting coincidence.  Anyway, 
it is either detected wrongly, or specified wrongly.  But your kernel 
config would help me to make sure I'm at least using the right driver. :)

Think it might be something I could work around by fiddling with the 
interrupt-map in that kuroboxHG.dts file?  The IDE IRQ seems wrong, even 
if the network port obviously works (though I bet netconsole transmits 
even if the IRQ is wrong).  Are they allocated dynamically on this 
architecture, or should I expect the IRQ numbers to be the same between 
2.4 and 2.6?

Thanks,

Mark
