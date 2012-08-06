Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EF8D82C0080
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2012 13:16:27 +1000 (EST)
Message-ID: <501F35C2.6090005@windriver.com>
Date: Mon, 6 Aug 2012 11:10:58 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: <benh@kernel.crashing.org>, <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/1] booke/wdt: fix incorrect WDIOC_GETSUPPORT return path
References: <1343636122-23273-1-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1343636122-23273-1-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org, linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/30/2012 04:15 PM, Tiejun Chen wrote:
> We miss that correct WDIOC_GETSUPPORT return path when perform
> copy_to_user() properly.

Any comments?

Thanks
Tiejun

> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  drivers/watchdog/booke_wdt.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
> index 3fe82d0..2be7f29 100644
> --- a/drivers/watchdog/booke_wdt.c
> +++ b/drivers/watchdog/booke_wdt.c
> @@ -162,12 +162,13 @@ static long booke_wdt_ioctl(struct file *file,
>  				unsigned int cmd, unsigned long arg)
>  {
>  	u32 tmp = 0;
> -	u32 __user *p = (u32 __user *)arg;
> +	void __user *argp = (u32 __user *)arg;
> +	u32 __user *p = argp;
>  
>  	switch (cmd) {
>  	case WDIOC_GETSUPPORT:
> -		if (copy_to_user((void *)arg, &ident, sizeof(ident)))
> -			return -EFAULT;
> +		return copy_to_user(argp, &ident,
> +				sizeof(ident)) ? -EFAULT : 0;
>  	case WDIOC_GETSTATUS:
>  		return put_user(0, p);
>  	case WDIOC_GETBOOTSTATUS:
> 
