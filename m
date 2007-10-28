Return-Path: <buytenh@wantstofly.org>
Received: from xi.wantstofly.org (alephnull.demon.nl [83.160.184.112])
	by ozlabs.org (Postfix) with ESMTP id 52DA5DDF93
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 10:00:34 +1100 (EST)
Date: Sun, 28 Oct 2007 23:43:34 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] fix breakage in pegasos_eth (fallout from commit
	b45d9147f1582333e180e1023624c003874b7312)
Message-ID: <20071028224334.GA11480@xi.wantstofly.org>
References: <20071027200232.GS8181@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071027200232.GS8181@ftp.linux.org.uk>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Oct 27, 2007 at 09:02:32PM +0100, Al Viro wrote:

> diff --git a/include/linux/mv643xx_eth.h b/include/linux/mv643xx_eth.h
> index 3f27239..8df230a 100644
> --- a/include/linux/mv643xx_eth.h
> +++ b/include/linux/mv643xx_eth.h
> @@ -8,6 +8,9 @@
>  #define MV643XX_ETH_NAME		"mv643xx_eth"
>  #define MV643XX_ETH_SHARED_REGS		0x2000
>  #define MV643XX_ETH_SHARED_REGS_SIZE	0x2000
> +#define MV643XX_ETH_BAR_4	0x220
> +#define MV643XX_ETH_SIZE_REG_4	0x224
> +#define MV643XX_ETH_BASE_ADDR_ENABLE_REG	0x0290

Ideally, pegasos_eth shouldn't be poking around in mv643xx_eth
registers directly (but I'll put that on the TODO list to try
and fix later.)
