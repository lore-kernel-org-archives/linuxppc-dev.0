Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 57BBC1A023C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 10:49:29 +1000 (AEST)
Date: Thu, 23 Jul 2015 10:49:02 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Michael Schmitz <schmitzmic@gmail.com>
cc: Andreas Schwab <schwab@linux-m68k.org>,
 Linux Kernel Development <linux-kernel@vger.kernel.org>,
 Linux/m68k <linux-m68k@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC v4 03/25] m68k/atari: Move Atari-specific code out of
 drivers/char/nvram.c
In-Reply-To: <CAOmrzkLS0BS8gj1tmkJr3_oXdUp--yOM3esZRodLHs=cAbKupw@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1507231041390.13274@nippy.intranet>
References: <20150712102527.356151908@telegraphics.com.au>
 <20150712102528.107134628@telegraphics.com.au> <87d1zwc4dj.fsf@igel.home>
 <alpine.LNX.2.00.1507141804300.1622@nippy.intranet>
 <55AF1364.3080701@gmail.com>
 <alpine.LNX.2.00.1507221421100.4187@nippy.intranet>
 <20150722143227.GB4738@guido.earth.sol>
 <CAOmrzkLS0BS8gj1tmkJr3_oXdUp--yOM3esZRodLHs=cAbKupw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Thu, 23 Jul 2015, Michael Schmitz wrote:

> Hi Christian,
> 
> if I understand Finn right, he needs the SCSI host ID reported for the 
> Falcon SCSI chip, as found in this kernel log line:

What I'd really like is a regression test for this patch series. The SCSI 
host ID issue is a separate one; these patches won't fix that bug.

> 
> scsi host0: Atari native SCSI, io_port 0x0, n_io_port 0, base 0x0, irq 
> 15, can_queue 8, cmd_per_lun 1, sg_tablesize 0, this_id 7, flags { }, 
> options { REAL_DMA SUPPORT_TAGS }
> 
> (see this_id; output from one of my ARAnyM instances, kernel 3.19rc6). 
> Also, the SCSI host ID reported by cat /proc/drivers/nvram (also 7, in 
> my case)

This seems inconclusive to me. Perhaps if you were to change a setting in 
TOS such that the two values became unequal...

> 
> TOS reports the SCSI host ID during boot (when scannig for bootable 
> disks) IIRC. There may be some control panel to view the NVRAM settings 
> as well (stuff like default video mode was accessible from the CT60 
> control panel so the SCSI host ID might be there as well).

Can that be done in Aranym also?

-- 

> 
> Cheers,
> 
>   Michael
> 
> 
> 
> On Thu, Jul 23, 2015 at 2:32 AM, Christian T. Steigies <cts@debian.org> wrote:
> > On Wed, Jul 22, 2015 at 02:22:21PM +1000, Finn Thain wrote:
> >>
> >> On Wed, 22 Jul 2015, Michael Schmitz wrote:
> >>
> >> > Hi Finn,
> >> >
> >> > I'm afraid I cannot test anything on Atari hardware at present - my
> >> > Falcon ate it's IDE disk partition table with all the fun that entails.
> >>
> >> That doesn't sound good.
> >>
> >> > Haven't even begun to try and recover that yet.
> >> >
> >> > If you send a patch I could build a kernel and send that to Christian
> >> > for testing (if he's got his Falcon up and running - might be a tad warm
> >> > in the attic for that, in fact).
> >>
> >> Anyone with a suitable Atari, i.e. ATARIHW_PRESENT(TT_CLK), who can boot
> >> both TOS and Linux could resolve the question. (Perhaps with an emulator?)
> >
> > The Falcon is not powered on currently but it should still work. What should
> > I test?
> >
> >> Any old kernel binary would do, since atari_scsi should print either
> >> "HOSTID=n" or "this_id n" at startup.
> >>
> >> If n doesn't agree with what TOS says about the host's SCSI ID, then I
> >> think a trivial patch is safe enough. Especially if cat /proc/driver/nvram
> >> produces a "SCSI host ID : m" that does agree with TOS.
> >
> > Christian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
