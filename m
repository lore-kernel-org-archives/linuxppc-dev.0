Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tsvzT2dKszDqDN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jan 2017 11:32:37 +1100 (AEDT)
Date: Tue, 3 Jan 2017 11:33:21 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-m68k@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 10/10] m68k/mac: Replace via-maciisi driver with
 via-cuda driver
In-Reply-To: <CAMuHMdWFaaZdKa7+T6nruEv1sB8yYAm9yZLgy-UwefxM4b8MaA@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1701031010300.20542@nippy.intranet>
References: <cover.1483055859.git.fthain@telegraphics.com.au>
 <b44eec45f78cd84d9e3d6ff6c2d303ced19b0eca.1483055859.git.fthain@telegraphics.com.au>
 <CAMuHMdWFaaZdKa7+T6nruEv1sB8yYAm9yZLgy-UwefxM4b8MaA@mail.gmail.com>
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


On Mon, 2 Jan 2017, Geert Uytterhoeven wrote:

> Hi Finn, Ben,
> 
> On Sun, Jan 1, 2017 at 1:56 AM, Finn Thain <fthain@telegraphics.com.au> 
> wrote:
> > Change the device probe test in the via-cuda.c driver so it will load 
> > on Egret-based machines too. Remove the now redundant via-maciisi.c 
> > driver.
> >
> > Tested-by: Stan Johnson <userm57@yahoo.com> Signed-off-by: Finn Thain 
> > <fthain@telegraphics.com.au>
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 

Thanks for your review.

> I guess this will go in with the rest of the series through Ben's 
> macintosh tree?
> 

Most of the recent patches in drivers/macintosh, including my 2015 
submission, commit 2dc710e93c ("macintosh/nvram: Remove as unused"), went 
through Michael's tree. But either tree would be fine with me.

BTW, to my knowledge there is no programmer's reference material for Cuda 
or Egret system controllers (excepting that which seems to be confined to 
Apple Inc). AIUI, Cuda was not part of CHRP. But one could observe all of 
the signalling between CPU and MCU by tracing the VIA I/O lines or doing 
the equivalent in a good emulator -- theoretically, of course. Would this 
be useful to reviewers?

-- 

> > ---
> >  arch/m68k/include/asm/macintosh.h |   2 +-
> >  arch/m68k/mac/config.c            |  18 +-
> >  arch/m68k/mac/misc.c              |  72 +---
> >  drivers/macintosh/Kconfig         |  24 +-
> >  drivers/macintosh/Makefile        |   1 -
> >  drivers/macintosh/adb.c           |   4 -
> >  drivers/macintosh/via-cuda.c      |   8 +-
> >  drivers/macintosh/via-maciisi.c   | 677 --------------------------------------
> >  8 files changed, 30 insertions(+), 776 deletions(-)
> >  delete mode 100644 drivers/macintosh/via-maciisi.c
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
