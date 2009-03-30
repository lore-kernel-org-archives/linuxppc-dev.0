Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0746DDDE1D
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 07:37:52 +1100 (EST)
Date: Mon, 30 Mar 2009 13:35:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] hvc_console: prevent wrapping in hvc_console_print()
Message-Id: <20090330133531.f5d99c09.akpm@linux-foundation.org>
In-Reply-To: <49BF956B.9030109@gmail.com>
References: <49BF956B.9030109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 17 Mar 2009 13:19:55 +0100
Roel Kluin <roel.kluin@gmail.com> wrote:

> This was found by code analysis, is it needed?
> ------------------------------>8-------------8<---------------------------------
> If we subtract too much on unsigned i it wraps.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
> index 94e7e3c..d06313c 100644
> --- a/drivers/char/hvc_console.c
> +++ b/drivers/char/hvc_console.c
> @@ -161,10 +161,10 @@ static void hvc_console_print(struct console *co, const char *b,
>  			}
>  		} else {
>  			r = cons_ops[index]->put_chars(vtermnos[index], c, i);
> -			if (r <= 0) {
> +			if (r <= 0 || r > i) {
>  				/* throw away chars on error */
>  				i = 0;
> -			} else if (r > 0) {
> +			} else {
>  				i -= r;
>  				if (i > 0)
>  					memmove(c, c+r, i);

I expect that ->put_chars() will either return a -ve errno or will
return the number of chars which were written, which will be less than
or equal to `i'.

Or maybe I miss your point.

Guys, could we have a MAINTAINERS entry for this driver please?
