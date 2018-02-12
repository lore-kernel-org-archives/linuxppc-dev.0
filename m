Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zfvGb4cSpzF0Wk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 16:23:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] powerpc/vas: Fix cleanup when VAS is not configured
In-Reply-To: <1518234567-24869-2-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1518234567-24869-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1518234567-24869-2-git-send-email-sukadev@linux.vnet.ibm.com>
Date: Mon, 12 Feb 2018 16:23:50 +1100
Message-ID: <87d11awzkp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:

> When VAS is not configured in the system, make sure to remove
> the VAS debugfs directory and unregister the platform driver.
>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
...
> diff --git a/arch/powerpc/platforms/powernv/vas.c b/arch/powerpc/platforms/powernv/vas.c
> index aebbe95..f83e27d8 100644
> --- a/arch/powerpc/platforms/powernv/vas.c
> +++ b/arch/powerpc/platforms/powernv/vas.c
> @@ -169,8 +169,11 @@ static int __init vas_init(void)
>  		found++;
>  	}
>  
> -	if (!found)
> +	if (!found) {
> +		platform_driver_unregister(&vas_driver);
> +		vas_cleanup_dbgdir();
>  		return -ENODEV;
> +	}

The better patch would be to move the call to vas_init_dbgdir() down
here, where we know we have successfully registered the driver.

cheers
