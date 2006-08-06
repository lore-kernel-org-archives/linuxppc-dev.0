Return-Path: <hollis@alumni.cmu.edu>
Received: from fall-pradero.atl.sa.earthlink.net
	(fall-pradero.atl.sa.earthlink.net [207.69.195.104])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F0AB679E1
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Aug 2006 09:54:44 +1000 (EST)
Received: from pop-canoe.atl.sa.earthlink.net ([207.69.195.66])
	by fall-pradero.atl.sa.earthlink.net with esmtp (Exim 4.34)
	id 1G9sN8-0005a8-U7
	for linuxppc-dev@ozlabs.org; Sun, 06 Aug 2006 19:49:30 -0400
Subject: Re: [PATCH] pSeries hvsi char driver null pointer deref
From: Hollis Blanchard <hollis@alumni.cmu.edu>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20060803201300.GB10638@austin.ibm.com>
References: <20060803201300.GB10638@austin.ibm.com>
Content-Type: text/plain
Date: Sun, 06 Aug 2006 18:49:22 -0500
Message-Id: <1154908162.27074.2.camel@diesel>
Mime-Version: 1.0
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-03 at 15:13 -0500, Linas Vepstas wrote:
> Andrew, 
> Please apply.
> 
> Under certain rare circumstances, it appears that there can be
> be a NULL-pointer deref when a user fiddles with terminal
> emeulation programs while outpu is being sent to the console.
> This patch checks for and avoids a NULL-pointer deref.
> 
> Signed-off-by: Hollis Blanchard <hollisbl@austin.ibm.com>
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

That email address is incorrect.

Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>

> ----
>  drivers/char/hvsi.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6.18-rc3-git1/drivers/char/hvsi.c
> ===================================================================
> --- linux-2.6.18-rc3-git1.orig/drivers/char/hvsi.c	2006-08-03 14:50:00.000000000 -0500
> +++ linux-2.6.18-rc3-git1/drivers/char/hvsi.c	2006-08-03 14:51:46.000000000 -0500
> @@ -311,7 +311,8 @@ static void hvsi_recv_control(struct hvs
>  				/* CD went away; no more connection */
>  				pr_debug("hvsi%i: CD dropped\n", hp->index);
>  				hp->mctrl &= TIOCM_CD;
> -				if (!(hp->tty->flags & CLOCAL))
> +				/* If userland hasn't done an open(2) yet, hp->tty is NULL. */
> +				if (hp->tty && !(hp->tty->flags & CLOCAL))
>  					*to_hangup = hp->tty;
>  			}
>  			break;
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
