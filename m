Return-Path: <davej@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 1AAB7DDF60
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 08:26:35 +1000 (EST)
Date: Wed, 16 Jul 2008 18:19:49 -0400
From: Dave Jones <davej@redhat.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/ep8248e: Fix compile problem if !CONFIG_FS_ENET
Message-ID: <20080716221949.GA18148@redhat.com>
References: <Pine.LNX.4.64.0807160838520.14127@blarg.am.freescale.net>
	<20080716214722.GA6251@ld0162-tx32.am.freescale.net>
	<20080716215745.GA17093@redhat.com>
	<37829F82-D71C-4B42-A752-DA86C6F2764D@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <37829F82-D71C-4B42-A752-DA86C6F2764D@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 16, 2008 at 05:10:29PM -0500, Kumar Gala wrote:
 > 
 > On Jul 16, 2008, at 4:57 PM, Dave Jones wrote:
 > 
 > > On Wed, Jul 16, 2008 at 04:47:23PM -0500, Scott Wood wrote:
 > >> On Wed, Jul 16, 2008 at 08:39:12AM -0500, Kumar Gala wrote:
 > >>> If we don't enable FS_ENET we get build issues:
 > >>>
 > >>> arch/powerpc/platforms/built-in.o: In function `ep8248e_mdio_probe':
 > >>> arch/powerpc/platforms/82xx/ep8248e.c:129: undefined reference to  
 > >>> `alloc_mdio_bitbang'
 > >>> arch/powerpc/platforms/82xx/ep8248e.c:143: undefined reference to  
 > >>> `mdiobus_register'
 > >>
 > >> How is this possible?  CONFIG_EP8248E selects CONFIG_MDIO_BITBANG.
 > >
 > > If CONFIG_PHYLIB=m however, that doesn't make any difference, because
 > > vmlinuz is trying to use a symbol which now lives in a module.
 > 
 > The mdiobus_register make sense, I'm not sure get why  
 > alloc_mdio_bitbang is undefined.

Erm, same reason.  it's built into phy.o, which ends up in the module,
not the vmlinuz.

(also, it doesn't look like it's exported even if it was built-in?)

	Dave

-- 
http://www.codemonkey.org.uk
