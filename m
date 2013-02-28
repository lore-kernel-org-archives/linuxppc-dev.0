Return-Path: <jirislaby@gmail.com>
Received: from mail-ee0-f50.google.com (mail-ee0-f50.google.com [74.125.83.50])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EBF4E2C0077
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2013 21:41:09 +1100 (EST)
Received: by mail-ee0-f50.google.com with SMTP id e51so1368286eek.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2013 02:41:05 -0800 (PST)
Sender: Jiri Slaby <jirislaby@gmail.com>
Message-ID: <512F343E.7010201@suse.cz>
Date: Thu, 28 Feb 2013 11:41:02 +0100
From: Jiri Slaby <jslaby@suse.cz>
MIME-Version: 1.0
To: Chen Gang <gang.chen@asianux.com>, wfp5p@virginia.edu, tklauser@distanz.ch
Subject: Re: [PATCH] drivers/tty/hvc: using strlcpy instead of strncpy
References: <512C2F5D.1080207@asianux.com>
In-Reply-To: <512C2F5D.1080207@asianux.com>
Content-Type: text/plain; charset=GB2312
Cc: Greg KH <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/26/2013 04:43 AM, Chen Gang wrote:
> 
>   when strlen pi->location_code is larger than HVCS_CLC_LENGTH + 1,
>     original implementation can not let hvcsd->p_location_code NUL terminated.
>   so need fix it (also can simplify the code)

It should never be larger because the +1 is exactly for NUL. But it is a
cleanup, so why not...

> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  drivers/tty/hvc/hvcs.c |    9 ++-------
>  1 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
> index 1956593..81e939e 100644
> --- a/drivers/tty/hvc/hvcs.c
> +++ b/drivers/tty/hvc/hvcs.c
> @@ -881,17 +881,12 @@ static struct vio_driver hvcs_vio_driver = {
>  /* Only called from hvcs_get_pi please */
>  static void hvcs_set_pi(struct hvcs_partner_info *pi, struct hvcs_struct *hvcsd)
>  {
> -	int clclength;
> -
>  	hvcsd->p_unit_address = pi->unit_address;
>  	hvcsd->p_partition_ID  = pi->partition_ID;
> -	clclength = strlen(&pi->location_code[0]);
> -	if (clclength > HVCS_CLC_LENGTH)
> -		clclength = HVCS_CLC_LENGTH;
>  
>  	/* copy the null-term char too */
> -	strncpy(&hvcsd->p_location_code[0],
> -			&pi->location_code[0], clclength + 1);
> +	strlcpy(&hvcsd->p_location_code[0],
> +			&pi->location_code[0], sizeof(hvcsd->p_location_code));
>  }
>  
>  /*
> 


-- 
js
suse labs
