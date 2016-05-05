Return-Path: <lsorense@csclub.uwaterloo.ca>
Received: from mail.csclub.uwaterloo.ca (mail.csclub.uwaterloo.ca
 [129.97.134.52])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r16ZP37gLzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 06:53:33 +1000 (AEST)
From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 5 May 2016 16:53:29 -0400
To: linux-kernel@vger.kernel.org
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Fix sstep compile on powerpcspe
Message-ID: <20160505205329.GG3264@csclub.uwaterloo.ca>
References: <20160505204444.GE3264@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160505204444.GE3264@csclub.uwaterloo.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 05, 2016 at 04:44:44PM -0400, Lennart Sorensen wrote:
> powerpc: Fix sstep compile on powerpcspe
> 
> Commit be96f63375a14ee8e690856ac77e579c75bd0bae introduced ldarx and stdcx
> into the instructions in sstep.c, which are not accepted by the assembler
> on powerpcspe, but does seem to be accepted by the normal powerpc assembler
> even in 32 bit mode.
> 
> Wrap these two instructions in a __powerpc64__ check like it is everywhere
> else in the file.
> 
> Fixes: be96f63375a1 ("powerpc: Split out instruction analysis part of emulate_step()")
> Signed-off-by: Len Sorensen <lsorense@csclub.uwaterloo.ca>
> ---
>  arch/powerpc/lib/sstep.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index dc885b3..6d34310 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -1818,9 +1818,11 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
>  		case 4:
>  			__get_user_asmx(val, op.ea, err, "lwarx");
>  			break;
> +#ifdef __powerpc64__
>  		case 8:
>  			__get_user_asmx(val, op.ea, err, "ldarx");
>  			break;
> +#endif
>  		default:
>  			return 0;
>  		}
> @@ -1841,9 +1843,11 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
>  		case 4:
>  			__put_user_asmx(op.val, op.ea, err, "stwcx.", cr);
>  			break;
> +#ifdef __powerpc64__
>  		case 8:
>  			__put_user_asmx(op.val, op.ea, err, "stdcx.", cr);
>  			break;
> +#endif
>  		default:
>  			return 0;
>  		}
> -- 
> 1.7.10.4

Perhaps this should be considered for -stable as well since it is fixing
a regression for powerpcspe.

-- 
Len Sorensen
