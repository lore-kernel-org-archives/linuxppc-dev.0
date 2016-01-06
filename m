Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 203C21A118D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jan 2016 16:44:51 +1100 (AEDT)
Date: Wed, 06 Jan 2016 00:44:42 -0500 (EST)
Message-Id: <20160106.004442.109655096478479740.davem@davemloft.net>
To: rabin@rab.in
Cc: netdev@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: filter: make JITs zero A for SKF_AD_ALU_XOR_X
From: David Miller <davem@davemloft.net>
In-Reply-To: <1452007387-626-1-git-send-email-rabin@rab.in>
References: <1452007387-626-1-git-send-email-rabin@rab.in>
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

From: Rabin Vincent <rabin@rab.in>
Date: Tue,  5 Jan 2016 16:23:07 +0100

> The SKF_AD_ALU_XOR_X ancillary is not like the other ancillary data
> instructions since it XORs A with X while all the others replace A with
> some loaded value.  All the BPF JITs fail to clear A if this is used as
> the first instruction in a filter.  This was found using american fuzzy
> lop.
> 
> Add a helper to determine if A needs to be cleared given the first
> instruction in a filter, and use this in the JITs.  Except for ARM, the
> rest have only been compile-tested.
> 
> Fixes: 3480593131e0 ("net: filter: get rid of BPF_S_* enum")
> Signed-off-by: Rabin Vincent <rabin@rab.in>

Applied and queued up for -stable, thanks!
