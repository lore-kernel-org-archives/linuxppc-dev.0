Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6FB61DDE1D
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 13:44:03 +1000 (EST)
Date: Wed, 9 May 2007 22:39:36 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Mark prop unused in early_init_dt_scan_chosen().
In-Reply-To: <20070508171451.GA8893@ld0162-tx32.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0705092238390.29512@localhost.localdomain>
References: <20070508171451.GA8893@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 8 May 2007, Scott Wood wrote:

> The prop variable is only referenced when initrd support is
> turned on.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/kernel/prom.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index caef555..6705459 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -720,7 +720,7 @@ static int __init early_init_dt_scan_chosen(unsigned long node,
>  					    const char *uname, int depth, void *data)
>  {
>  	unsigned long *lprop;
> -	u32 *prop;
> +	u32 __attribute__((unused)) *prop;

is this the desired way to remove warnings related to CONFIG_ options?  I
know in the past we'd wrap it with a #ifdef CONFIG_FOO

>  	unsigned long l;
>  	char *p;
>
>

- k
