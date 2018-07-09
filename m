Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Pfxq1LX2zDr0d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 08:23:57 +1000 (AEST)
Message-ID: <9c74bcada9949792f83997195d4d365a850114a6.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Tim Small <tim@seoss.co.uk>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 09 Jul 2018 17:21:42 -0500
In-Reply-To: <0bec4690-992b-a6ef-3989-a1ce96da825d@seoss.co.uk>
References: <1ed6ce0c-f7df-615b-ffdb-8dab25b506f6@seoss.co.uk>
 <bdc2e385580cc08bcbf9d5b3595cbca5162314f8.camel@buserror.net>
 <0bec4690-992b-a6ef-3989-a1ce96da825d@seoss.co.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: NXP p1010se device trees only correct for P1010E/P1014E, not
 P1010/P1014 SoCs.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-07-09 at 09:38 +0100, Tim Small wrote:
> On 06/07/18 19:41, Scott Wood wrote:
> > > My openwrt patch
> > > just does a:
> > > 
> > > /delete-node/  crypto@30000;
> > > 
> > > after the p1010si-post.dtsi include.
> > 
> > U-Boot should already be removing the node on non-E chips -- see
> > ft_cpu_setup() in arch/powerpc/cpu/mpc85xx/fdt.c
> 
> 
> Hi Scott,
> 
> Thanks for your email.  The device in question ships an old uboot (a 
> vendor fork of U-Boot 2010.12-svn15934).

This was added by commit 6b70ffb9d1b2e, committed in July 2008... maybe
there's a problem with the old U-Boot finding the crypto node on this
particular chip?

> I am right in saying that the right fix is to either:
> 
> Use a bootloader (such as current upstream uboot) which adjusts the 
> device tree properly...
> 
> or:
> 
> In the case (such as OpenWRT) where the preferred installation method is 
> to retain the vendor bootloader, then the distro kernel should handle 
> the device tree fixup itself?

The NXP PPC device trees in the kernel are meant to be completed by U-Boot
(years ago I repeatedly suggested that the trees be moved into the U-Boot
source to reflect this, but nobody seemed interested).  Generally that is
mainline and  NXP SDK U-Boot, but a board dts file might cater to some other
U-Boot fork (or   other bootloader) if that's what ships on the board.  Does
this hardware have a board dts file in mainline Linux?

-Scott
