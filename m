Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KKVq74bDzDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 16:03:47 +1000 (AEST)
Message-ID: <1523253820.11062.11.camel@kernel.crashing.org>
Subject: Re: [PATCH 6/6] drivers/tty/hvc: remove unexplained "just in case"
 spin delay
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 09 Apr 2018 16:03:40 +1000
In-Reply-To: <20180409054056.27292-7-npiggin@gmail.com>
References: <20180409054056.27292-1-npiggin@gmail.com>
 <20180409054056.27292-7-npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-04-09 at 15:40 +1000, Nicholas Piggin wrote:
> This delay was in the very first OPAL console commit 6.5 years ago.
> The firmware console has hardened sufficiently to remove it.
> 

Reviewed-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  drivers/tty/hvc/hvc_opal.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
> index e151cfacf2a7..436b98258e60 100644
> --- a/drivers/tty/hvc/hvc_opal.c
> +++ b/drivers/tty/hvc/hvc_opal.c
> @@ -307,14 +307,8 @@ static int udbg_opal_getc(void)
>  	int ch;
>  	for (;;) {
>  		ch = udbg_opal_getc_poll();
> -		if (ch == -1) {
> -			/* This shouldn't be needed...but... */
> -			volatile unsigned long delay;
> -			for (delay=0; delay < 2000000; delay++)
> -				;
> -		} else {
> +		if (ch != -1)
>  			return ch;
> -		}
>  	}
>  }
>  
