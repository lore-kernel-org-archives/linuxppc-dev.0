Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 921C0B6FAF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 11:02:44 +1100 (EST)
Message-ID: <1329436955.2892.32.camel@pasglop>
Subject: Re: [PATCH] powerpc/usb: fix bug of kernel hang when initializing usb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Date: Fri, 17 Feb 2012 11:02:35 +1100
In-Reply-To: <1329433132.2892.30.camel@pasglop>
References: <1329386540-12341-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1329433132.2892.30.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-02-17 at 09:58 +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2012-02-16 at 18:02 +0800, Shengzhou Liu wrote:
> > If USB UTMI PHY is not enable, writing to portsc register will lead to
> > kernel hang during boot up.
> > 
> > Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> > ---
> > Apply for master branch of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 
> > Tested on P5020DS, the issue was reported by Benjamin Herrenschmidt. 
> 
> This fixes the hang, but sadly doesn't make USB work. I now get:

 .../...

Ok, found the problem.

First, the SDK kernel had a delay after setting that bit, I added that
back in. This is not what fixed it but it looks like the right thing to
do, though please, use msleep rather than udelay here if possible (not
in atomic context).

Then, the real culprit is (CC'ing Kumar and Scott to figure out why)
this statement:

#if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
	/*
	 * Turn on cache snooping hardware, since some PowerPC platforms
	 * wholly rely on hardware to deal with cache coherent
	 */

	/* Setup Snooping for all the 4GB space */
	/* SNOOP1 starts from 0x0, size 2G */
	out_be32(non_ehci + FSL_SOC_USB_SNOOP1, 0x0 | SNOOP_SIZE_2GB);
	/* SNOOP2 starts from 0x80000000, size 2G */
	out_be32(non_ehci + FSL_SOC_USB_SNOOP2, 0x80000000 | SNOOP_SIZE_2GB);
#endif

I'm building a 64-bit kernel so this isn't compiled and it looks like
the EHCI is thus not snooping.

By removing the defined(CONFIG_PPC32) part of the statement, my problem
goes away.

Cheers,
Ben.
