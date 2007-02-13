Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/16] More DCR native fixups
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070213061024.518A9DDD0D@ozlabs.org>
References: <20070213061024.518A9DDD0D@ozlabs.org>
Content-Type: text/plain
Date: Tue, 13 Feb 2007 17:22:00 +1100
Message-Id: <1171347720.20192.57.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-02-13 at 17:10 +1100, David Gibson wrote:
> Getting BenH's new EMAC driver working on 440GP, I found some more
> problems in the native mode paths of the new DCR code.  Here's a fix.
> 
> Signed-off-by: David Gibson <dwg@au1.ibm.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> 
>  include/asm-powerpc/dcr-native.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: working-2.6/include/asm-powerpc/dcr-native.h
> ===================================================================
> --- working-2.6.orig/include/asm-powerpc/dcr-native.h	2007-02-09 13:59:07.000000000 +1100
> +++ working-2.6/include/asm-powerpc/dcr-native.h	2007-02-09 13:59:36.000000000 +1100
> @@ -26,8 +26,8 @@ typedef struct {} dcr_host_t;
>  
>  #define DCR_MAP_OK(host)	(1)
>  
> -#define dcr_map(dev, dcr_n, dcr_c)	{}
> -#define dcr_unmap(host, dcr_n, dcr_c)	{}
> +#define dcr_map(dev, dcr_n, dcr_c)	((dcr_host_t){})
> +#define dcr_unmap(host, dcr_n, dcr_c)	do {} while (0)
>  #define dcr_read(host, dcr_n)		mfdcr(dcr_n)
>  #define dcr_write(host, dcr_n, value)	mtdcr(dcr_n, value)
>  
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
