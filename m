Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id AFF5A1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 15:21:36 +1000 (AEST)
Date: Wed, 15 Jul 2015 15:21:11 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org
Subject: Re: [RFC v4 17/25] powerpc, fbdev: Use arch_nvram_ops methods instead
 of nvram_read_byte() and nvram_write_byte()
In-Reply-To: <1436874720.3948.252.camel@kernel.crashing.org>
Message-ID: <alpine.LNX.2.00.1507151200510.2862@nippy.intranet>
References: <20150712102527.356151908@telegraphics.com.au>
 <20150712102531.505897278@telegraphics.com.au>
 <alpine.LNX.2.00.1507141725480.851@nippy.intranet>
 <1436874720.3948.252.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Tue, 14 Jul 2015, Benjamin Herrenschmidt wrote:

> On Tue, 2015-07-14 at 17:58 +1000, Finn Thain wrote:
> > Make use of arch_nvram_ops in device drivers so that the nvram_* 
> > function exports can be removed.
> > 
> > Since they are no longer global symbols, rename the PPC32 nvram_* 
> > functions appropriately.
> > 
> > Add the missing CONFIG_NVRAM test to imsttfb to avoid a build failure.
> > 
> > Add a CONFIG_PPC32 test to matroxfb because PPC64 doesn't implement 
> > the read_byte() method.
> 
> This is a bit fishy in a way because some of that nvram stuff is really 
> about powermac/apple nvram offsets, ie, "XPRAM".

Yes, the generalization that PPC64 does not have XPRAM is wrong, but that 
wasn't originally my doing. If we were to address that issue, this patch 
series may not be the best place to do so.

The situation presently is that CONFIG_NVRAM cannot be enabled on PPC64. I 
took advantage of that simplification, despite the corner cases where it 
fails.

The corner cases are found among PPC64 systems with Matrox cards. The 
other PowerMac video drivers are not really relevant here due to "depends 
on PPC32" or "#if defined(CONFIG_PPC32)", meaning that nvram_read_byte() 
isn't a problem there.

Perhaps only dual-boot systems are at issue because AFAIK only Mac OS 
offers a user friendly way to edit XPRAM settings (?) Further, does the 
video mode setting in XPRAM relate only to the MacOS main screen and not 
to other devices? That is, are we concerned here only with dual-boot PPC64 
machines with one matrox card, as the main screen, and no Linux desktop 
environment and no video mode settings on the kernel command line?

> Maybe we should have a dedicated accessor for "mac_xpram" and NULL-check 
> it rather than using ifdef's ?

I wanted arch_nvram_ops to be const data, which means a NULL check won't 
work, because defined(CONFIG_PPC_PMAC) does not imply availability of 
XPRAM at run-time.

There is a similar situation in the m68k portion of this patch series: a 
multi-platform kernel binary might run on an Atari or a Mac. On m68k I 
resolved this with MACH_IS_MAC(), which is analogous to 
machine_is(powermac).

So I can see how to implement XPRAM for matroxfb and imsttfb on PPC64. But 
this is an enhancement that I would defer unless the present limitation is 
already problematic.

-- 
