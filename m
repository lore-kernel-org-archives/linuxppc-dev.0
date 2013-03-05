Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 by ozlabs.org (Postfix) with ESMTP id F32A92C0340
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2013 12:23:24 +1100 (EST)
Date: Mon, 4 Mar 2013 17:23:14 -0800 (PST)
From: Christian Kujau <lists@nerdbynature.de>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH] ppc32: Fix compile of sha1-powerpc-asm.S
In-Reply-To: <1361845205-30606-1-git-send-email-tony@bakeyournoodle.com>
Message-ID: <alpine.DEB.2.10.1303041656010.22410@trent.utfs.org>
References: <1361845205-30606-1-git-send-email-tony@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 26 Feb 2013 at 13:20, Tony Breeds wrote:
> When building with CRYPTO_SHA1_PPC enabled we fail with:
> ---
> powerpc/crypto/sha1-powerpc-asm.S: Assembler messages:
> powerpc/crypto/sha1-powerpc-asm.S:116: Error: can't resolve `0' {*ABS* section} - `STACKFRAMESIZE' {*UND* section}
> powerpc/crypto/sha1-powerpc-asm.S:116: Error: expression too complex
> powerpc/crypto/sha1-powerpc-asm.S:178: Error: unsupported relocation against STACKFRAMESIZE
> ---
> 
> Use INT_FRAME_SIZE instead.
> 
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

Thanks for the fix! Ran into this as well, with your patch 3.9-rc1 
compiles again (and it even boots :-))

Tested-by: Christian Kujau <lists@nerdbynature.de>

$ grep -A10 sha1 /proc/crypto
name         : sha1
driver       : sha1-powerpc
module       : kernel
priority     : 0
refcnt       : 1
selftest     : passed
type         : shash
blocksize    : 64
digestsize   : 20


> ---
>  arch/powerpc/crypto/sha1-powerpc-asm.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> FWIW the SHA1_PPC makes about a 20% difference on my 32bit board
> 
> diff --git a/arch/powerpc/crypto/sha1-powerpc-asm.S b/arch/powerpc/crypto/sha1-powerpc-asm.S
> index a5f8264..125e165 100644
> --- a/arch/powerpc/crypto/sha1-powerpc-asm.S
> +++ b/arch/powerpc/crypto/sha1-powerpc-asm.S
> @@ -113,7 +113,7 @@
>  	STEPUP4((t)+16, fn)
>  
>  _GLOBAL(powerpc_sha_transform)
> -	PPC_STLU r1,-STACKFRAMESIZE(r1)
> +	PPC_STLU r1,-INT_FRAME_SIZE(r1)
>  	SAVE_8GPRS(14, r1)
>  	SAVE_10GPRS(22, r1)
>  
> @@ -175,5 +175,5 @@ _GLOBAL(powerpc_sha_transform)
>  
>  	REST_8GPRS(14, r1)
>  	REST_10GPRS(22, r1)
> -	addi	r1,r1,STACKFRAMESIZE
> +	addi	r1,r1,INT_FRAME_SIZE
>  	blr
> -- 
> 1.8.1.2
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

-- 
BOFH excuse #21:

POSIX compliance problem
