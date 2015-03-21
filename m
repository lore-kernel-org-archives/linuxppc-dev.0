Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0107.outbound.protection.outlook.com [157.56.111.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C9141A0372
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 11:01:21 +1100 (AEDT)
Date: Fri, 20 Mar 2015 19:01:09 -0500
From: Scott Wood <scottwood@freescale.com>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Subject: Re: powerpc32: fix warning from include/asm-generic/termios-base.h
Message-ID: <20150321000109.GA24932@home.buserror.net>
References: <20141205112025.330971A5D4F@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20141205112025.330971A5D4F@localhost.localdomain>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 05, 2014 at 12:20:25PM +0100, LEROY Christophe wrote:
> When size is equal to 1, the test is always true so lets eliminate both 0 and 1
> at first.
> 
> include/asm-generic/termios-base.h: In function 'user_termio_to_kernel_termios':
> include/asm-generic/termios-base.h:35:2: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
>   if (get_user(termios->c_line, &termio->c_line) < 0)
>   ^
> include/asm-generic/termios-base.h: In function 'kernel_termios_to_user_termio':
> include/asm-generic/termios-base.h:57:6: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
>       put_user(termios->c_line,  &termio->c_line) < 0 ||
>       ^
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/uaccess.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index 9485b43..f3028d2 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -54,7 +54,7 @@
>  
>  #define __access_ok(addr, size, segment)	\
>  	(((addr) <= (segment).seg) &&		\
> -	 (((size) == 0) || (((size) - 1) <= ((segment).seg - (addr)))))
> +	 (((size) <= 1) || (((size) - 1) <= ((segment).seg - (addr)))))

Again, I don't think Linux enables this warning.  What did you do to
produce this?  In any case, it's a bad warning that doesn't take macros
into account, and the answer is not to make the code less clear by hiding
the fact that zero is a special case.

-Scott
