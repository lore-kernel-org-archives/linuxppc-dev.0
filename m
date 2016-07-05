Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkCQx1gLGzDrRm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:40:41 +1000 (AEST)
In-Reply-To: <20160406070012.GA11647@simonLocalRHEL7.x64>
To: Simon Guo <wei.guo.simon@gmail.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Kees Cook <keescook@chromium.org>, Simon Guo <wei.guo.simon@gmail.com>,
 Rashmica Gupta <rashmicy@gmail.com>, linux-kernel@vger.kernel.org,
 Simon Guo <simonguo@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RESEND,
 v2] powerpc: Export thread_struct.used_vr/used_vsr to user space
Message-Id: <3rkCQx0jldz9sBl@ozlabs.org>
Date: Tue,  5 Jul 2016 15:40:40 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-06-04 at 07:00:12 UTC, Simon Guo wrote:
> These 2 fields track whether user process has used Altivec/VSX
> registers or not. They are used by kernel to setup signal frame
> on user stack correctly regarding vector part.
> 
> CRIU(Checkpoint and Restore In User space) builds signal frame
> for restored process. It will need this export information to
> setup signal frame correctly. And CRIU will need to restore these
> 2 fields for the restored process.
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> Reviewed-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> 
> diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
> index 8036b38..d5afe95 100644
> --- a/arch/powerpc/include/uapi/asm/ptrace.h
> +++ b/arch/powerpc/include/uapi/asm/ptrace.h
> @@ -176,6 +176,17 @@ struct pt_regs {
>  #define PTRACE_GETREGS64	  0x16
>  #define PTRACE_SETREGS64	  0x17
>  
> +/*
> + * Get or set some register used bit.
> + * The flags will be saved in a 32 bit data.
> + * Currently it is only used for VR/VSR usage.
> + */
> +#define PTRACE_GET_REGS_USAGE	  0x1e
> +#define PTRACE_SET_REGS_USAGE	  0x1f
> +
> +#define PTRACE_REGS_USAGE_VR_BIT  0x00000001
> +#define PTRACE_REGS_USAGE_VSR_BIT 0x00000002


It looks like you just made up this new ptrace ABI ?

Or is it used on other arches ? (no AFAICS)

How do other arches handle this ?

I'm a bit wary of adding new ptrace ABIs.

If we do want to do this, I'd at least think the mask should be u64, to give us
more capacity to add new registers.

cheers
