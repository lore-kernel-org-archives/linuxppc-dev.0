Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzGQC4cPlzDqZv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 21:40:18 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, zajec5@gmail.com,
 leoli@freescale.com, qiang.zhao@freescale.com, viresh.kumar@linaro.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 scottwood@freescale.com, akpm@linux-foundation.org, linux@roeck-us.net
Subject: Re: [v3] UCC_GETH/UCC_FAST: Use IS_ERR_VALUE_U32 API to avoid
 IS_ERR_VALUE abuses.
Date: Tue, 26 Jul 2016 13:39:15 +0200
Message-ID: <4175803.I7CDUloLxQ@wuerfel>
In-Reply-To: <1469297151-9763-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1469297151-9763-1-git-send-email-arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday, July 23, 2016 11:35:51 PM CEST Arvind Yadav wrote:
> diff --git a/include/linux/err.h b/include/linux/err.h
> index 1e35588..a42f942 100644
> --- a/include/linux/err.h
> +++ b/include/linux/err.h
> @@ -19,6 +19,7 @@
>  #ifndef __ASSEMBLY__
>  
>  #define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
> +#define IS_ERR_VALUE_U32(x) unlikely((unsigned int)(x) >= (unsigned int)-MAX_ERRNO)
>  
>  static inline void * __must_check ERR_PTR(long error)
>  {

This doesn't really look like something we want to have as a generic
interface. The IS_ERR_VALUE() API is rather awkward already, and your
use seems specific to the cpu_muram_alloc() function.

How about something like

int cpm_muram_error(unsigned long addr)
{
	if (addr >= (unsigned long)-MAX_ERRNO)
		return addr;
	else
		return 0;
}

and then use that to check the value returned by the allocation
that is still an 'unsigned long', before assigning it to a 'u32'.

	Arnd
