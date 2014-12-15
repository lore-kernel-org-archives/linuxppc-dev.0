Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E20A1A00AE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Dec 2014 11:05:22 +1100 (AEDT)
Message-ID: <1418601906.5111.37.camel@kernel.crashing.org>
Subject: Re: [PATCH 13/18] powerpc/uaccess: fix sparse errors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Date: Mon, 15 Dec 2014 11:05:06 +1100
In-Reply-To: <1418575877-21488-14-git-send-email-mst@redhat.com>
References: <1418575877-21488-1-git-send-email-mst@redhat.com>
 <1418575877-21488-14-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2014-12-14 at 18:52 +0200, Michael S. Tsirkin wrote:
> virtio wants to read bitwise types from userspace using get_user.  At the
> moment this triggers sparse errors, since the value is passed through an
> integer.
> 
> Fix that up using __force.

You mean bitfields ? Argh ... we should just remove them from the
compiler and be done with it :-(

Ben.

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/powerpc/include/asm/uaccess.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index 9485b43..a0c071d 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -284,7 +284,7 @@ do {								\
>  	if (!is_kernel_addr((unsigned long)__gu_addr))		\
>  		might_fault();					\
>  	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
> -	(x) = (__typeof__(*(ptr)))__gu_val;			\
> +	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
>  	__gu_err;						\
>  })
>  #endif /* __powerpc64__ */
> @@ -297,7 +297,7 @@ do {								\
>  	might_fault();							\
>  	if (access_ok(VERIFY_READ, __gu_addr, (size)))			\
>  		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
> -	(x) = (__typeof__(*(ptr)))__gu_val;				\
> +	(x) = (__force __typeof__(*(ptr)))__gu_val;				\
>  	__gu_err;							\
>  })
>  
> @@ -308,7 +308,7 @@ do {								\
>  	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
>  	__chk_user_ptr(ptr);					\
>  	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
> -	(x) = (__typeof__(*(ptr)))__gu_val;			\
> +	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
>  	__gu_err;						\
>  })
>  
