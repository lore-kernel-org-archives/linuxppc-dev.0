Return-Path: <dhlii@dlasys.net>
Received: from xm.dlasys.net (unknown [24.152.213.223])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A74DF681BE
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Nov 2005 17:58:20 +1100 (EST)
Message-ID: <438AA839.4040006@dlasys.net>
Date: Mon, 28 Nov 2005 01:48:25 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: grave@ipno.in2p3.fr,
 linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: porting linux ppc on custom board, stuck in timer loop ?
Reply-To: dhlii@comcast.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Xavier;
	I am having/had the exact same problem on a Xilinx VI based system and 2.6.12-2.6.14.2
I was eventually able to resolve it by removing MSR_ME from MSR_KERNEL. After that I have been able to successfully boot through to 
starting init where I am hanging now. I beleive I do not have a working timer and that may be related to the problem with Machine Check Exceptions.

	Were you ever able to resolve your problem aside from switching to 2.4.20, and if so what solution did you come up with ?


>Hi !

>I still try to port linux ppc on our ppc405 based hardware, after a look
>at xilinx_ml300.c file that gives the list of function calls I wait for
>a call to start_kernel but I found that start_kernel is never reached...
>In fact the code in head_4xx.S jumps to 0x00001000 which is Decrementer
>exception :

	
>/* Now turn on the MMU for real! */
>	lis	r4,MSR_KERNEL at h <https://ozlabs.org/mailman/listinfo/linuxppc-dev>
>	ori	r4,r4,MSR_KERNEL at l <https://ozlabs.org/mailman/listinfo/linuxppc-dev>
>	lis	r3,start_kernel at h <https://ozlabs.org/mailman/listinfo/linuxppc-dev>
>	ori	r3,r3,start_kernel at l <https://ozlabs.org/mailman/listinfo/linuxppc-dev>
>	mtspr	SPRN_SRR0,r3
>	mtspr	SPRN_SRR1,r4
>	rfi			/* enable MMU and jump to start_kernel */
>	b	.		/* prevent prefetch past rfi */

>Is this my hardware implementation that is incorrect ? Or I missed
>something in my kernel configuration ?

>Thanks in advance for any answer...

>xavier
