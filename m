Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D03C067BC8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Oct 2006 23:39:26 +1000 (EST)
In-Reply-To: <54A124D27BDE0F449E2032F42ED617583197A6@zch01exm21.fsl.freescale.net>
References: <54A124D27BDE0F449E2032F42ED617583197A6@zch01exm21.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0EE06CE5-98CB-49BB-A398-DF0E3277125D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: About the RFI instruction on Linux Powerpc
Date: Wed, 18 Oct 2006 08:39:23 -0500
To: Wang Matthew-R59995 <Qi.W@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 18, 2006, at 7:49 AM, Wang Matthew-R59995 wrote:

> Hi folks,
>
> Currently I meet an issue about rfi instruction. Please see the  
> following source code. This source code is contained at the  
> head_fsl_booke.h of ./arch/powerpc/kernel directory.
>
>  xori r6,r4,1
>  slwi r6,r6,5  /* setup new context with other address space */
>  bl 1f  /* Find our address */
> 1: mflr r9
>  rlwimi r7,r9,0,20,31
>  addi r7,r7,24
>  mtspr SPRN_SRR0,r7
>  mtspr SPRN_SRR1,r6
>  rfi
> I found that rfi instruction can't jump to the address of SRR0. I  
> take the MPC8555CDS board to do those test. And I don't take U-Boot  
> as bootloader, while the Vxwerks Bootrom.
>
> I just want to try if Bootrom can bring up the Linux Powerpc kernel.
>
> Any suggestion for that?

What does happen after the rfi instruction?  Do you have a JTAG  
debugger or something you can use to single step through this code?   
Do you know the value of r9?

There are some expectations as to what's setup by the bootloader when  
you jump into the kernel.  They are pretty minimal but I dont know if  
the VxWorks Bootrom does the same thing as u-boot.

- kumar
