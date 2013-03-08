Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D2C5B2C0368
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 14:46:22 +1100 (EST)
Message-ID: <1362714364.6977.4.camel@pasglop>
Subject: Re: [PATCH] drivers/tty/hvc: fixup original commit:
 9276dfd27897a0b29d8b5814f39a1f82f56b6b6b
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chen Gang <gang.chen@asianux.com>
Date: Fri, 08 Mar 2013 14:46:04 +1100
In-Reply-To: <51395D2C.6040007@asianux.com>
References: <512C2F5D.1080207@asianux.com> <512F343E.7010201@suse.cz>
 <512F3BC5.8020903@asianux.com> <512F3C60.9070409@asianux.com>
 <512F5FDC.3060000@suse.cz> <51355142.4070505@asianux.com>
 <5135BCAB.5040500@suse.cz> <51381352.9090803@asianux.com>
 <513818EC.9050504@asianux.com> <1362636305.3548.58.camel@pasglop>
 <51395D2C.6040007@asianux.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Greg KH <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 wfp5p@virginia.edu, tklauser@distanz.ch, Jiri Slaby <jslaby@suse.cz>,
 alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-03-08 at 11:38 +0800, Chen Gang wrote:
>   originally I did not notice src buf len and dest buf len are the same.
>     so origianlly, it is not a bug issue, it is only for beautify code.
>     and now, using strcpy is better.

Being the same len doesn't mean it's safe to use strcpy ... the source
might be missing the 0 terminator. In this specific case though, I
believe the source string comes was itself populated with strlcpy
(at least since your patch 6b6680c4ea3952af8ae76915cbca41245147741b) so
strcpy is indeed safe but using strlcpy doesn't hurt does it ?

Ben.

> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  drivers/tty/hvc/hvcs.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
> index 81e939e..9330a4b 100644
> --- a/drivers/tty/hvc/hvcs.c
> +++ b/drivers/tty/hvc/hvcs.c
> @@ -885,8 +885,7 @@ static void hvcs_set_pi(struct hvcs_partner_info
> *pi, struct hvcs_struct *hvcsd)
>  	hvcsd->p_partition_ID  = pi->partition_ID;
> 
>  	/* copy the null-term char too */
> -	strlcpy(&hvcsd->p_location_code[0],
> -			&pi->location_code[0], sizeof(hvcsd->p_location_code));
> +	strcpy(&hvcsd->p_location_code[0], &pi->location_code[0]);
>  }
> 
>  /*
