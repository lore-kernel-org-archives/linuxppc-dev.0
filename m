Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 by lists.ozlabs.org (Postfix) with ESMTP id 259CB1A00CD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Aug 2014 01:22:00 +1000 (EST)
In-Reply-To: <20140829091324.D71E61ABD63@localhost.localdomain>
References: <20140829091324.D71E61ABD63@localhost.localdomain>
To: Christophe Leroy <christophe.leroy@c-s.fr>
MIME-Version: 1.0
Subject: Re: [PATCH v2 00/19] powerpc/8xx: Optimise MMU TLB handling and add
 support of 16k pages
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-ID: <OF844FADBC.6B73E319-ONC1257D43.005106B8-C1257D43.005467D6@transmode.se>
Date: Fri, 29 Aug 2014 17:21:55 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> wrote on 2014/08/29 11:13:24:
> 
> This patchset:
> 1) provides several MMU TLB handling optimisation on MPC8xx.
> 2) adds support of 16k pages on MPC8xx.
> All changes have been successfully tested on a custom board equipped 
with MPC885
> 
> The two differences with first version of the patch are:
> 1) I removed the patch number 10, which was implementing a 16 bit 
alignment of the
> PGDIR. It is not worth potentially wasting up to 64k of memory just for 
removing one
> instruction (ori).
> 2) I managed to preserve r11 while calculating the level 2 address, 
therefore
> no more need to save r11 into CR.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>

This looks good but I need to look harder, some minor critique 
though(already sent)
 
As you are optimizing I think the impl.of powerpc/8xx: Invalidate non 
present TLBs 
in 2.4 is better than 3.x, compare:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/arch/powerpc/mm/fault.c?id=5efab4a02c89c252fb4cce097aafde5f8208dbfe
with
https://git.kernel.org/cgit/linux/kernel/git/wtarreau/linux-2.4.git/commit/?id=da5c5609e86fb12061f2c05a6ddd80ffc46592b2


This will free the TLB before you jump to xxx_page_fault which might need 
a TLB before invalidation
and it isolates this 8xx quirk in 8xx specific code.

 Jocke
