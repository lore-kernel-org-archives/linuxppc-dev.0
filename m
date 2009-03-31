Return-Path: <anemo@mba.ocn.ne.jp>
Received: from smtp.mba.ocn.ne.jp (mba.ocn.ne.jp [122.1.235.107])
	by ozlabs.org (Postfix) with ESMTP id 21576DDE24
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 03:09:58 +1100 (EST)
Date: Wed, 01 Apr 2009 00:26:51 +0900 (JST)
Message-Id: <20090401.002651.95063058.anemo@mba.ocn.ne.jp>
To: Geert.Uytterhoeven@sonycom.com
Subject: Re: [PATCH] linux-next remove wmb() from ide-dma-sff.c and scc_pata.c
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <alpine.LRH.2.00.0903310950040.9551@vixen.sonytel.be>
References: <da824cf30903301739l688e8eb2r46086953245ebbe5@mail.gmail.com>
	<alpine.LRH.2.00.0903310950040.9551@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-mips@linux-mips.org, bzolnier@gmail.com, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org, grundler@google.com, linux-kernel@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 31 Mar 2009 09:51:53 +0200 (CEST), Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > Followup to "[PATCH 03/10] ide: destroy DMA mappings after ending DMA"
> > email on March 14th:
> >     http://lkml.org/lkml/2009/3/14/17
> > 
> > No maintainer is listed for "Toshiba CELL Reference Set IDE" (BLK_DEV_CELLEB)
> > or tx4939ide.c in MAINTAINERS. I've CC'd "Ishizaki Kou" @Toshiba (Maintainer for
> > "Spidernet Network Driver for CELL") and linuxppc-dev list in the hope
> > someone else
> > would know or would be able to ACK this patch.
> 
> tx49xx is MIPS, for Nemoto-san.
> 
> > This patch:
> > o replaces "mask" variable in ide_dma_end() with #define.
> > o removes use of wmb() in ide-dma-sff.c and scc_pata.c.
> > o is not tested - I don't have (or want) the HW.
> > 
> > I did NOT remove wmb() use in tx4939ide.c. tx4939ide.c __raw_writeb()
> > for MMIO transactions. __raw_writeb() does NOT guarantee memory
> > transaction ordering.

The wmb() in tx4939ide.c was just copied from ide_dma_end().  On this
MIPS core memory operations are strictly ordered so that the wmb() can
be removed.

And on MIPS __raw_writeb() and writeb() do same thing except for
endian conversion.

I will send a patch just for tx4939ide.c.  Thank you for suggestion.

> > tx4939ide also uses mmiowb(). AFAIK, mmiowb() only has an effect on
> > SGI IA64 NUMA machines. I'm not going to guess how this driver might work.

On MIPS mmiowb() can be (ab)used to flush write buffer.  Please do not
drop this mmiowb().

---
Atsushi Nemoto
