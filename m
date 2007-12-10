Return-Path: <scottwood@freescale.com>
Date: Mon, 10 Dec 2007 11:32:17 -0600
From: Scott Wood <scottwood@freescale.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/3] Use embedded libfdt in the bootwrapper
Message-ID: <20071210173217.GB4497@loki.buserror.net>
References: <20071210032343.GB29611@localhost.localdomain>
	<20071210032839.71412DDDFA@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071210032839.71412DDDFA@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 10, 2007 at 02:28:39PM +1100, David Gibson wrote:
> +#define check_err(err) \
> +	({ \
> +		if (BAD_ERROR(err) || ((err < 0) && DEBUG)) \
> +			printf("%s():%d  %s\n\r", __FUNCTION__, __LINE__, \
> +			       fdt_strerror(err)); \
> +		if (BAD_ERROR(err)) \
> +			exit(); \
> +		(err < 0) ? -1 : 0; \
> +	})
> +
> +#define offset_devp(off)	\
> +	({ \
> +		int offset = (off); \
> +		check_err(offset) ? NULL : (void *)(offset+1); \
> +	})
> +
> +#define devp_offset(devp)	(((int)(devp))-1)

How does using offsets as devps work if a devp was previously acquired to a
node that has to be moved due to a change later made in an earlier part of
the tree?

-Scott
