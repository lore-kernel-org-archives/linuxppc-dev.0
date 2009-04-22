Return-Path: <davem@davemloft.net>
Date: Wed, 22 Apr 2009 02:12:18 -0700 (PDT)
Message-Id: <20090422.021218.92737677.davem@davemloft.net>
To: olof@lixom.net
Subject: Re: INET_LRO as tristate and use from modules
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090421193319.GB20237@lixom.net>
References: <1240339984.9110.141.camel@subratamodak.linux.ibm.com>
	<20090421193319.GB20237@lixom.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sachinp@linux.vnet.ibm.com, sfr@canb.auug.org.au, themann@de.ibm.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	subrata@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Olof Johansson <olof@lixom.net>
Date: Tue, 21 Apr 2009 14:33:19 -0500

> On Wed, Apr 22, 2009 at 12:23:03AM +0530, Subrata Modak wrote:
>>   MODPOST 338 modules
>> ERROR: ".lro_receive_skb" [drivers/net/pasemi_mac_driver.ko] undefined!
>> ERROR: ".lro_flush_all" [drivers/net/pasemi_mac_driver.ko] undefined!
>> WARNING: modpost: Found 1 section mismatch(es).
>> To see full details build your kernel with:
>> 'make CONFIG_DEBUG_SECTION_MISMATCH=y'
>> make[1]: *** [__modpost] Error 1
>> make: *** [modules] Error 2
> 
> This seems to be a problem with all tristate-capable drivers that use
> LRO (and uses select INET_LRO in their Kconfig): INET_LRO is a tristate
> and can thus be a module. Looks like it needs to be a bool instead?

Yes, making this a bool would be the easiest fix.

By why don't we get the same problem for PHYLIB?  It's also
tristate and "select"'d by a whole slew of networking drivers.
