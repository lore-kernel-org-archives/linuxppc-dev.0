Return-Path: <srs0=/kn/=ge=gmail.com=dmitry.torokhov@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401cr75JYRzDr46
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 03:39:19 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 401cr7468Sz8syR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 03:39:19 +1100 (AEDT)
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 401cr70c4Zz9sTs
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2018 03:39:18 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id d26so1634673pfn.5
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2018 09:39:18 -0700 (PDT)
Date: Wed, 14 Mar 2018 09:39:13 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [RESEND PATCH] Input: joystick/analog - Use get_cycles() on PPC
Message-ID: <20180314163913.GC18065@dtor-ws>
References: <20180314111752.1748-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180314111752.1748-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 14, 2018 at 10:17:52PM +1100, Michael Ellerman wrote:
> The analog joystick driver spits a warning at us:
> 
>   drivers/input/joystick/analog.c:176:2: warning: #warning Precise timer
>   not defined for this architecture.
> 
> PPC has get_cycles() so use that.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied, thank you.

> ---
>  drivers/input/joystick/analog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> This is the third resend, I'll take it via the powerpc tree if no one else
> does.
> 
> cheers
> 
> diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
> index c868a878c84f..a942c4ccd2af 100644
> --- a/drivers/input/joystick/analog.c
> +++ b/drivers/input/joystick/analog.c
> @@ -163,7 +163,7 @@ static unsigned int get_time_pit(void)
>  #define GET_TIME(x)	do { x = (unsigned int)rdtsc(); } while (0)
>  #define DELTA(x,y)	((y)-(x))
>  #define TIME_NAME	"TSC"
> -#elif defined(__alpha__) || defined(CONFIG_MN10300) || defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_RISCV) || defined(CONFIG_TILE)
> +#elif defined(__alpha__) || defined(CONFIG_MN10300) || defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_PPC) || defined(CONFIG_RISCV) || defined(CONFIG_TILE)
>  #define GET_TIME(x)	do { x = get_cycles(); } while (0)
>  #define DELTA(x,y)	((y)-(x))
>  #define TIME_NAME	"get_cycles"
> -- 
> 2.14.1
> 

-- 
Dmitry
