Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8811FDDDF7
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 16:21:48 +1000 (EST)
Subject: Re: [PATCH] xmon consistency clean up
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200707250257.l6P2va65006958@toshiba.co.jp>
References: <200707250257.l6P2va65006958@toshiba.co.jp>
Content-Type: text/plain
Date: Wed, 25 Jul 2007 16:21:38 +1000
Message-Id: <1185344499.5439.307.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-07-25 at 11:57 +0900, Ishizaki Kou wrote:
> This patch cleans up xmon to keep consistency.
> 
> In xmon, we should use console I/O functions that are named the same
> as user space stdio functions. But commit
> 4d404edce30f911004850d472e05a31efd751662 broke this consistency.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> ---
> 
> Index: linux-powerpc-git/arch/powerpc/xmon/nonstdio.c
> ===================================================================
> --- linux-powerpc-git.orig/arch/powerpc/xmon/nonstdio.c
> +++ linux-powerpc-git/arch/powerpc/xmon/nonstdio.c
> @@ -133,7 +133,7 @@ void xmon_printf(const char *format, ...
>         xmon_write(xmon_outbuf, n);
>  }
>  
> -void xmon_puts(const char *str)
> +void xmon_fputs(const char *str)
>  {
>         xmon_write(str, strlen(str)); 

Nah, keep it xmon_puts, since it doesn't take a stream argument and
define a "puts" for use by xmon core.

Ben.
