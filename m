Return-Path: <Bo.Liu@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 692B9B7BA6
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Nov 2009 15:15:20 +1100 (EST)
Message-ID: <4AF234D6.5060805@windriver.com>
Date: Thu, 05 Nov 2009 10:13:42 +0800
From: Tonyliu <Bo.Liu@windriver.com>
MIME-Version: 1.0
To: "wilbur.chan" <wilbur512@gmail.com>
Subject: Re: ppc rfi in head.s result in a reset?
References: <e997b7420910161821g3d71c5fcy6fbf72f40d52c1c3@mail.gmail.com>
In-Reply-To: <e997b7420910161821g3d71c5fcy6fbf72f40d52c1c3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Reply-To: Bo.Liu@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

wilbur.chan wrote:
> ppc 6xx
>
> In platform_init function of  sandpoint.c , I delete the code of
> getting command line from uboot, and set command_line to a fixed value
> , which are like this:
>
>             sandpoint.c-->  platform_init
>                  #if 0
>                  if (r3 && r6) {
> 		/* copy board info structure */
> 		memcpy( (void *)__res,(void *)(r3+KERNELBASE), sizeof(bd_t) );
> 		/* copy command line */
> 		*(char *)(r7+KERNELBASE) = 0;
> 		strcpy(cmd_line, (char *)(r6+KERNELBASE));
> 	}
>                 #endif
>                 strcpy(cmd_line, "xxx");
>
>   
Which version your kernel is ? I cant find sandpoint.c in powerpc git tree.
And I suspect it's conditional  "if (r3 && r6)" to copy cmd_line, and 
your change makes it unconditioned. Maybe it
will affect something.

Tony
> But I found that , when calling start_kernel in head.S (by rfi
> instruction), the borad was reset into uboot, that is :
>
>                 li              r4,MSR_KERNEL
> 	FIX_SRR1(r4,r5)
> 	lis	r3,start_kernel@h
> 	ori	r3,r3,start_kernel@l
> 	mtspr	SPRN_SRR0,r3
> 	mtspr	SPRN_SRR1,r4
> 	SYNC
> 	RFI              //reset,why?
>
>
> The RFI  instruction  here, caused the board reset to uboot.  Can
> someone give me some advice on how could this happened?
>
> Thank you
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>   


-- 
Tony Liu | Liu Bo
-------------------------------------------------------------
WIND RIVER | China Development Center
Tel: 86-10-8477-8542 ext: 8542 |  Fax: 86-10-64790367
(M): 86-136-7117-3612
Address: 15/F, Wangjing TowerB, Chaoyang District, Beijing, P.R.China
