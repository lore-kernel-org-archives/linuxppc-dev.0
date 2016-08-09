Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7pLj2Z6SzDqdv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 19:06:51 +1000 (AEST)
Date: Tue, 9 Aug 2016 02:06:45 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: 4.8.0-rc1: Invalid memory access at $SRR0: 0140f86c $SRR1:
 00003030
In-Reply-To: <alpine.DEB.2.20.14.1608082213450.8131@trent.utfs.org>
Message-ID: <alpine.DEB.2.20.14.1608090157090.8131@trent.utfs.org>
References: <alpine.DEB.2.20.14.1608082213450.8131@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 8 Aug 2016, Christian Kujau wrote:
> while trying to upgrade this PowerBook G4 from 4.7-rc7 to 4.8-rc1, it's 
> unable to boot the Yaboot (v1.3.16 from Debian/stable) boot loader:
> 
> ================================================================
> copying OF device tree...
> Building dt strings...
> Building dt stucture...
> Device tree strings 0x01e72000 -> 0x01e73615
> Device tree struct  0x01e74000 -> 0x01e7e000
> Quiescing Open Firmware...
> Bootng Linux via __start()...
> 
> Invalid memory access at $SRR0: 0140f86c  $SRR1: 00003030
> 
> Apple PowerBook6,8 4.9.0f0 BootROM built on 01/10/05 at 10:39:14
> [...]
> 
>  ok
> 0:> _
> ================================================================
> 
> Going back to 4.7-rc7 (w/o installing Yaboot again) works just fine. The 
> config is mostly the same (used "make oldconfig" from 4.7), but I've said 
> YES to CONFIG_SLAB_FREELIST_RANDOM - could this be causing the boot 
> failure? Full .config and screen shot: http://nerdbynature.de/bits/4.8.0-rc1/

A git-bisect led me to:

=========================================
commit 9402c684613163888714df0955fa1f17142b08bf
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Tue Jul 5 15:03:41 2016 +1000

    powerpc: Factor do_feature_fixup calls
    
    32 and 64-bit do a similar set of calls early on, we move it all to
    a single common function to make the boot code more readable.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
=========================================

But I'm unable to revert just this patch:

$ git revert 9402c684613163888714df0955fa1f17142b08bf
error: could not revert 9402c68... powerpc: Factor do_feature_fixup calls
hint: after resolving the conflicts, mark the corrected paths

The bisect-log:

=========================================
$ git bisect log
git bisect start '--' 'arch/powerpc'
# good: [523d939ef98fd712632d93a5a2b588e477a7565e] Linux 4.7
git bisect good 523d939ef98fd712632d93a5a2b588e477a7565e
# bad: [29b4817d4018df78086157ea3a55c1d9424a7cfc] Linux 4.8-rc1
git bisect bad 29b4817d4018df78086157ea3a55c1d9424a7cfc
# bad: [3808a88985b4f5f5e947c364debce4441a380fb8] powerpc: Move FW feature probing out of pseries probe()
git bisect bad 3808a88985b4f5f5e947c364debce4441a380fb8
# good: [a203658b5ed37c11e5016d3fbbbab9ce018c1b78] powerpc/opal: Wake up kopald polling thread before waiting for events
git bisect good a203658b5ed37c11e5016d3fbbbab9ce018c1b78
# good: [0dfffb48cecd8f84c6e649baee9bacd9be925734] powerpc/powernv: abstraction for saving SPRs before entering deep idle states
git bisect good 0dfffb48cecd8f84c6e649baee9bacd9be925734
# good: [66c570f545e056babdd9510595ce762dcedadd71] powerpc/mm: use _raw variant of page table accessors
git bisect good 66c570f545e056babdd9510595ce762dcedadd71
# good: [c2ca9f6b4cc4c45eb598b24b8b06beee668052d5] powerpc/powernv: Fix pci-cxl.c build when CONFIG_MODULES=n
git bisect good c2ca9f6b4cc4c45eb598b24b8b06beee668052d5
# good: [4c91bd6eeabb004f283db8a6854b134e2a2de1bc] powerpc: Merge the RELOCATABLE config entries for ppc32 and ppc64
git bisect good 4c91bd6eeabb004f283db8a6854b134e2a2de1bc
# bad: [c4bd6cb87c9e28a7d9f4a97db5a06cc538eb5e48] powerpc: Move 64-bit feature fixup earlier
git bisect bad c4bd6cb87c9e28a7d9f4a97db5a06cc538eb5e48
# bad: [9402c684613163888714df0955fa1f17142b08bf] powerpc: Factor do_feature_fixup calls
git bisect bad 9402c684613163888714df0955fa1f17142b08bf
# good: [27d1149667352772240655b65372a4294f992ea7] powerpc/32: Remove RELOCATABLE_PPC32
git bisect good 27d1149667352772240655b65372a4294f992ea7
# first bad commit: [9402c684613163888714df0955fa1f17142b08bf] powerpc: Factor do_feature_fixup calls
=========================================


HTH,
Christian.
-- 
BOFH excuse #409:

The vulcan-death-grip ping has been applied.
