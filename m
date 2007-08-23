Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5A31EDDED6
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 16:00:36 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IO5k7-0005fH-KO
	for linuxppc-dev@ozlabs.org; Wed, 22 Aug 2007 23:00:31 -0700
Message-ID: <12288012.post@talk.nabble.com>
Date: Wed, 22 Aug 2007 23:00:31 -0700 (PDT)
From: sivaji <rameshmrm@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Section mismatch warning
In-Reply-To: <C5046FD2-6781-4E6E-847B-1BDB24E5D81F@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <12286518.post@talk.nabble.com>
	<C5046FD2-6781-4E6E-847B-1BDB24E5D81F@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Hi,
        I applied the patch(13066). After that i got following error.
 arch/powerpc/kernel/vmlinux.lds:59: parse error

I added the following lines in the vmlinux.lds file
  ALIGN_FUNCTION();
  *(.text.head)

Then i removed the ALIGN_FUNCTION() in the vmlinux.lds file. The parse error
was overcome. I don't know after removing the ALIGN_FUNCTION why the error
was overcome. 

>
> Hi,
>         When compiling the 2.6.23-rc3 kernel,  i got following warning
> messages.
>
> WARNING: vmlinux.o(.text+0x18): Section mismatch: reference to
> .init.text:early_init (between '__start' and '__after_mmu_off')
> WARNING: vmlinux.o(.text+0x3834): Section mismatch: reference to
> .init.text:machine_init (between 'start_here' and 'set_context')
> WARNING: vmlinux.o(.text+0x383c): Section mismatch: reference to
> .init.text:MMU_init (between 'start_here' and 'set_context')
> WARNING: vmlinux.o(.text+0x3866): Section mismatch: reference to
> .init.text:start_kernel (between 'start_here' and 'set_context')
> WARNING: vmlinux.o(.text+0x386a): Section mismatch: reference to
> .init.text:start_kernel (between 'start_here' and 'set_context')
>
> Processor            : 8641D
> Give some idea how to overcome this warning.

There is a patch posted on the list for this.  I doubt will fix these  
for 2.6.23 as they are just warnings.

http://patchwork.ozlabs.org/linuxppc/patch?id=13066

- k

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev



-- 
View this message in context: http://www.nabble.com/Section-mismatch-warning-tf4315101.html#a12288012
Sent from the linuxppc-dev mailing list archive at Nabble.com.
