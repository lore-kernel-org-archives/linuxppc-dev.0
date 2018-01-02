Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z9rD83r9WzF0PX
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jan 2018 21:39:52 +1100 (AEDT)
Received: by mail-qt0-x242.google.com with SMTP id r39so62105497qtr.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jan 2018 02:39:52 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20171229081911.2802-6-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-6-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Jan 2018 11:39:49 +0100
Message-ID: <CAMuHMdV2oT9G3yOjx-oaw06nw27zF_Y34quYf--u13xjKs3dJQ@mail.gmail.com>
Subject: Re: [PATCH 05/67] dma-mapping: replace PCI_DMA_BUS_IS_PHYS with a
 flag in struct dma_map_ops
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-ia64@vger.kernel.org,
 Linux-sh list <linux-sh@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-c6x-dev@linux-c6x.org,
 "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
 "the arch/x86 maintainers" <x86@kernel.org>,
 arcml <linux-snps-arc@lists.infradead.org>,
 adi-buildroot-devel@lists.sourceforge.net,
 linux-m68k <linux-m68k@lists.linux-m68k.org>, patches@groups.riscv.org,
 "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, Parisc List <linux-parisc@vger.kernel.org>,
 Cris <linux-cris-kernel@axis.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 29, 2017 at 9:18 AM, Christoph Hellwig <hch@lst.de> wrote:
> The current PCI_DMA_BUS_IS_PHYS decided if a dma implementation is bound
> by the dma mask in the device because it directly maps to a physical
> address range (modulo an offset in the device), or if it is virtualized
> by an iommu and can map any address (that includes virtual iommus like
> swiotlb).  The problem with this scheme is that it is per-architecture and
> not per dma_ops instance, and we are growing more and more setups that
> have multiple different dma operations in use on a single system, for
> which this scheme can't provide a correct answer.  Depending on the
> architecture that means we either get a false positive or false negative
> at the moment.
>
> This patch instead extents the is_phys flag in struct dma_map_ops that
> is currently only used by a few architectures to be used tree wide.
>
> Note that this means that we now need a struct device parent in the
> Scsi_Host or netdevice.  Every modern driver has these, but there might
> still be a few outdated legacy drivers out there, which now won't make
> an intelligent decision.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
