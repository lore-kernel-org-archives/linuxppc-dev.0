Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A8101A0271
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2015 04:50:19 +1000 (AEST)
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id D14F1140077
 for <linuxppc-dev@ozlabs.org>; Sun, 26 Apr 2015 04:50:18 +1000 (AEST)
Date: Sat, 25 Apr 2015 14:43:54 -0400 (EDT)
Message-Id: <20150425.144354.1149917806926276049.davem@davemloft.net>
To: mpe@ellerman.id.au
Subject: Re: [PATCH] ehea: Fix memory hook reference counting crashes
From: David Miller <davem@davemloft.net>
In-Reply-To: <1429854752-5698-1-git-send-email-mpe@ellerman.id.au>
References: <1429854752-5698-1-git-send-email-mpe@ellerman.id.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, anton@samba.org, cascardo@linux.vnet.ibm.com,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 24 Apr 2015 15:52:32 +1000

> The recent commit to only register the EHEA memory hotplug hooks on
> adapter probe has a few problems.
> 
> Firstly the reference counting is wrong for multiple adapters, in that
> the hooks are registered multiple times. Secondly the check in the tear
> down path is backward. Finally the error path doesn't decrement the
> count.
> 
> The multiple registration of the hooks is the biggest problem, as it
> leads to oopses when the system is rebooted, and/or errors during memory
> hotplug, eg:
 ...
> Fixes: aa183323312d ("ehea: Register memory hotplug, reboot and crash hooks on adapter probe")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied, but using an atomic counter for this is really inappropriate
and is what lead to this bug in the first place.

You're not counting anything, because if you were, then you would be
decrementing this thing somewhere.

Rather, it's purely a boolean state saying "I did X".  So it should be
a boolean, and no atomicity nor other special considerations are
needed for setting it to true.
