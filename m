Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id EAC5167A44
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 05:11:14 +1100 (EST)
Date: Tue, 21 Mar 2006 12:11:05 -0600
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 8/11] powerpc: Add strne2a() to convert a string from
	EBCDIC to ASCII
Message-ID: <20060321181105.GA5248@pb15.lixom.net>
References: <1142934351.193140.181086235013.qpush@concordia>
	<20060321094637.C86EE67BBB@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060321094637.C86EE67BBB@ozlabs.org>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 21, 2006 at 08:46:08PM +1100, Michael Ellerman wrote:
> Add strne2a() which converts a string from EBCDIC to ASCII.

Nitpick, since this isn't hot path:

> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> 
>  arch/powerpc/lib/e2a.c       |   10 ++++++++++
>  include/asm-powerpc/system.h |    2 ++
>  2 files changed, 12 insertions(+)
> 
> Index: to-merge/arch/powerpc/lib/e2a.c
> ===================================================================
> --- to-merge.orig/arch/powerpc/lib/e2a.c
> +++ to-merge/arch/powerpc/lib/e2a.c
> @@ -103,4 +103,14 @@ unsigned char e2a(unsigned char x)
>  }
>  EXPORT_SYMBOL(e2a);
>  
> +unsigned char* strne2a(unsigned char *dest, const unsigned char *src, size_t n)
> +{
> +	int i;
>  
> +	n = strnlen(src, n);
> +
> +	for (i = 0; i < n; i++)
> +		dest[i] = e2a(src[i]);

Why iterate over the string twice? Why not do 
	for (..; i < n && src[n]; ...)
instead?


-Olof
