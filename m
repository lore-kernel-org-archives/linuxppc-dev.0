Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id F2216DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 01:30:55 +1100 (EST)
Message-ID: <45F9588C.7020108@ru.mvista.com>
Date: Thu, 15 Mar 2007 17:30:36 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCH] BLK_DEV_IDE_CELLEB dependency fix
References: <200703150628.l2F6SPa3028035@toshiba.co.jp>
In-Reply-To: <200703150628.l2F6SPa3028035@toshiba.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, bzolnier@gmail.com,
	Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Akira Iguchi wrote:

> It's bool and it depends on BLK_DEV_IDE
>  => should depend on BLK_DEV_IDE=y

    Hm, why I'm seeing module_init() in the driver? :-)

> And move it to "if BLK_DEV_IDEDMA_PCI" block because it depends on 
> BLK_DEV_IDEDMA_PCI.

    IMHO, that driver shouldn't be in drivers/ide/ppc/ then...  Why it got 
there (the same question about PowerMac driver)?

> diff -Nrpu -X linux-2.6.21-rc3/Documentation/dontdiff linux-2.6.21-rc3/drivers/ide/Kconfig linux-2.6.21-rc3.mod/drivers/ide/Kconfig
> --- linux-2.6.21-rc3/drivers/ide/Kconfig	2007-03-07 13:41:20.000000000 +0900
> +++ linux-2.6.21-rc3.mod/drivers/ide/Kconfig	2007-03-15 23:49:33.000000000 +0900
> @@ -769,6 +769,14 @@ config BLK_DEV_TC86C001
>  	help
>  	This driver adds support for Toshiba TC86C001 GOKU-S chip.
>  
> +config BLK_DEV_IDE_CELLEB
> +	bool "Toshiba's Cell Reference Set IDE support"
> +	depends on PPC_CELLEB && BLK_DEV_IDE=y
> +	help
> +	  This driver provides support for the built-in IDE controller on
> +	  Toshiba Cell Reference Board.
> +	  If unsure, say Y.
> +
>  endif
>  
>  config BLK_DEV_IDE_PMAC
> @@ -800,14 +808,6 @@ config BLK_DEV_IDEDMA_PMAC
>  	  to transfer data to and from memory.  Saying Y is safe and improves
>  	  performance.
>  
> -config BLK_DEV_IDE_CELLEB
> -	bool "Toshiba's Cell Reference Set IDE support"
> -	depends on PPC_CELLEB
> -	help
> -	  This driver provides support for the built-in IDE controller on
> -	  Toshiba Cell Reference Board.
> -	  If unsure, say Y.
> -
>  config BLK_DEV_IDE_SWARM
>  	tristate "IDE for Sibyte evaluation boards"
>  	depends on SIBYTE_SB1xxx_SOC

MBR, Sergei
