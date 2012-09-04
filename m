Return-Path: <lars@metafoo.de>
Received: from smtp-out-217.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218]) by ozlabs.org (Postfix) with ESMTP id C07B32C0098
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2012 20:13:28 +1000 (EST)
Message-ID: <5045C19A.7000705@metafoo.de>
Date: Tue, 04 Sep 2012 10:53:46 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: dedekind1@gmail.com
Subject: Re: [PATCH 4/4] drivers/mtd/nand/mpc5121_nfc.c: some devm_ cleanups
References: <1346517191-8794-1-git-send-email-Julia.Lawall@lip6.fr>
 <1346517191-8794-4-git-send-email-Julia.Lawall@lip6.fr>
 <1346748171.12610.22.camel@sauron.fi.intel.com>
In-Reply-To: <1346748171.12610.22.camel@sauron.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Cc: David Woodhouse <dwmw2@infradead.org>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
 linux-mtd@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/04/2012 10:42 AM, Artem Bityutskiy wrote:
> Aiaiai! :-) [1] [2]
> 
> I've build-tested this using aiaiai and it reports that this change breaks the build:
> 
> dedekind@blue:~/git/maintaining$ ./verify ../l2-mtd/ mpc5121_nfc < ~/tmp/julia2.mbox 
> Tested the patch(es) on top of the following commits:
> ba64756 Quick fixes - applied by aiaiai
> 651c6fa JFFS2: don't fail on bitflips in OOB
> e22ac84 mtd: autcpu12-nvram: drop frees of devm_ alloc'd data
> ea9d312 mtd: cmdlinepart: minor cleanups
> 
> --------------------------------------------------------------------------------
> Failed to build the following commit for configuration "powerpc-mpc512x_defconfig" (architecture powerpc)":
> 
> 0fe13ab drivers/mtd/nand/mpc5121_nfc.c: some devm_ cleanups
> 
> ...
> drivers/mtd/nand/mpc5121_nfc.c: In function 'mpc5121_nfc_probe':
> drivers/mtd/nand/mpc5121_nfc.c:622:28: warning: variable 'regs_size' set but not used [-Wunused-but-set-variable]
> drivers/mtd/nand/mpc5121_nfc.c:622:16: warning: variable 'regs_paddr' set but not used [-Wunused-but-set-variable]
> drivers/built-in.o: In function `mpc5121_nfc_probe':
> mpc5121_nfc.c:(.devinit.text+0x2a14): undefined reference to `devm_clk_get'
> make[1]: *** [vmlinux] Error 1
> 
> --------------------------------------------------------------------------------
> 
> I do not really know why, but it seems that clock framework is not supported for powerpc. CCing the PPC mailing list. Preserved the context below for the PPC people.
> 

I've been bitten by the same issue recently, also cause by one of these
cocci devm patches. devm_clk_get is only available if the generic
clk_get/clk_put implementation is used. Not all architectures do this and
some implement their own clk_get/clk_put, etc functions. Since devm_clk_get
is merely a wrapper around clk_get/clk_put there is no reason why it should
depend CLKDEV_LOOKUP. I've prepared a patch which makes them generically
available if the clk_get/clk_put are implemented (i.e. if HAVE_CLK is set),
but it is on a different machine right now, will try to submit it later today.

- Lars
