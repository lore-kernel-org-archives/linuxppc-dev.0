Return-Path: <k.kozlowski@samsung.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLbqv2ZMJzDqlb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 17:50:51 +1000 (AEST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0O8600HAGR4LX5A0@mailout1.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 03 Jun 2016 08:50:45 +0100 (BST)
Subject: Re: [RFC v3 02/45] dma-mapping: Use unsigned long for dma_attrs
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
 <1464881987-13203-3-git-send-email-k.kozlowski@samsung.com>
 <CAMuHMdXWMf7Dt77wSUj8NytQqb99jzDiAz46kJkAEz+6BX3Uvw@mail.gmail.com>
Cc: Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
 Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Haavard Skinnemoen <hskinnemoen@gmail.com>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>,
 Steven Miao <realmz6@gmail.com>, Mark Salter <msalter@redhat.com>,
 Aurelien Jacquiot <a-jacquiot@ti.com>, Mikael Starvik <starvik@axis.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>,
 Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>,
 Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 Geoff Levand <geoff@infradead.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 the arch/x86 maintainers <x86@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 David Vrabel <david.vrabel@citrix.com>, Juergen Gross <jgross@suse.com>,
 Bjorn Helgaas <bhelgaas@google.com>, David Airlie <airlied@linux.ie>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>,
 arcml <linux-snps-arc@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 xen-devel@lists.xenproject.org, "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>, linux-c6x-dev@linux-c6x.org,
 Cris <linux-cris-kernel@axis.com>, uclinux-h8-devel@lists.sourceforge.jp,
 "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 "moderated list:PANASONIC MN10300..." <linux-am33-list@redhat.com>,
 nios2-dev@lists.rocketboards.org, Parisc List <linux-parisc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>, discuss@x86-64.org,
 linux-pci <linux-pci@vger.kernel.org>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 linux-mediatek@lists.infradead.org,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 linux-rdma <linux-rdma@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <575136D0.6000101@samsung.com>
Date: Fri, 03 Jun 2016 09:50:40 +0200
MIME-version: 1.0
In-reply-to: <CAMuHMdXWMf7Dt77wSUj8NytQqb99jzDiAz46kJkAEz+6BX3Uvw@mail.gmail.com>
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/03/2016 09:17 AM, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Thu, Jun 2, 2016 at 5:39 PM, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
>> --- a/include/linux/dma-mapping.h
>> +++ b/include/linux/dma-mapping.h
>> @@ -5,13 +5,25 @@
> 
>> +/**
>> + * List of possible attributes associated with a DMA mapping. The semantics
>> + * of each attribute should be defined in Documentation/DMA-attributes.txt.
>> + */
>> +#define DMA_ATTR_WRITE_BARRIER         (1UL << 1)
> 
> Any particular reason they start at 2, not 1?

No reason. I'll fix this in next version (and trim Cc-list). Anyway the
values of constants won't match old ones but that should not be problem
(unless they are hard-coded somewhere).

Best regards,
Krzysztof
