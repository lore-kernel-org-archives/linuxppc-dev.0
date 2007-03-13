Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 84F7ADDE0E
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 10:13:41 +1100 (EST)
Date: Tue, 13 Mar 2007 12:16:17 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 17/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
Message-ID: <20070313181617.GA5360@ld0162-tx32.am.freescale.net>
References: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
	<4CB3B3D5-6D4A-4D67-92FC-3B8C38850326@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CB3B3D5-6D4A-4D67-92FC-3B8C38850326@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 12, 2007 at 04:07:57PM -0500, Kumar Gala wrote:
> On Mar 12, 2007, at 3:42 PM, Scott Wood wrote:
> >The device trees currently in the kernel tree must have
> >/chosen/linux,stdout-path added to work with cuboot.
> 
> Why is linux,stdout-path needed by cuboot?

It's used by serial.c to find the console, and the kernel requires it as
well.  There's no information in the bd_t that would allow the
bootwrapper to generate this, so it has to come from the device tree.

The only reason it's not required with dt-enabled u-boot is that u-boot
has it hardcoded in the board's config file.

> > arch/powerpc/platforms/83xx/mpc834x_mds.c |    5 +-
> 
> the whitespace fixup in mpc834x_mds.c shouldn't be part of this.

Oops.  I need to be more careful with 'git commit -a'. :-(

-Scott
