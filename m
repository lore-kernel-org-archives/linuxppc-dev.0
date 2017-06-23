Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wvMYL22byzDqjL
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jun 2017 01:19:01 +1000 (AEST)
Date: Fri, 23 Jun 2017 11:18:58 -0400 (EDT)
Message-Id: <20170623.111858.1724599210974760106.davem@davemloft.net>
To: pabeni@redhat.com
Cc: netdev@vger.kernel.org, hannes@stressinduktion.org,
 edumazet@google.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next] udp: fix poll()
From: David Miller <davem@davemloft.net>
In-Reply-To: <00735477ae8ffcc075e382ab45f6568ab158a0bf.1498220186.git.pabeni@redhat.com>
References: <00735477ae8ffcc075e382ab45f6568ab158a0bf.1498220186.git.pabeni@redhat.com>
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

From: Paolo Abeni <pabeni@redhat.com>
Date: Fri, 23 Jun 2017 14:19:51 +0200

> Michael reported an UDP breakage caused by the commit b65ac44674dd
> ("udp: try to avoid 2 cache miss on dequeue").
> The function __first_packet_length() can update the checksum bits
> of the pending skb, making the scratched area out-of-sync, and
> setting skb->csum, if the skb was previously in need of checksum
> validation.
> 
> On later recvmsg() for such skb, checksum validation will be
> invoked again - due to the wrong udp_skb_csum_unnecessary()
> value - and will fail, causing the valid skb to be dropped.
> 
> This change addresses the issue refreshing the scratch area in
> __first_packet_length() after the possible checksum update.
> 
> Fixes: b65ac44674dd ("udp: try to avoid 2 cache miss on dequeue")
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Hannes Frederic Sowa <hannes@stressinduktion.org>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thanks for fixing this so quickly, applied.
