Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyztl2gZCzDqfc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 17:46:07 +1100 (AEDT)
Date: Wed, 11 Jan 2017 07:46:24 +0100
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
Message-ID: <20170111064624.GA26893@kroah.com>
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
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: David Howells <dhowells@redhat.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Geoff Levand <geoff@infradead.org>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James E.J. Bottomley <jejb@parisc-linux.org>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Mikael Starvik <starvik@axis.com>
> Cc: Muli Ben-Yehuda <mulix@mulix.org>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: x86@kernel.org
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: adi-buildroot-devel@lists.sourceforge.net
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-am33-list@redhat.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-c6x-dev@linux-c6x.org
> Cc: linux-cris-kernel@axis.com
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-metag@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-rdma@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-xtensa@linux-xtensa.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: nios2-dev@lists.rocketboards.org
> Cc: openrisc@lists.librecores.org
> Cc: sparclinux@vger.kernel.org
> Cc: uclinux-h8-devel@lists.sourceforge.jp

That's a crazy cc: list, you should break this up into smaller pieces,
otherwise it's going to bounce...

> diff --git a/include/linux/device.h b/include/linux/device.h
> index 491b4c0ca633..c7cb225d36b0 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -885,6 +885,8 @@ struct dev_links_info {
>   * a higher-level representation of the device.
>   */
>  struct device {
> +	const struct dma_map_ops *dma_ops; /* See also get_dma_ops() */
> +
>  	struct device		*parent;
>  
>  	struct device_private	*p;

Why not put this new pointer down with the other dma fields in this
structure?  Any specific reason it needs to be first?

thanks,

greg k-h
