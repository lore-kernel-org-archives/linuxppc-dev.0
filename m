Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by ozlabs.org (Postfix) with ESMTP id 44971DDE37
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 12:39:52 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so503632wag
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 19:39:51 -0700 (PDT)
Message-ID: <fa686aa40706131939p75e168a8hfe626e5452261c1f@mail.gmail.com>
Date: Wed, 13 Jun 2007 20:39:51 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: biovore <biovore@biovore.net>
Subject: Re: New to ML-310
In-Reply-To: <200706132031.53942.biovore@biovore.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200706132031.53942.biovore@biovore.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 6/13/07, biovore <biovore@biovore.net> wrote:
>   CC      arch/ppc/syslib/xilinx_pic.o
> arch/ppc/syslib/xilinx_pic.c:30:5: warning: "XPAR_XINTC_USE_DCR" is not
> defined
> arch/ppc/syslib/xilinx_pic.c:121:5: warning: "XPAR_XINTC_USE_DCR" is not
> defined
> arch/ppc/syslib/xilinx_pic.c: In function 'ppc4xx_pic_init':
> arch/ppc/syslib/xilinx_pic.c:122: error: 'XPAR_INTC_0_BASEADDR' undeclared
> (first use in this function)
> arch/ppc/syslib/xilinx_pic.c:122: error: (Each undeclared identifier is
> reported only once
> arch/ppc/syslib/xilinx_pic.c:122: error: for each function it appears in.)
> arch/ppc/syslib/xilinx_pic.c:148: error: 'XPAR_INTC_0_KIND_OF_INTR' undeclared
> (first use in this function)
> make[1]: *** [arch/ppc/syslib/xilinx_pic.o] Error 1
> make: *** [arch/ppc/syslib] Error 2
>
> This to me looks like my xparameters.h file is missing something..    Any
> ideas?

Go into software settings, and set a driver for the intc core.  (Or
you might be missing an interrupt controller entirely in your design)

BTW, I wouldn't bother with getting EDK to patch your kernel tree.
You're better off to generate the BSP into an empty directory and just
copy in your custom xparams file.  The EDK patching is fragile if you
don't use exactly the right kernel version.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
