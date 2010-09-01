Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id E00AAB7183
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Sep 2010 01:27:13 +1000 (EST)
Date: Wed, 01 Sep 2010 08:27:29 -0700 (PDT)
Message-Id: <20100901.082729.135524471.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: ERR_PTR pattern in phylib
From: David Miller <davem@davemloft.net>
In-Reply-To: <AANLkTimjVZTNeLdm4qptU1MqREODLASdGGanUyxqxfub@mail.gmail.com>
References: <AANLkTimjVZTNeLdm4qptU1MqREODLASdGGanUyxqxfub@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, afleming@freescale.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 1 Sep 2010 08:42:49 -0600

> It seems to me that phylib is one of the cases where the users (the
> network drivers) don't actually care about the specific error code
> when calling phylib functions.  The drivers only seem to care whether
> or not the function failed, and if it did then bail out.  I've also
> noticed that using the "if (!ptr)" test on phylib return values is a
> common error for driver writers.
> 
> In the interest of making driver code easier to write and review,
> would you be opposed to a set of patches to remove the ERR_PTR()
> pattern from phylib and its users?

I'm opposed to it because it means that if code actually does
care about the error code it will no longer be able to obtain
it.

Please don't make this change, thanks.
