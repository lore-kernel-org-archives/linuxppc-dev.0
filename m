Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3v87bJ2vgZzDq6Q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 15:04:26 +1100 (AEDT)
Date: Wed, 25 Jan 2017 23:04:13 -0500 (EST)
Message-Id: <20170125.230413.830821835017116629.davem@davemloft.net>
To: tlfalcon@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 wvoigt@us.ibm.com, nfont@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com
Subject: Re: [PATCH net 1/5] ibmvnic: harden interrupt handler
From: David Miller <davem@davemloft.net>
In-Reply-To: <1485378143-5084-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1485378143-5084-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
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

From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date: Wed, 25 Jan 2017 15:02:19 -0600

> Move most interrupt handler processing into a tasklet, and
> introduce a delay after re-enabling interrupts to fix timing
> issues encountered in hardware testing.
> 
> Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>

I don't think you have any idea what the real problem is.  This looks
like a hack, at best.  Next patch you'll increase the delay to "20",
right?  And if that doesn't work you'll try "40".

Or if you do know the reason, you need to explain it in detail in this
commit message so that we can properly evaluate this patch.

Furthermore, if you're going to move all of your packet processing
into software interrupt context, you might as well use NAPI polling
which is a purposefully built piece of infrastructure for doing
exactly this.
