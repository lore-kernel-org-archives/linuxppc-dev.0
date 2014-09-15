Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 213E11A0121
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 13:10:24 +1000 (EST)
Message-ID: <1410750623.24738.9.camel@concordia>
Subject: Re: [PATCH 1/4] powerpc/powernv: Add OPAL check token call
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Date: Mon, 15 Sep 2014 13:10:23 +1000
In-Reply-To: <1408423682-14297-1-git-send-email-mikey@neuling.org>
References: <1408423682-14297-1-git-send-email-mikey@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-08-19 at 14:47 +1000, Michael Neuling wrote:
> Currently there is no way to generically check if an OPAL call exists or not
> from the host kernel.
> 
> This adds an OPAL call opal_check_token() which tells you if the given token is
> present in OPAL or not.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>  arch/powerpc/include/asm/opal.h                | 7 +++++++
>  arch/powerpc/platforms/powernv/opal-wrappers.S | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 86055e5..4593a93 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -135,6 +135,7 @@ struct opal_sg_list {
>  #define OPAL_FLASH_MANAGE			77
>  #define OPAL_FLASH_UPDATE			78
>  #define OPAL_RESYNC_TIMEBASE			79
> +#define OPAL_CHECK_TOKEN			80
>  #define OPAL_DUMP_INIT				81
>  #define OPAL_DUMP_INFO				82
>  #define OPAL_DUMP_READ				83
> @@ -417,6 +418,11 @@ struct opal_msg {
>  	__be64 params[8];
>  };
>  
> +enum OpalCheckTokenStatus {
> +       OPAL_TOKEN_ABSENT = 0,
> +       OPAL_TOKEN_PRESENT = 1
> +};

I don't see this used anywhere?

And NoCamelCase !

Yes I know there's lots in that file, but I didn't merge that :)

cheers
