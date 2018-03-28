Return-Path: <BATV+21eba84c15e1805462fd+5330+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B6Qc0sn7zF2Fp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 23:20:07 +1100 (AEDT)
Date: Wed, 28 Mar 2018 05:04:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shea Levy <shea@shealevy.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
 uclinux-h8-devel@lists.sourceforge.jp,
 linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org,
 openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-sh@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 01/16] initrd: Add generic code path for common initrd
 unloading logic.
Message-ID: <20180328120440.GB1838@infradead.org>
References: <20180324174458.26423-1-shea@shealevy.com>
 <20180324174458.26423-2-shea@shealevy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180324174458.26423-2-shea@shealevy.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +#ifdef CONFIG_INITRAMFS_GENERIC_UNLOAD
> +void free_initrd_mem(unsigned long start, unsigned long end)
> +{
> +       free_reserved_area((void *)start, (void *)end, -1, "initrd");
> +}
> +#endif

Given how trivial this is and how many architectures can use it I'd
reverse the polarity and add a CONFIG_HAVE_ARCH_FREE_INITRD_MEM
instead.
