Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 719AE1A0023
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 22:09:11 +1000 (AEST)
Received: from mail-yk0-f175.google.com (mail-yk0-f175.google.com
 [209.85.160.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DE899140280
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2015 22:09:10 +1000 (AEST)
Received: by ykdt205 with SMTP id t205so6292486ykd.1
 for <linuxppc-dev@ozlabs.org>; Fri, 07 Aug 2015 05:09:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.8.1508070306080.12626@trent.utfs.org>
References: <alpine.DEB.2.20.8.1508070306080.12626@trent.utfs.org>
Date: Fri, 7 Aug 2015 15:09:08 +0300
Message-ID: <CAOJe8K2MN7vzn-OCLCqebp+xsVphNoRL_eGzUB_xuX5PfBLx+g@mail.gmail.com>
Subject: Re: 4.1-rc6: ATA link is slow to respond, please be patient
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Christian Kujau <lists@nerdbynature.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 8/7/15, Christian Kujau <lists@nerdbynature.de> wrote:
> Hi,
>
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
> [   44.922725] ata1.00: cmd c8/00:88:64:c2:12/00:00:00:00:00/e0 tag 0 dma
> 69632 in
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

Interesting, I'll try to reproduce it on my G4.

>
> This happens only once, but systemd thinks there's a hard problem and will
> drop to a recovery shell. I can start sshd and login remotely and then the
> system appears to be running just fine.
>
> This happened in 4.2.0-rc5 so I went back a few versions and found that
> 4.1-rc5 was OK (the error does not show up and the system boots just fine)
> and 4.1-rc6 is not.
>
> Unfortunately a git-bisect between these two versions went completly off
> the charts, I don't know what happened here:
>
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
> It's those computer people in X {city of world}.  They keep stuffing things
> up.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
