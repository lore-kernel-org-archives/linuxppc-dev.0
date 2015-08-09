Return-Path: <lists@nerdbynature.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 772141A1799
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Aug 2015 14:17:13 +1000 (AEST)
Received: from trent.utfs.org (trent.utfs.org [IPv6:2a03:3680:0:3::67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 051AD140297
 for <linuxppc-dev@ozlabs.org>; Sun,  9 Aug 2015 14:17:11 +1000 (AEST)
Date: Sat, 8 Aug 2015 21:17:02 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: linuxppc-dev@ozlabs.org
cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: 4.1-rc6: ATA link is slow to respond, please be patient
In-Reply-To: <alpine.DEB.2.20.8.1508070306080.12626@trent.utfs.org>
Message-ID: <alpine.DEB.2.20.8.1508082049490.12626@trent.utfs.org>
References: <alpine.DEB.2.20.8.1508070306080.12626@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Adding linux-ide@vger.kernel.org]

On Fri, 7 Aug 2015, Christian Kujau wrote:
> this PowerBook G4 was running 3.16 for a while but now I wanted to upgrade 
> to latest mainline. However, during bootup the following happens:
> 
> ===============================
> [    2.237102] ata1: PATA max UDMA/100 irq 39
> [    2.401708] ata1.00: ATA-8: SAMSUNG HM061GC, LR100-10, max UDMA/100
> [    2.401764] ata1.00: 117231408 sectors, multi 16: LBA48 
> [    2.417633] ata1.00: configured for UDMA/100
> [   44.918102] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> [   44.920452] ata1.00: failed command: READ DMA
> [   44.922725] ata1.00: cmd c8/00:88:64:c2:12/00:00:00:00:00/e0 tag 0 dma 69632 in
> [   44.927257] ata1.00: status: { DRDY }
> [   49.971784] ata1.00: qc timeout (cmd 0xec)
> [   49.976529] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [   49.978908] ata1.00: revalidation failed (errno=-5)
> [   55.019662] ata1: link is slow to respond, please be patient (ready=0)
> [   60.007677] ata1: device not ready (errno=-16), forcing hardreset
> [   60.012670] ata1: soft resetting link
> [   60.193638] ata1.00: configured for UDMA/100
> [   60.196158] ata1.00: device reported invalid CHS sector 0
> [   60.198610] ata1: EH complete
> ===============================
> 
> This happens only once, but systemd thinks there's a hard problem and will 
> drop to a recovery shell. I can start sshd and login remotely and then the 
> system appears to be running just fine.
> 
> This happened in 4.2.0-rc5 so I went back a few versions and found that
> 4.1-rc5 was OK (the error does not show up and the system boots just fine)
> and 4.1-rc6 is not.
> 

After more digging around I noticed that the same error (with 
changed wording) happens with a Debian 3.16.0-4-powerpc kernel - so it
doesn't appear to be a recent regression as I suspected at first:

==================================
[   46.907147] ata1: drained 572 bytes to clear DRQ
[   46.907166] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[   46.908419] ata1.00: failed command: READ DMA
[   46.909058] ata1.00: cmd c8/00:80:9c:f9:60/00:00:00:00:00/e0 tag 0 dma 65536 in
         res 40/00:fe:00:00:00/00:00:00:00:00/40 Emask 0x20 (host bus error)
[   46.910303] ata1.00: status: { DRDY }
[   46.970579] ata1.00: configured for UDMA/100
[   46.971853] ata1.00: device reported invalid CHS sector 0
[   46.972524] ata1: EH complete
==================================

Also, the error cannot repduced as reliably as I thought: sometimes, the 
machine just boots w/o a hitch - and that might be the reasons why my 
bisect attempts failed and incorrectly blamed totally unrelated commits: 
after each "git bisect {good,bad}" (+compiling) I rebooted but there was a 
chance that the system came up just fine / showed the same ATA error and 
thus falsified the git-bisect results.

I noticed that with this Debian 3.16 kernel, it happens less often when I 
use the "irqpoll" option. But with 4.2-rc5 this doesn't seem to help much, 
the system still hangs during boot but continues after the "EH complete " 
message. And it doesn't appear afterwards, I can read from my root disk 
just fine and a long SMART check also comes back fine.

Because the error only appears to happen on the very first access after a 
reboot, I tried to boot with rootdelay=30 - but of course then it just 
waits "before" accessing the root disk. I'd need a magic option to wait a 
few seconds "after" the first disk access, so that the boot framework 
("systemd") won't be thrown off when /dev/sda isn't responding as fast as 
expected.

What _does_ seem to help a bit was to disable the the swap device, which 
is configured as an encrypted dm-device here - and systemd was almost 
always stumbling over this particular service during bootup. Because of 
the ATA timeout, the dm-device could not be setup correctly and systemd 
would bail out and drop me into a recovery shell. Without the swap device, 
systemd would skip setting up swap and boot just fine (most of the time) 
and I can setup swap once the system has been booted. So...there's that.

It's still a mystery to me why /dev/sda is only behaving weird on its 
first access.

I've cc'ed linux-ide, maybe somebody has an idea on that?

dmesg & .config:  http://nerdbynature.de/bits/v4.1-rc6/

Thanks,
Christian.


> Unfortunately a git-bisect between these two versions went completly off 
> the charts, I don't know what happened here:
> ==================================
> first bad commit:
> 
> 0fa372b6c95013af1334b3d5c9b5f03a70ecedab is the first bad commit
> commit 0fa372b6c95013af1334b3d5c9b5f03a70ecedab
> Author: Takashi Iwai <tiwai@suse.de>
> Date:   Wed May 27 16:17:19 2015 +0200
> 
>     ALSA: hda - Fix noise on AMD radeon 290x controller
> ==================================
> 
> I don't have this driver (or ALSA) even selected. I can reproduce this 
> error pretty reliably and I'd like to attempt another git-bisect
> run when I'm more awake. But maybe somebody recognizes this error and
> has a hint where this could come from?
> 
> dmesg & .config:  http://nerdbynature.de/bits/v4.1-rc6/
> 
> Thanks,
> Christian.
> -- 
> BOFH excuse #225:
> 
> It's those computer people in X {city of world}.  They keep stuffing things up.
> 

-- 
BOFH excuse #263:

It's stuck in the Web.
