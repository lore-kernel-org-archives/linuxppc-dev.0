Return-Path: <michael@ellerman.id.au>
Message-ID: <1340256961.1998.11.camel@concordia>
Subject: Re: linux-next: build failure after merge of the final tree
 (powerpc related)
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 21 Jun 2012 15:36:01 +1000
In-Reply-To: <20120620175014.a822a766e0f91f7b44f48fa0@canb.auug.org.au>
References: <20120620175014.a822a766e0f91f7b44f48fa0@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-next@vger.kernel.org, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel@vger.kernel.org, Alan Modra <amodra@bigpond.net.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-06-20 at 17:50 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the final tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> powerpc64-linux-ld: arch/powerpc/net/built-in.o: In function `bpf_slow_path_word':
> (.text+0x90): sibling call optimization to `skb_copy_bits' does not allow automatic multiple TOCs; recompile with -mminimal-toc or -fno-optimize-sibling-calls, or make `skb_copy_bits' extern


Those seem to be caused because we don't have a nop after the call,
meaning we can't patch the TOC pointer on the way back. Adding a nop
fixes those.

But, then I get 32,410 variants of this:

powerpc64-linux-ld: /src/next/net/openvswitch/vport-netdev.c:189:(.text+0x89b990): 
	sibling call optimization to `_restgpr0_28' does not allow automatic multiple TOCs;
	recompile with -mminimal-toc or -fno-optimize-sibling-calls, or make `_restgpr0_28' extern


And those are generated calls so I don't see how we can fix them.

> I started building with gcc 4.6.3/binutils 2.22 today.  gcc
> 4.6.0/binutils 2.21 do not produce this error, it produces this instead
> (which has been happening for a long time):
> 
> powerpc64-linux-ld: TOC section size exceeds 64k


So presumably there's some new error checking that we're hitting, I
imagine it was always broken, but now it's being more explicit.

I think we need some help from the toolchain experts, hi Alan :)

cheers
