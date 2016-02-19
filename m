Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD2A81A0567
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 19:15:11 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Rashmica Gupta <rashmicy@gmail.com>
Subject: Re: [PATCH] powerpc/Kconfig: Update config option based on page size.
Date: Fri, 19 Feb 2016 09:15:03 +0100
Message-ID: <2451756.DtDnCdR5cv@wuerfel>
In-Reply-To: <1455846943-32147-1-git-send-email-rashmicy@gmail.com>
References: <1455846943-32147-1-git-send-email-rashmicy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 19 February 2016 12:55:43 Rashmica Gupta wrote:
> 
>  config FORCE_MAX_ZONEORDER
>         int "Maximum zone order"
> -       range 9 64 if PPC64 && PPC_64K_PAGES
> +       range 9 9 if PPC64 && PPC_64K_PAGES
>         default "9" if PPC64 && PPC_64K_PAGES
>         range 13 64 if PPC64 && !PPC_64K_PAGES
>         default "13" if PPC64 && !PPC_64K_PAGES
> 

You can also use

	int "Maximum zone order" if !PPC_64K_PAGES

which will hide the option in the case where no configuration is possible.

	Arnd
