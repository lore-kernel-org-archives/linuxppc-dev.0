Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wGTSw0JrkzDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 May 2017 12:51:10 +1000 (AEST)
Date: Sun, 30 Apr 2017 22:50:56 -0400 (EDT)
Message-Id: <20170430.225056.522551868142970014.davem@davemloft.net>
To: swood@redhat.com
Cc: Yuval.Mintz@cavium.com, ariel.elior@cavium.com,
 everest-linux-l2@cavium.com, netdev@vger.kernel.org, edumazet@google.com,
 mschmidt@redhat.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net] bnx2x: Align RX buffers
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170429001741.14563-1-swood@redhat.com>
References: <20170429001741.14563-1-swood@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Scott Wood <swood@redhat.com>
Date: Fri, 28 Apr 2017 19:17:41 -0500

> The bnx2x driver is not providing proper alignment on the receive buffers it
> passes to build_skb(), causing skb_shared_info to be misaligned.
> skb_shared_info contains an atomic, and while PPC normally supports
> unaligned accesses, it does not support unaligned atomics.
> 
> Aligning the size of rx buffers will ensure that page_frag_alloc() returns
> aligned addresses.
> 
> This can be reproduced on PPC by setting the network MTU to 1450 (or other
> non-multiple-of-4) and then generating sufficient inbound network traffic
> (one or two large "wget"s usually does it), producing the following oops:
 ...
> Fixes: d46d132cc021 ("bnx2x: use netdev_alloc_frag()")
> Signed-off-by: Scott Wood <swood@redhat.com>

Applied, thanks.
