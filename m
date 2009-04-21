Return-Path: <olof@lixom.net>
Date: Tue, 21 Apr 2009 14:33:19 -0500
From: Olof Johansson <olof@lixom.net>
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Subject: INET_LRO as tristate and use from modules (was: Re: [BUILD FAILURE
	08/12] Next April 21 : PPC64 randconfig
	[drivers/net/pasemi_mac_driver.ko])
Message-ID: <20090421193319.GB20237@lixom.net>
References: <1240339984.9110.141.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1240339984.9110.141.camel@subratamodak.linux.ibm.com>
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, themann@de.ibm.com,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	linux-next <linux-next@vger.kernel.org>, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 22, 2009 at 12:23:03AM +0530, Subrata Modak wrote:
> Reported this on 9th April earlier:
> http://lkml.org/lkml/2009/4/9/276,
> 
> I hope the following Patch will solve this problem as well:
> Geoff Levand <geoffrey.levand@am.sony.com> provided a patch on 17th
> April.
> http://lkml.org/lkml/2009/4/17/313,

No, that's a separate issue.

>   MODPOST 338 modules
> ERROR: ".lro_receive_skb" [drivers/net/pasemi_mac_driver.ko] undefined!
> ERROR: ".lro_flush_all" [drivers/net/pasemi_mac_driver.ko] undefined!
> WARNING: modpost: Found 1 section mismatch(es).
> To see full details build your kernel with:
> 'make CONFIG_DEBUG_SECTION_MISMATCH=y'
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2

This seems to be a problem with all tristate-capable drivers that use
LRO (and uses select INET_LRO in their Kconfig): INET_LRO is a tristate
and can thus be a module. Looks like it needs to be a bool instead?


-Olof
