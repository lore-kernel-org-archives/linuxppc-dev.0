Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 83B9CDE000
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 04:39:42 +1100 (EST)
Date: Thu, 25 Jan 2007 11:39:15 -0600
From: Scott Wood <scottwood@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 01/18] Include autoconf.h from the bootwrapper.
Message-ID: <20070125173915.GA18889@ld0162-tx32.am.freescale.net>
References: <20070124210654.GA10527@ld0162-tx32.am.freescale.net>
	<20070124235150.GA26212@localhost.localdomain>
	<56B86A8F-4E40-4C58-A774-0DE3C7AA8CE2@kernel.crashing.org>
	<17848.6331.164992.951431@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17848.6331.164992.951431@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 25, 2007 at 01:40:59PM +1100, Paul Mackerras wrote:
> Kumar Gala writes:
> 
> > I think the problem is how to resolve the variations of the u-boot/ 
> > ppcboot bd_t that changes from board to board and based on config.
> 
> The wrapper should be able to build bootable images for any of the
> boards, that is, for any given bd_t variant, there should be a flag to
> wrapper that tells it to build an image that understands that variant.
> 
> It's reasonable for arch/powerpc/boot/Makefile to pass different flags
> to wrapper depending on the kernel config.  I don't want wrapper
> itself, or anything it uses, to be config-dependent.

So basically, there'd be several lines in the arch/powerpc/boot/Makefile
like this?

cflags-$(CONFIG_6xx) += -DCONFIG_6xx
cflags-$(CONFIG_8xx) += -DCONFIG_8xx
cflags-$(CONFIG_E500) += -DCONFIG_E500
BOOTCFLAGS += $(cflags-y)

I don't really see the point (a simple grep will show you all the config
dependencies in the bootwrapper, to verify that it's only platform stuff
and not actual options), but I can do it that way if you really want. 
One way or another, the information has to be there, and it has to be
compile-time or else the bd_info struct layout will be wrong.

-Scott
