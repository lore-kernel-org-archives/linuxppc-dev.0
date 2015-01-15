Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A976F1A0D80
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 09:38:41 +1100 (AEDT)
Message-ID: <1421361518.23332.3.camel@ellerman.id.au>
Subject: Re: How to make use of SPE instructions?
From: Michael Ellerman <mpe@ellerman.id.au>
To: Markus Stockhausen <stockhausen@collogia.de>
Date: Fri, 16 Jan 2015 09:38:38 +1100
In-Reply-To: <12EF8D94C6F8734FB2FF37B9FBEDD1735F90DD25@EXCHANGE.collogia.de>
References: <12EF8D94C6F8734FB2FF37B9FBEDD1735F90DD25@EXCHANGE.collogia.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-01-08 at 09:58 +0000, Markus Stockhausen wrote:
> Hello,
> 
> I developed a SHA224/256 kernel crypto module with SPE instructions.
> The result looks quite promising (~ +50% speedup). Nevertheless the
> flooding of kernel messages "SPE used in kernel" makes me feel 
> uncomfortable.
> 
> My findings so far:
> 
> - I can configure the kernel with "SPE support". 
> - arch/powerpc/kernel/head_fsl_booke.S suggests that the message is
>   triggerd unconditionally whenwever we make use of SPE in kernel.
> - There exists a function enable_kernel_spe() but I don't know how
>   this could help me in my work.
> 
> I guess I need some kind of "brackets" around my coding to make sure 
> the upper 32 bit of the registers are stored correctly during task switch. 
> Or is the use of SPE instructions inside the kernel totally forbidden? Any 
> expert with some helpful advise?

I don't know about SPE specifically, hopefully someone from FSL can chime in.

But, IIUIC you should just be able to call enable_kernel_spe() prior to your
code, ie. before you execute any SPE instructions. That will save any values
userspace has left in the SPE regs, and then enable SPE for you in the kernel.
That should get rid of the "SPE used in kernel" messages.  

cheers
