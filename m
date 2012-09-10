Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 60D242C0096
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 14:42:30 +1000 (EST)
Message-ID: <1347252129.2385.147.camel@pasglop>
Subject: Re: [PATCH] using get/put_user64 apis on 64bit machine
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bharat Bhushan <r65777@freescale.com>
Date: Mon, 10 Sep 2012 14:42:09 +1000
In-Reply-To: <1343038597-23859-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1343038597-23859-1-git-send-email-Bharat.Bhushan@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: scottwood@freescale.com, Bharat Bhushan <bharat.bhushan@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, agraf@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-07-23 at 15:46 +0530, Bharat Bhushan wrote:
> On powerpc64 machine get/put_user64() is same as get/put_user() while
> on powerpc32 machine get_user64 is different. With this patch we can
> use get_user64() and put_user64() on 32 and 64 bit machines.
> 
> Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
> ---

There appear to be no user of any of these APIs in the tree. There's
also no get_user64 -> __get_user64() macros either. Why not just remove
the whole lot ?

Cheers,
Ben.

>  arch/powerpc/include/asm/uaccess.h |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index 17bb40c..01743aa 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -114,10 +114,17 @@ struct exception_table_entry {
>  #define __put_user(x, ptr) \
>  	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
>  
> +/*
> + * On powerpc64 machine get/put_user64() is same as get/put_user() while
> + * on powerpc32 machine get_user64 is different.
> + */
>  #ifndef __powerpc64__
>  #define __get_user64(x, ptr) \
>  	__get_user64_nocheck((x), (ptr), sizeof(*(ptr)))
>  #define __put_user64(x, ptr) __put_user(x, ptr)
> +#else
> +#define __get_user64(x, ptr) __get_user(x, ptr) 
> +#define __put_user64(x, ptr) __put_user(x, ptr)
>  #endif
>  
>  #define __get_user_inatomic(x, ptr) \
