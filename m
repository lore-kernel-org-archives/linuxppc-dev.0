Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id C4DE12C008E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 May 2013 17:36:55 +1000 (EST)
Date: Wed, 01 May 2013 03:36:50 -0400 (EDT)
Message-Id: <20130501.033650.703182794549888825.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH net-next] af_unix: fix a fatal race with bit fields
From: David Miller <davem@davemloft.net>
In-Reply-To: <1367372393.22115.6.camel@pasglop>
References: <1367370761.11020.22.camel@edumazet-glaptop>
 <1367372393.22115.6.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 ambrose@google.com, eric.dumazet@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 01 May 2013 11:39:53 +1000

> I'm not even completely certain bytes are safe to be honest, though
> probably more than bitfields. I'll poke our compiler people.

Older Alpha only has 32-bit and 64-bit loads and stores, so byte sized
accesses are not atomic, and therefore use racey read-modify-write
sequences.
