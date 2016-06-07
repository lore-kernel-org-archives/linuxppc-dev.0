Return-Path: <prvs=95959861b=david.vrabel@citrix.com>
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
 (using TLSv1.2 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rP5T24xWTzDqGL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jun 2016 19:13:10 +1000 (AEST)
Subject: Re: [RFC v3 20/45] xen: dma-mapping: Use unsigned long for dma_attrs
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Richard Henderson
 <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King
 <linux@armlinux.org.uk>, Stefano Stabellini <sstabellini@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, "Haavard Skinnemoen" <hskinnemoen@gmail.com>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>, Steven Miao
 <realmz6@gmail.com>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot
 <a-jacquiot@ti.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson
 <jesper.nilsson@axis.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua
 Yu <fenghua.yu@intel.com>, "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan
 <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, "Ralf Baechle"
 <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, "Ley Foon Tan"
 <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, "James E.J. Bottomley"
 <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, "Olof
 Johansson" <olof@lixom.net>, Geoff Levand <geoff@infradead.org>, "Martin
 Schwidefsky" <schwidefsky@de.ibm.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H.
 Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, "Muli
 Ben-Yehuda" <muli@il.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>, "David
 Airlie" <airlied@linux.ie>, Joerg Roedel <joro@8bytes.org>, David Woodhouse
 <dwmw2@infradead.org>, Andrew Morton <akpm@linux-foundation.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-alpha@vger.kernel.org>, <linux-snps-arc@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <xen-devel@lists.xenproject.org>,
 <adi-buildroot-devel@lists.sourceforge.net>, <linux-c6x-dev@linux-c6x.org>,
 <linux-cris-kernel@axis.com>, <uclinux-h8-devel@lists.sourceforge.jp>,
 <linux-hexagon@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
 <linux-m68k@lists.linux-m68k.org>, <linux-metag@vger.kernel.org>,
 <linux-mips@linux-mips.org>, <linux-am33-list@redhat.com>,
 <nios2-dev@lists.rocketboards.org>, <linux-parisc@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
 <linux-sh@vger.kernel.org>, <sparclinux@vger.kernel.org>,
 <discuss@x86-64.org>, <linux-pci@vger.kernel.org>,
 <linux-xtensa@linux-xtensa.org>, <dri-devel@lists.freedesktop.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
 <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <linux-rockchip@lists.infradead.org>,
 <linux-rdma@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
 <linux-media@vger.kernel.org>, <linux-omap@vger.kernel.org>,
 <linux-fbdev@vger.kernel.org>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
 <1464881987-13203-21-git-send-email-k.kozlowski@samsung.com>
CC: <hch@infradead.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From: David Vrabel <david.vrabel@citrix.com>
Message-ID: <57568E8B.4000707@citrix.com>
Date: Tue, 7 Jun 2016 10:06:19 +0100
MIME-Version: 1.0
In-Reply-To: <1464881987-13203-21-git-send-email-k.kozlowski@samsung.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/06/16 16:39, Krzysztof Kozlowski wrote:
> Split out subsystem specific changes for easier reviews. This will be
> squashed with main commit.

Acked-by: David Vrabel <david.vrabel@citrix.com>

David
