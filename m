Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 40411DDEE2
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 17:51:27 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 06 May 2008 09:51:15 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1210031058.21644.120.camel@pasglop>
Message-ID: <20080506075115.269150@gmx.net>
MIME-Version: 1.0
References: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>	
	<6DA6B1DA-11B5-4B89-88AD-561B4D17B33B@kernel.crashing.org>	
	<20080505195054.172000@gmx.net> <1210031058.21644.120.camel@pasglop>
Subject: Re: [PATCH] Sam440ep support
To: benh@kernel.crashing.org
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org, cjg@cruxppc.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Tue, 06 May 2008 09:44:18 +1000
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: Kumar Gala <galak@kernel.crashing.org>, cjg@cruxppc.org, linuxppc-dev@ozlabs.org
> Betreff: Re: [PATCH] Sam440ep support

> 
> On Mon, 2008-05-05 at 21:50 +0200, Gerhard Pircher wrote:
> > This is a (bad) hack that I also use on the AmigaOne to get the ALSA
> > sound drivers working with DMA, because ALSA doesn't work with
> > dma-noncoherent.c. The problem is the "nopage" mechanism, which fails
> > with non coherent DMA allocations due to their own virtual address
> > space (correct me, if I'm wrong).
> > 
> > See this thread for more info:
> > http://readlist.com/lists/vger.kernel.org/linux-kernel/45/226541.html
> > 
> > This is a general problem that affects all powerpc boards that use
> > dma-noncoherent.c with ALSA PCI drivers.
> 
> The link above doesn't provide any useful information on the problem and
> it contains itself a non working link...
Sorry, I didn't check the embedded link. This one should work:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0406.2/0801.html

IIRC the problem is the mmaping of non coherent DMA allocations, as you
already know. The link above points to a very old (from 2004) and quite
long thread where the correct DMA API for mmaping DMA allocations was
discussed.

> Can somebody explains exactly what's going on ? That shouldn't be hard
> to fix. I can't believe the problem has been around for 2 years and
> nobody actually bothered fixing it properly.
Takashi Iwai posted a preliminary patch a long time ago. I tested it on my
machine and it failed with non coherent scatter-gather DMA allocations
(I guess almost all ALSA PCI drivers use SG DMA?).

Thanks!

Gerhard

-- 
GMX startet ShortView.de. Hier findest Du Leute mit Deinen Interessen!
Jetzt dabei sein: http://www.shortview.de/?mc=sv_ext_mf@gmx
