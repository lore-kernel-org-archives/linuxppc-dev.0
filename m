Return-Path: <paubert@iram.es>
Received: from rudy.puc.rediris.es (unknown [IPv6:2001:720:418:ca01::132])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6F874B6FA8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2012 17:29:47 +1000 (EST)
Date: Thu, 21 Jun 2012 09:29:28 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: linux-next: build failure after merge of the final tree
 (powerpc related)
Message-ID: <20120621072928.GA13998@visitor2.iram.es>
References: <20120620175014.a822a766e0f91f7b44f48fa0@canb.auug.org.au>
 <1340256961.1998.11.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340256961.1998.11.camel@concordia>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org,
 Alan Modra <amodra@bigpond.net.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 21, 2012 at 03:36:01PM +1000, Michael Ellerman wrote:
> On Wed, 2012-06-20 at 17:50 +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the final tree, today's linux-next build (powerpc
> > allyesconfig) failed like this:
> > 
> > powerpc64-linux-ld: arch/powerpc/net/built-in.o: In function `bpf_slow_path_word':
> > (.text+0x90): sibling call optimization to `skb_copy_bits' does not allow automatic multiple TOCs; recompile with -mminimal-toc or -fno-optimize-sibling-calls, or make `skb_copy_bits' extern
> 
> 
> Those seem to be caused because we don't have a nop after the call,
> meaning we can't patch the TOC pointer on the way back. Adding a nop
> fixes those.
> 
> But, then I get 32,410 variants of this:
> 
> powerpc64-linux-ld: /src/next/net/openvswitch/vport-netdev.c:189:(.text+0x89b990): 
> 	sibling call optimization to `_restgpr0_28' does not allow automatic multiple TOCs;
> 	recompile with -mminimal-toc or -fno-optimize-sibling-calls, or make `_restgpr0_28' extern
> 
> 

These functions should not need a TOC in the first place. There is
code in the linker (for 64 bit only: bfd/elf64-ppc.c) to automatically 
generate them whenever they are needed.

I suspect you compile with -Os. But I don't think you can use
these functions when doing a sibling call since restgpr0_nn
implies a return to the caller. restgpr1_nn would be different...

> And those are generated calls so I don't see how we can fix them.
> 
> > I started building with gcc 4.6.3/binutils 2.22 today.  gcc
> > 4.6.0/binutils 2.21 do not produce this error, it produces this instead
> > (which has been happening for a long time):
> > 
> > powerpc64-linux-ld: TOC section size exceeds 64k
> 
> 
> So presumably there's some new error checking that we're hitting, I
> imagine it was always broken, but now it's being more explicit.

I'm not so sure. I suspect gcc, but upgrading gcc and binutils at the
same time may not be the wisest...

	Gabriel
