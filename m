Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BFDBC67FC4
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2005 22:15:57 +1000 (EST)
Message-ID: <43032A76.6080104@varma-el.com>
Date: Wed, 17 Aug 2005 16:15:50 +0400
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-fbdev-devel@lists.sourceforge.net
References: <20050816194825.A62AC353AB5@atlas.denx.de>
	<43030D41.3000508@varma-el.com>
	<Pine.LNX.4.62.0508171317540.6073@numbat.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0508171317540.6073@numbat.sonytel.be>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, surendra.yadav@softdel.com
Subject: Re: [F]Framebuffer driver using SM501 hardware.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Geert Uytterhoeven wrote:
> On Wed, 17 Aug 2005, Andrey Volkov wrote:
> 
>>Todo:
>>- 16 bpp colormap (needed reverse endian support in fbcon/fbmem)
> 
> 
> Can you please elaborate? For 2.6, there should be no such problems (for 2.4,
> there are).

Sorry for inexactitude, problem (as usually :)) in next (for case of
MPC5200 connected through PCI to SM501): PCI on PPC (and hence SM501) is
a little endian, PPC - big endian.
Currently (up to 2.6.13-rc6) frame buffer routines use
__raw_writeXX for write to fb memory. Result - garbage with colors in
RGB565/RGB888 modes (but pixels, meanwhile, are in place). If using
write[lw] - colors are diplayed correctly, but all image pixels are
shifted for (RGB565). This is not bug of frame buffer, this is lack of
some define in .config which tell fb/device driver how palette must be
generated (more precisely it is unknown when must be RGB565, but when
must be BGR565).

Problem redouble when hw accel, as bus muster, entered in the game:
for accelerated imageblit pixels must be in RGB565 mode :((

-- 
Regards
Andrey Volkov
