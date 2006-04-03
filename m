Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 85493679FB
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2006 00:13:39 +1000 (EST)
In-Reply-To: <e9aafa30604030439y29b88638o220a4446295001d0@mail.gmail.com>
References: <e9aafa30604030439y29b88638o220a4446295001d0@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C3F652D8-8EA2-4D36-A370-7C76CAE3FCE1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Some issues of Linux2.6.16.1 compilation for MPC8548
Date: Mon, 3 Apr 2006 09:13:54 -0500
To: fengcheng lu <sparking.lu@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 3, 2006, at 6:39 AM, fengcheng lu wrote:

> Hello all
>
>      When I try to compile the latest kernel2.6.16.1 for MPC8548, I  
> have the following questions.
>
>      1. run the make command after the kernel is configured(all are  
> default configurations except the processor type is MPC8548), the  
> following errors are got
>          CC arch/powerpc/kernel/asm-offset.s
>      In file included from include/asm-ppc/io.h:39
>                            from include/asm/io.h:13,
>                            from arch/powerpc/kernel/asm-offsets.c:33:
>      arch/powerpc/include/asm/mpc85xx.h:29:40: platforms/85xx/ 
> mpc8555_cds.h: No such file or directory
> make[1]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1
>
>   It seems the header file path is wrong. so I build the symbol link
>          ln -s /usr/src/linux-2.6.16.1/include/platforms /usr/src/ 
> linux-2.6.16.1/arch/ppc/platforms
>          ln -s /usr/src/linux-2.6.16.1/include/syslib /usr/src/ 
> linux-2.6.16.1/arch/ppc/syslib
>   After that, the issues is fixed. But I have still other issues:
>
>    2.
>      arch/powerpc/kernel/entry_32.S:48:24: head_booke.h: No such  
> file or directory
>      make[1]: *** [arch/powerpc/kernel/entry_32.o] Error 1
>      I found this file in arch/ppc/kernel/head_booke.h and copy it  
> into arch/powerpc/kernel/ and re-compile it. sio this issue is  
> fixed. but new problem coming
>
>    3.
>       ld: arch/powerpc/platforms/85xx/built-in.o: No such file: No  
> such file or directory
>       make[1]: *** [arch/powerpc/platforms/built-in.o] Error 1
>
>      What do I do? Any patches for these issues?

Are you trying to build 8548 with ARCH=ppc or ARCH=powerpc?

- kumar
