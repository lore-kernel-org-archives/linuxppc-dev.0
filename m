Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 1807067A6F
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 08:26:36 +1000 (EST)
Date: Fri, 21 Apr 2006 00:26:35 +0200 (MEST)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: Gabriel Paubert <paubert@iram.es>
MIME-Version: 1.0
References: <20060420220707.GA17593@iram.es>
Subject: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
Message-ID: <25098.1145571995@www002.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> --- Ursprüngliche Nachricht ---
> Von: Gabriel Paubert <paubert@iram.es>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> Kopie: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
> Betreff: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
> Datum: Fri, 21 Apr 2006 00:07:08 +0200
> 
> More details please what are the exact capabilities of the south and
> host bridges? 
The southbridge is a VIA82C686B, which supports ISA DMA in the first 16MB.
The host bridge is a MAI ArticiaS. The ArticiaS has a bug in the snoop
signal logic and therefore does not support cache coherent DMA. 

> I've never needed (and therefore) used floppy on my PreP boards (Motorola
> MVME2[467]xx series), but they have a south bridge (WinBond) that has 32
> bit DMA capability. This was specified in the PreP spec. 

Oh, I thought PReP specifies only 24bit DMA. Okay, so the AmigaOne is more
like the i386 platform, just with a PPC cpu. ;-)

> This may also depend on the host bridge since RAM appears at 2GB on
> default PreP machines, which is an area that you can't access with
> normal ISA DMA anyway. On the MVME machines, you could map PCI addresses
> 0-16 MB anywhere in RAM by reprogramming the host bridge.
This is not the case for the AmigaOne. The RAM starts at physical address 0
(similar to CHRP). AFAIK the host bridge does not allow the remapping of the
address space. Maybe the southbridge can do this for DMA operation. I have
to investigate this. Thanks for the hint!

> > 3. How are DMA buffers used outside the kernel? Do user programs get a
> > pointer to the DMA buffer (in theory) from the device driver or is the
> > data copied to another buffer allocated by an user program?
> 
> If your memory is uncacheable, you are better off copying it to
> cacheable memory. At least you are sure that you only access it 
> once (trying to copy with FP registers to halve the number of
> accesses might be a big win, but you need to be careful).
Sounds like a big performance loss. I hope this is not necessary.

Thanks,

Gerhard

-- 
GMX Produkte empfehlen und ganz einfach Geld verdienen!
Satte Provisionen für GMX Partner: http://www.gmx.net/de/go/partner
