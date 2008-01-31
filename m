Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E72A5DDE44
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 15:31:15 +1100 (EST)
Message-Id: <B4093288-C5F4-472D-BA13-EA83C616A0D6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080121204953.GA11384@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [NET] cpmac: convert to new Fixed PHY infrastructure
	(was: Re: fixed phy support (warning related to FIXED_MII_100_FDX))
Date: Wed, 30 Jan 2008 22:30:38 -0600
References: <416B8C5D-109C-4C03-807D-7EBB0AA9C366@kernel.crashing.org>
	<20080121204953.GA11384@localhost.localdomain>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Eugene Konev <ejka@imfi.kspu.ru>, Jeff Garzik <jeff@garzik.org>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> From: Anton Vorontsov <avorontsov@ru.mvista.com>
> Subject: [PATCH] [NET] cpmac: convert to new Fixed PHY infrastructure
>
> This patch converts cpmac to the new Fixed PHY infrastructure,  
> though it
> doesn't fix all the problems with that driver. I didn't even bother to
> test this patch to compile, because cpmac driver is broken in  
> several ways:
>
> 1. This driver won't compile by itself because lack of its header  
> describing
>   platform data;
> 2. It assumes that fixed PHYs should be created by the ethernet  
> driver.
>   It is wrong assumption: fixed PHYs creation is platform code  
> authority,
>   driver must blindly accept bus_id and phy_id platform data variables
>   instead.
>
> Also, it seem that that driver doesn't have actual in-tree users, so
> nothing to fix further.
>
> The main purpose of that patch is to get rid of the following Kconfig
> warning:
>
> scripts/kconfig/conf -s arch/powerpc/Kconfig
> drivers/net/Kconfig:1713:warning: 'select' used by config symbol
> 'CPMAC' refers to undefined symbol 'FIXED_MII_100_FDX'
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> drivers/net/Kconfig |    4 +--
> drivers/net/cpmac.c |   55 +++++++++++++++ 
> +----------------------------------
> 2 files changed, 19 insertions(+), 40 deletions(-)

applied.

- k
