Return-Path: <nathanpilatzke@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.230])
	by ozlabs.org (Postfix) with ESMTP id 99F8467A42
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jun 2006 03:34:31 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 69so70319wra
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 10:34:30 -0700 (PDT)
Message-ID: <447DD396.8070603@gmail.com>
Date: Wed, 31 May 2006 13:34:14 -0400
From: Nathan Pilatzke <nathanpilatzke@gmail.com>
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: >=2.6.17-rc4-mm1 kernel compilation problem (relocation truncated
	to fit)
References: <447DAAE4.7010503@gmail.com> <447DC91D.8010508@zytor.com>
In-Reply-To: <447DC91D.8010508@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Applied the patch, did a 'make clean' and 'make'.  The patch had no
effect for me, exact same errors.

H. Peter Anvin wrote:
> Nathan Pilatzke wrote:
>> I am getting compilation errors for 2.6.17-rc5-mm1 all the way back to
>> 2.6.17-rc4-mm1.  Kernel 2.6.17-rc3-mm1 compiles better for me (I get the
>> undefined reference to __udivdi3 error that has been reported
>> previously).  Here are the errors that I get for 2.6.17-rc5-mm1:
>>
> 
> Could you try the following patch?
> 
>     -hpa
> 
> 
> ------------------------------------------------------------------------
> 
> diff --git a/usr/klibc/arch/ppc/MCONFIG b/usr/klibc/arch/ppc/MCONFIG
> index 8b51e65..e101453 100644
> --- a/usr/klibc/arch/ppc/MCONFIG
> +++ b/usr/klibc/arch/ppc/MCONFIG
> @@ -13,9 +13,9 @@ KLIBCBITSIZE  = 32
>  # Extra linkflags when building the shared version of the library
>  # This address needs to be reachable using normal inter-module
>  # calls, and work on the memory models for this architecture
> -# 256-16 MB - normal binaries start at 256 MB, and jumps are limited
> +# 256-8 MB - normal binaries start at 256 MB, and jumps are limited
>  # to +/- 16 MB
> -KLIBCSHAREDFLAGS     = -Ttext 0x0f000200
> +KLIBCSHAREDFLAGS     = -Ttext 0x0f800200
>  
>  # The kernel so far has both asm-ppc* and asm-powerpc.
>  KLIBCARCHINCFLAGS = -I$(KLIBCKERNELOBJ)arch/$(KLIBCARCH)/include
