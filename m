Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 64C962C032E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Mar 2014 08:27:42 +1100 (EST)
Date: Thu, 06 Mar 2014 16:27:37 -0500 (EST)
Message-Id: <20140306.162737.1605594893806967606.davem@davemloft.net>
To: anton@samba.org
Subject: Re: ibmveth: Fix endian issues with MAC addresses
From: David Miller <davem@davemloft.net>
In-Reply-To: <20140305145137.3460dbe7@kryten>
References: <1387810329.22671.66.camel@joe-AO722>
 <20131224125529.58970f1b@kryten> <20140305145137.3460dbe7@kryten>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, dvaleev@suse.com, agraf@suse.de,
 netdev@vger.kernel.org, joe@perches.com, santil@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>
Date: Wed, 5 Mar 2014 14:51:37 +1100

> The code to load a MAC address into a u64 for passing to the
> hypervisor via a register is broken on little endian.
> 
> Create a helper function called ibmveth_encode_mac_addr
> which does the right thing in both big and little endian.
> 
> We were storing the MAC address in a long in struct ibmveth_adapter.
> It's never used so remove it - we don't need another place in the
> driver where we create endian issues with MAC addresses.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Cc: stable@vger.kernel.org

Applied, thanks Anton.

> -	memcpy(&adapter->mac_addr, mac_addr_p, ETH_ALEN);
 ...
> -    unsigned long mac_addr;

That's some scary stuff right there.
