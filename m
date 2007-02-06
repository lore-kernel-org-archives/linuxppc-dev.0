Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id E8342DDE47
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 12:23:15 +1100 (EST)
Date: Mon, 5 Feb 2007 19:30:51 -0600
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] Update udbg_progress() to display the integer
Message-ID: <20070206013051.GA15525@lixom.net>
References: <11707051151024-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11707051151024-git-send-email-timur@freescale.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 05, 2007 at 01:51:55PM -0600, Timur Tabi wrote:
> Although udbg_progress() takes a string and a short as parameters, only
> the string is displayed.  This patch also displays the integer, if it's not
> equal to 0xFFFF.  This gives callers the option to display only the string.

Some platforms do this already, but they output the numbers first. It's
a good idea to stay consistent with that.

See maple_progress, ps3_progress and friends for templates. They're
quite verbose though.


-Olof


> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  arch/powerpc/kernel/udbg.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
> index 5730906..c474961 100644
> --- a/arch/powerpc/kernel/udbg.c
> +++ b/arch/powerpc/kernel/udbg.c
> @@ -121,6 +121,11 @@ void udbg_printf(const char *fmt, ...)
>  void __init udbg_progress(char *s, unsigned short hex)
>  {
>  	udbg_puts(s);
> +	if (hex != 0xffff) {
> +		char buf[8];
> +		sprintf(buf, " : %04X", hex);
> +		udbg_puts(buf);
> +	}
>  	udbg_puts("\n");
>  }
>  
> -- 
> 1.4.4
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
