Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ztdTt49RDzF1n6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Mar 2018 18:44:16 +1100 (AEDT)
Subject: Re: [PATCH v2 06/21] powerpc: Avoid comparison of unsigned long >= 0
 in __access_ok
To: Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20180225172236.29650-7-malat@debian.org>
 <20180302195051.4472-1-malat@debian.org>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <831294da-9605-d235-8d5e-57c744753800@c-s.fr>
Date: Sat, 3 Mar 2018 08:44:02 +0100
MIME-Version: 1.0
In-Reply-To: <20180302195051.4472-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 02/03/2018 à 20:50, Mathieu Malaterre a écrit :
> Rewrite function-like macro into regular static inline function to avoid a
> warning during macro expansion.
> Fix warning (treated as error in W=1):
> 
>    CC      arch/powerpc/kernel/signal_32.o
> In file included from ./include/linux/uaccess.h:14:0,
>                   from ./include/asm-generic/termios-base.h:8,
>                   from ./arch/powerpc/include/asm/termios.h:20,
>                   from ./include/uapi/linux/termios.h:6,
>                   from ./include/linux/tty.h:7,
>                   from arch/powerpc/kernel/signal_32.c:36:
> ./include/asm-generic/termios-base.h: In function ‘user_termio_to_kernel_termios’:
> ./arch/powerpc/include/asm/uaccess.h:52:35: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
>     (((size) == 0) || (((size) - 1) <= ((segment).seg - (addr)))))
>                                     ^
> ./arch/powerpc/include/asm/uaccess.h:58:3: note: in expansion of macro ‘__access_ok’
>     __access_ok((__force unsigned long)(addr), (size), get_fs()))
>     ^~~~~~~~~~~
> ./arch/powerpc/include/asm/uaccess.h:262:6: note: in expansion of macro ‘access_ok’
>    if (access_ok(VERIFY_READ, __gu_addr, (size)))   \
>        ^~~~~~~~~
> ./arch/powerpc/include/asm/uaccess.h:80:2: note: in expansion of macro ‘__get_user_check’
>    __get_user_check((x), (ptr), sizeof(*(ptr)))
>    ^~~~~~~~~~~~~~~~
> ./include/asm-generic/termios-base.h:36:6: note: in expansion of macro ‘get_user’
>    if (get_user(termios->c_line, &termio->c_line) < 0)
>        ^~~~~~~~
> [...]
> cc1: all warnings being treated as errors
> 
> Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   arch/powerpc/include/asm/uaccess.h | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index 51bfeb8777f0..a62ee663b2c8 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -47,9 +47,13 @@
>   
>   #else
>   
> -#define __access_ok(addr, size, segment)	\
> -	(((addr) <= (segment).seg) &&		\
> -	 (((size) == 0) || (((size) - 1) <= ((segment).seg - (addr)))))
> +static inline int __access_ok(unsigned long addr, unsigned long size,
> +			mm_segment_t seg)
> +{
> +	if (addr > seg.seg)
> +		return 0;
> +	return (size == 0 || size - 1 <= seg.seg - addr);
> +}
>   
>   #endif
>   
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
