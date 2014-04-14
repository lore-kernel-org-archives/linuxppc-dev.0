Return-Path: <amodra@gmail.com>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C634E140084
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 16:53:37 +1000 (EST)
Received: by mail-pa0-f43.google.com with SMTP id bj1so7896538pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Apr 2014 23:53:34 -0700 (PDT)
Date: Mon, 14 Apr 2014 16:23:29 +0930
From: Alan Modra <amodra@gmail.com>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Subject: Re: Change MINSIGSTKSZ and SIGSTKSIZE
Message-ID: <20140414065329.GT13391@bubble.grove.modra.org>
References: <1397296795.11946.42.camel@hbabu-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1397296795.11946.42.camel@hbabu-laptop>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Apr 12, 2014 at 02:59:55AM -0700, Haren Myneni wrote:
> Alan, 
> 	LTP test (signalstack02) is failing.

Ignore the stupid test.  Do *NOT* change the kernel value to match
glibc.  The two sets of constants are independent.

The glibc constants are for user code, to allocate correctly sized
signal stacks for all known kernels.  These constants are therefore
the maximum values needed for known kernels.

The kernel constants are to check that user code is setting up a large
enough signal stack *for that specific kernel, and user binary*.  If
you make the kernel constants match current glibc, then old binaries
that don't use htm or vsx will fail when run on a newer kernel.

Ideally the kernel would detect whether a binary was going to use htm
or vsx and adjust the minimum sizes, but it's a wee bit difficult for
the kernel to know that ahead of time.

> This test expects -ENOMEM from
> kernel when passing less than stack size (passing 4095). MINSIGSTKSZ in
> signal.h (glibc) is changed to 4096 to support VSX changes
> (https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=f7c399cff5bd04ee9dc117fb6b0f39597dc047c6)  We should also change these values in kernel to match with glibc. Any issues? 
> 
> diff --git a/arch/powerpc/include/uapi/asm/signal.h
> b/arch/powerpc/include/uapi/
> index 6c69ee9..18f498e 100644
> --- a/arch/powerpc/include/uapi/asm/signal.h
> +++ b/arch/powerpc/include/uapi/asm/signal.h
> @@ -85,8 +85,8 @@ typedef struct {
>  
>  #define SA_RESTORER    0x04000000U
>  
> -#define MINSIGSTKSZ    2048
> -#define SIGSTKSZ       8192
> +#define MINSIGSTKSZ    4096
> +#define SIGSTKSZ       16384
> 
> Thanks
> Haren

-- 
Alan Modra
Australia Development Lab, IBM
