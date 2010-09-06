Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 672C1B6EF2
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Sep 2010 06:22:07 +1000 (EST)
Date: Mon, 06 Sep 2010 13:22:23 -0700 (PDT)
Message-Id: <20100906.132223.48506151.davem@davemloft.net>
To: liang.li@windriver.com
Subject: Re: [v2 PATCH] ucc_geth: fix ethtool set ring param bug
From: David Miller <davem@davemloft.net>
In-Reply-To: <1283443364-2136-1-git-send-email-liang.li@windriver.com>
References: <1283305429-8426-1-git-send-email-liang.li@windriver.com>
	<1283443364-2136-1-git-send-email-liang.li@windriver.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, avorontsov@ru.mvista.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Liang Li <liang.li@windriver.com>
Date: Fri,  3 Sep 2010 00:02:44 +0800

> +		printk(KERN_INFO "Stopping interface %s.\n", netdev->name);
 ...
> +		printk(KERN_INFO "Reactivating interface %s.\n", netdev->name);

Please get rid of these log messages.

Also, this isn't the way to implement this.

Abstract out the one and only operation that can fail when you change
the ring size, which is the memory allocations, into seperate code.

Allocate the newly sized rings first, and if that fails abort the
ring size change attempt.  This will let the device continue to
function and operate properly even if the ring resizing fails.

Then stop the RX/TX DMA, switch the ring pointers and configuration
inside of the device, restart RX/TX DMA, and finally free up the
old ring memory.

I know why you want to use *_close() and *_open(), it requires less
coding and work on your part.  But this is why the error handling
behavior is difficult and what happens on failure (device goes down
and becomes inoperative) is extremely unpleasant for the user.

The user should be able to make this kind of change over an SSH
shell that uses the interface itself, and not expect to lose
connectivity completely just because the ring allocation fails.

Thanks.
