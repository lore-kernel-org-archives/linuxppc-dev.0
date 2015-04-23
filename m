Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 3DA971A0C9F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2015 01:42:50 +1000 (AEST)
Date: Thu, 23 Apr 2015 11:42:45 -0400 (EDT)
Message-Id: <20150423.114245.1826557896621397900.davem@davemloft.net>
To: david@gibson.dropbear.id.au
Subject: Re: [PATCHv2] ibmveth: Fix off-by-one error in ibmveth_change_mtu()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1429764185-597-1-git-send-email-david@gibson.dropbear.id.au>
References: <1429764185-597-1-git-send-email-david@gibson.dropbear.id.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tlfalcon@linux.vnet.ibm.com, netdev@vger.kernel.org, anton@au1.ibm.com,
 linux-kernel@vger.kernel.org, michael@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 23 Apr 2015 14:43:05 +1000

> AFAIK the PAPR document which defines the virtual device interface used by
> the ibmveth driver doesn't specify a specific maximum MTU.  So, in the
> ibmveth driver, the maximum allowed MTU is determined by the maximum
> allocated buffer size of 64k (corresponding to one page in the common case)
> minus the per-buffer overhead IBMVETH_BUFF_OH (which has value 22 for 14
> bytes of ethernet header, plus 8 bytes for an opaque handle).
> 
> This suggests a maximum allowable MTU of 65514 bytes, but in fact the
> driver only permits a maximum MTU of 65513.  This is because there is a <
> instead of an <= in ibmveth_change_mtu(), which only permits an MTU which
> is strictly smaller than the buffer size, rather than allowing the buffer
> to be completely filled.
> 
> This patch fixes the buglet.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Acked-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>

Applied, thank you.
