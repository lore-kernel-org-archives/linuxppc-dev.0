Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8DD83DDFBB
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 02:14:44 +1000 (EST)
Date: Mon, 21 Jul 2008 11:13:07 -0500
From: Scott Wood <scottwood@freescale.com>
To: Dave Jones <davej@redhat.com>, Kumar Gala <galak@kernel.crashing.org>,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ep8248e: Fix compile problem if !CONFIG_FS_ENET
Message-ID: <20080721161307.GC13185@loki.buserror.net>
References: <Pine.LNX.4.64.0807160838520.14127@blarg.am.freescale.net>
	<20080716214722.GA6251@ld0162-tx32.am.freescale.net>
	<20080716215745.GA17093@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080716215745.GA17093@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 16, 2008 at 05:57:45PM -0400, Dave Jones wrote:
> On Wed, Jul 16, 2008 at 04:47:23PM -0500, Scott Wood wrote:
>  > On Wed, Jul 16, 2008 at 08:39:12AM -0500, Kumar Gala wrote:
>  > > If we don't enable FS_ENET we get build issues:
>  > > 
>  > > arch/powerpc/platforms/built-in.o: In function `ep8248e_mdio_probe':
>  > > arch/powerpc/platforms/82xx/ep8248e.c:129: undefined reference to `alloc_mdio_bitbang'
>  > > arch/powerpc/platforms/82xx/ep8248e.c:143: undefined reference to `mdiobus_register'
>  > 
>  > How is this possible?  CONFIG_EP8248E selects CONFIG_MDIO_BITBANG.
> 
> If CONFIG_PHYLIB=m however, that doesn't make any difference, because
> vmlinuz is trying to use a symbol which now lives in a module.

Yuck.  If FOO selects BAR, and FOO is 'y', then BAR should be 'y', not 'm'.
If BAR depends on other symbols that are 'm', they should be changed to 'y'.

-Scott
