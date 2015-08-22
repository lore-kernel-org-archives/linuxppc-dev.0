Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ADEB51A027F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Aug 2015 14:06:39 +1000 (AEST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0BBDF1402A6
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Aug 2015 14:06:38 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Sat, 22 Aug 2015 09:36:36 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 1E205125805C
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Aug 2015 09:35:55 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7M46XXe55771234
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Aug 2015 09:36:33 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7M46Wt7016144
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Aug 2015 09:36:33 +0530
Message-ID: <55D7F547.2090607@linux.vnet.ibm.com>
Date: Sat, 22 Aug 2015 09:36:31 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
CC: Stephen Rothwell <sfr@canb.auug.org.au>, khandual@linux.vnet.ibm.com,
 stewart@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/powernv: Fix mis-merge of OPAL support for LEDS
 driver
References: <1440200525-22360-1-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1440200525-22360-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/22/2015 05:12 AM, Michael Ellerman wrote:
> When I merged the OPAL support for the powernv LEDS driver I missed a
> hunk.
> 
> This is slightly modified from the original patch, as the original added
> code to opal-api.h which is not in the skiboot version, which is
> discouraged.

Yeah. I should have made sure opal-api.h is in sync with skiboot. On skiboot
side I added below macros to fsp-leds.h instead of opal-api.h :-(

Anyway for now these macros are used by led driver only (on both side).. Hence I
think its fine to add to driver code itself. But we should make sure these
strings won't change as we use them while creating sysfs entries and use that
information to identify the type of LED.


> 
> Instead those values are moved into the driver, which is the only place
> they are used.
> 
> Fixes: 8a8d91817aec ("powerpc/powernv: Add OPAL interfaces for accessing and modifying system LED states")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Patch looks good.

Reviewed-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>

-Vasant

> ---
>  arch/powerpc/include/asm/opal-api.h | 12 ++++++++++++
>  drivers/leds/leds-powernv.c         |  6 +++---
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index b516ec1d3b4c..9784c9241c70 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -343,6 +343,18 @@ enum OpalPciResetState {
>  	OPAL_ASSERT_RESET   = 1
>  };
> 
> +enum OpalSlotLedType {
> +	OPAL_SLOT_LED_TYPE_ID = 0,	/* IDENTIFY LED */
> +	OPAL_SLOT_LED_TYPE_FAULT = 1,	/* FAULT LED */
> +	OPAL_SLOT_LED_TYPE_ATTN = 2,	/* System Attention LED */
> +	OPAL_SLOT_LED_TYPE_MAX = 3
> +};
> +
> +enum OpalSlotLedState {
> +	OPAL_SLOT_LED_STATE_OFF = 0,	/* LED is OFF */
> +	OPAL_SLOT_LED_STATE_ON = 1	/* LED is ON */
> +};
> +
>  /*
>   * Address cycle types for LPC accesses. These also correspond
>   * to the content of the first cell of the "reg" property for
> diff --git a/drivers/leds/leds-powernv.c b/drivers/leds/leds-powernv.c
> index a2fea192573b..2c5c5b12ab64 100644
> --- a/drivers/leds/leds-powernv.c
> +++ b/drivers/leds/leds-powernv.c
> @@ -27,9 +27,9 @@ struct led_type_map {
>  	const char	*desc;
>  };
>  static const struct led_type_map led_type_map[] = {
> -	{OPAL_SLOT_LED_TYPE_ID,		POWERNV_LED_TYPE_IDENTIFY},
> -	{OPAL_SLOT_LED_TYPE_FAULT,	POWERNV_LED_TYPE_FAULT},
> -	{OPAL_SLOT_LED_TYPE_ATTN,	POWERNV_LED_TYPE_ATTENTION},
> +	{OPAL_SLOT_LED_TYPE_ID,		"identify"},
> +	{OPAL_SLOT_LED_TYPE_FAULT,	"fault"},
> +	{OPAL_SLOT_LED_TYPE_ATTN,	"attention"},
>  	{-1,				NULL},
>  };
> 
