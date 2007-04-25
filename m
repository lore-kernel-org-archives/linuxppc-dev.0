Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17966.41335.429268.945199@cargo.ozlabs.ibm.com>
Date: Wed, 25 Apr 2007 10:31:51 +1000
From: Paul Mackerras <paulus@samba.org>
To: Christian Krafft <krafft@de.ibm.com>
Subject: Re: [PATCH] powerpc: uninline of_iomap function
In-Reply-To: <20070424173202.15e5ce42@localhost>
References: <20070423193538.576702568@arndb.de>
	<20070423193913.119032752@arndb.de>
	<1177378533.14873.48.camel@localhost.localdomain>
	<20070424173202.15e5ce42@localhost>
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christian Krafft writes:

> @@ -1042,3 +1042,15 @@ const void *of_get_mac_address(struct de
>  }
>  EXPORT_SYMBOL(of_get_mac_address);
>  
> +void __iomem *of_iomap(struct device_node *np, int index)
> +{
> +	struct resource res;
> 
> +	if (of_address_to_resource(np, index, &res))
> +		return NULL;
> 
> +	return ioremap(res.start, 1 + res.end - res.start);
> +}
> +EXPORT_SYMBOL(of_iomap);

Looks like your mailer mangled the patch - could you resend it with a
different mailer or with different settings of your mailer?

Paul.
