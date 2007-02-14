Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17874.22346.325748.342309@cargo.ozlabs.ibm.com>
Date: Wed, 14 Feb 2007 11:26:50 +1100
From: Paul Mackerras <paulus@samba.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 1/3] PS3: Vuart cleanups
In-Reply-To: <45C8FFEF.2080702@am.sony.com>
References: <45C8FFEF.2080702@am.sony.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand writes:

> Cleanups for the PS3 vuart driver.

You seem to have the whole patch + description in there twice...

> -int __init ps3_vuart_init(void)
> +int __init ps3_vuart_bus_init(void)
>  {
>  	int result;
>  
>  	pr_debug("%s:%d:\n", __func__, __LINE__);
> -	result = bus_register(&ps3_vuart);
> +	init_MUTEX(&vuart_bus_priv.probe_mutex);
> +	result = bus_register(&ps3_vuart_bus);
>  	BUG_ON(result);
>  	return result;
>  }

[snip]

> +core_initcall(ps3_vuart_bus_init);

Might be nice to check that you're actually on a PS3 before
registering the bus perhaps?

Paul.
