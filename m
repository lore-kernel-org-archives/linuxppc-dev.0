Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyzwc5HfXzDqSP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 17:47:44 +1100 (AEDT)
Date: Wed, 11 Jan 2017 07:48:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Aurelien Jacquiot <a-jacquiot@ti.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Chris Zankel <chris@zankel.net>,
 David Howells <dhowells@redhat.com>,
 "David S . Miller" <davem@davemloft.net>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Geoff Levand <geoff@infradead.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Haavard Skinnemoen <hskinnemoen@gmail.com>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>,
 Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
 "James E . J . Bottomley" <jejb@parisc-linux.org>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Joerg Roedel <joro@8bytes.org>, Jon Mason <jdmason@kudzu.us>,
 Jonas Bonn <jonas@southpole.se>, Ley Foon Tan <lftan@altera.com>,
 Mark Salter <msalter@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Mikael Starvik <starvik@axis.com>,
 Muli Ben-Yehuda <mulix@mulix.org>, Rich Felker <dalias@libc.org>,
 Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Thomas Gleixner <tglx@linutronix.de>,
 Tony Luck <tony.luck@intel.com>, Will Deacon <will.deacon@arm.com>,
 x86@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 adi-buildroot-devel@lists.sourceforge.net,
 iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
 linux-am33-list@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
 nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
 sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp
Subject: Re: [PATCH 2/9] Move dma_ops from archdata into struct device
Message-ID: <20170111064803.GB26893@kroah.com>
References: <20170111005648.14988-1-bart.vanassche@sandisk.com>
 <20170111005648.14988-3-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170111005648.14988-3-bart.vanassche@sandisk.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 10, 2017 at 04:56:41PM -0800, Bart Van Assche wrote:
> Several RDMA drivers, e.g. drivers/infiniband/hw/qib, use the CPU to
> transfer data between memory and PCIe adapter. Because of performance
> reasons it is important that the CPU cache is not flushed when such
> drivers transfer data. Make this possible by allowing these drivers to
> override the dma_map_ops pointer. Additionally, introduce the function
> set_dma_ops() that will be used by a later patch in this series.

When you say things like "additionally", that's a huge flag that this
needs to be split up into multiple patches.  No need to add
set_dma_ops() here in this patch.

And I'd argue that it should be dma_ops_set(), and dma_ops_get(), just
to keep the namespace sane, but that's probably a different set of
patches...

thanks,

greg k-h
