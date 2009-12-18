Return-Path: <randy.dunlap@oracle.com>
Received: from acsinet14.oracle.com (acsinet14.oracle.com [141.146.126.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "acsinet14.oracle.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 09384B6F0C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 19 Dec 2009 03:56:09 +1100 (EST)
Received: from acsinet12.oracle.com (acsinet12.oracle.com [141.146.126.234])
	by acsinet14.oracle.com (Sentrion-MP-4.0.0/Sentrion-MP-4.0.0) with
	ESMTP id nBIGu6YF028114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2009 16:56:06 GMT
Date: Fri, 18 Dec 2009 08:55:47 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ps3_gelic_wireless: Fix build failure due to missing
	WEXT_PRIV
Message-Id: <20091218085547.fb8bdaf5.randy.dunlap@oracle.com>
In-Reply-To: <1261115574.2173.18.camel@pasglop>
References: <1261115574.2173.18.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-wireless@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 18 Dec 2009 16:52:54 +1100 Benjamin Herrenschmidt wrote:

> The option to support the old style PSK interface in the PS3
> GELIC wireless drivers requires CONFIG_WEXT_PRIV to be set
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> Please send to Linus asap (or I can put it in powerpc.git) as it's
> breaking one of my test build configs :-)
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index e58a653..c0ecc77 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -2358,6 +2358,7 @@ config GELIC_WIRELESS
>  config GELIC_WIRELESS_OLD_PSK_INTERFACE
>         bool "PS3 Wireless private PSK interface (OBSOLETE)"
>         depends on GELIC_WIRELESS
> +       select WEXT_PRIV
>         help
>            This option retains the obsolete private interface to pass
>            the PSK from user space programs to the driver.  The PSK

Probably also needs
	depends on WLAN
to prevent build failures.

---
~Randy
