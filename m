Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id F1FB11A1A2C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 14:22:46 +1000 (AEST)
Date: Wed, 22 Jul 2015 14:22:21 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Michael Schmitz <schmitzmic@gmail.com>
cc: Andreas Schwab <schwab@linux-m68k.org>, linux-kernel@vger.kernel.org,
 linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC v4 03/25] m68k/atari: Move Atari-specific code out of
 drivers/char/nvram.c
In-Reply-To: <55AF1364.3080701@gmail.com>
Message-ID: <alpine.LNX.2.00.1507221421100.4187@nippy.intranet>
References: <20150712102527.356151908@telegraphics.com.au>
 <20150712102528.107134628@telegraphics.com.au> <87d1zwc4dj.fsf@igel.home>
 <alpine.LNX.2.00.1507141804300.1622@nippy.intranet>
 <55AF1364.3080701@gmail.com>
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


On Wed, 22 Jul 2015, Michael Schmitz wrote:

> Hi Finn,
> 
> I'm afraid I cannot test anything on Atari hardware at present - my 
> Falcon ate it's IDE disk partition table with all the fun that entails. 

That doesn't sound good.

> Haven't even begun to try and recover that yet.
> 
> If you send a patch I could build a kernel and send that to Christian 
> for testing (if he's got his Falcon up and running - might be a tad warm 
> in the attic for that, in fact).

Anyone with a suitable Atari, i.e. ATARIHW_PRESENT(TT_CLK), who can boot 
both TOS and Linux could resolve the question. (Perhaps with an emulator?)

Any old kernel binary would do, since atari_scsi should print either 
"HOSTID=n" or "this_id n" at startup.

If n doesn't agree with what TOS says about the host's SCSI ID, then I 
think a trivial patch is safe enough. Especially if cat /proc/driver/nvram 
produces a "SCSI host ID : m" that does agree with TOS.

Regards,
Finn

> 
> Cheers,
> 
>     Michael
> 
> 
> Am 14.07.15 um 20:17 schrieb Finn Thain:
> > On Mon, 13 Jul 2015, Andreas Schwab wrote:
> >
> > > Finn Thain <fthain@telegraphics.com.au> writes:
> > >
> > > > BTW, I didn't change the SCSI ID location in NVRAM. This code says 16
> > > > whereas atari_scsi says 14. Which one is correct?
> > > I think atari_scsi is wrong.  The best source I could find
> > > (http://www.gratifiant.com/nvram-falcon-t561185) places it after the
> > > video mode byte, thus at byte 16.
> > Thanks for that. BTW, I googled a phrase from that page and found this one
> >    http://toshyp.atari.org/en/004009.html
> > which may be closer to the source.
> >
> > I'll send a patch if someone can offer to test such a change to atari_scsi
> > (or merely confirm that the SCSI ID setting in TOS does not match this_id
> > given in dmesg).
> >
> 
