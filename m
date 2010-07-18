Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 08BA7B6F06
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jul 2010 07:51:05 +1000 (EST)
Date: Sun, 18 Jul 2010 14:51:20 -0700 (PDT)
Message-Id: <20100718.145120.35845833.davem@davemloft.net>
To: eric.dumazet@gmail.com
Subject: Re: Badness with the kernel version 2.6.35-rc1-git1 running on P6 box
From: David Miller <davem@davemloft.net>
In-Reply-To: <1279282842.2549.16.camel@edumazet-laptop>
References: <4C401D56.3070108@linux.vnet.ibm.com>
	<1279274185.2549.14.camel@edumazet-laptop>
	<1279282842.2549.16.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Cc: sachinp@linux.vnet.ibm.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	ossthema@de.ibm.com, dipraksh@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Fri, 16 Jul 2010 14:20:42 +0200

> Le vendredi 16 juillet 2010 =E0 11:56 +0200, Eric Dumazet a =E9crit :=

> =

>> [PATCH] ehea: ehea_get_stats() should use GFP_KERNEL
>> =

>> ehea_get_stats() is called in process context and should use GFP_KER=
NEL
>> allocation instead of GFP_ATOMIC.
>> =

>> Clearing stats at beginning of ehea_get_stats() is racy in case of
>> concurrent stat readers.
>> =

>> get_stats() can also use netdev net_device_stats, instead of a priva=
te
>> copy.
>> =

>> Reported-by: divya <dipraksh@linux.vnet.ibm.com>
>> Signed-off-by: Eric Dumazet <eric.dumazet@gmail.com>
>> ---
>>  drivers/net/ehea/ehea.h      |    1 -
>>  drivers/net/ehea/ehea_main.c |    6 ++----
>>  2 files changed, 2 insertions(+), 5 deletions(-)
>> =

>> =

> =

> Hmm, net-next-2.6 contains following patch :

If people think ehea usage is ubiquitous enough to deserve a backport
of this to net-2.6, fine.  But personally I don't think it's worth it.

Can someone close the kernel bugzilla 16406 created for this bug?  This=

patch we have already obviously would fix this issue.
