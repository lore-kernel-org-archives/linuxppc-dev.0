Return-Path: <benh@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3FE011A0B55
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 08:28:27 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Fri, 13 Feb 2015 07:28:25 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7FC712CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 08:28:22 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1CLSD5c44433572
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 08:28:22 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1CLRm9Q001505
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 08:27:48 +1100
Message-ID: <1423776439.5965.65.camel@au1.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Check image loaded or not before
 calling flash
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Fri, 13 Feb 2015 08:27:19 +1100
In-Reply-To: <20150212095323.1829.45732.stgit@localhost.localdomain>
References: <20150212095323.1829.45732.stgit@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-02-12 at 15:23 +0530, Vasant Hegde wrote:
> Present code checks for update_flash_data in opal_flash_term_callback().
> update_flash_data has been statically initialized to zero, and that
> is the value of FLASH_IMG_READY. Also code update initialization happens
> during subsys init.

Please statically initialize it to a sane value instead.

> So if reboot is issued before the subsys init stage then we endup displaying
> "Flashing new firmware" message.. which may confuse end user.
> 
> This patch adds additional validation to make sure image is actually loaded
> or not.
> 
> Reported-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/opal-flash.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal-flash.c b/arch/powerpc/platforms/powernv/opal-flash.c
> index 5c21d9c..5455cd4 100644
> --- a/arch/powerpc/platforms/powernv/opal-flash.c
> +++ b/arch/powerpc/platforms/powernv/opal-flash.c
> @@ -319,7 +319,8 @@ void opal_flash_term_callback(void)
>  {
>  	struct cpumask mask;
>  
> -	if (update_flash_data.status != FLASH_IMG_READY)
> +	if (update_flash_data.status != FLASH_IMG_READY ||
> +	    image_data.status != IMAGE_READY)
>  		return;
>  
>  	pr_alert("FLASH: Flashing new firmware\n");
