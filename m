Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 33998DE035
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 03:14:30 +1100 (EST)
In-Reply-To: <460292FA.8050206@mindspring.com>
References: <460292FA.8050206@mindspring.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E9D1DC31-9730-4431-9414-0870FDD3EAF6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: MPC83xx SDMR setup error
Date: Thu, 22 Mar 2007 11:13:52 -0500
To: Chuck Meade <chuckmeade@mindspring.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 22, 2007, at 9:30 AM, Chuck Meade wrote:

> There appears to be an error in the MPC83xx SDMR setup in
> arch/powerpc/sysdev/qe_lib/qe.c line 259.  Since 0x1 shifted right  
> 13 bits
> (QE_SDMR_CEN_SHIFT) will always be zero, the CEN field will be set to
> zero.  This means the SDMR buffer size will always be 512, rather than
> the intended (and allocated) 1024 bytes.

What does this effect?  I agree the code is wrong.

> In addition, and not shown in the patch below, there is a conflict  
> in the
> alignment requirement for the value to be written to the SDEBCR  
> register.
> The SDEBCR holds the address in MURAM of the buffer to be used by  
> the SDMA
> controller.  In the MPC8323ERM.pdf section 18.1.7 titled "SDMA  
> Internal
> Resource", it states that "the base address must be aligned to a  
> 4KByte
> boundary."  However, later in the description of the SDEBCR in section
> 18.1.8.9, it states that the address must be "64 bytes aligned".   
> The code
> in arch/powerpc/sysdev/qe_lib/qe.c (line 254) that allocates this  
> buffer
> aligns it to a 64-byte boundary.  This is only correct if the  
> manual section
> 18.1.7, which requires a 4KByte alignment, is wrong.  Which manual  
> section
> is correct?

Hopefully someone at freescale will know.  I'd suggest possibly  
posting a support request to them to see if you can get a  
clarification since their UM is not self-consistent on the details.

> Chuck
>
> --- a/linux-2.6/arch/powerpc/sysdev/qe_lib/qe.c	2007-01-13  
> 09:37:03.000000000 -0500
> +++ b/linux-2.6/arch/powerpc/sysdev/qe_lib/qe.c	2007-03-22  
> 09:48:46.000000000 -0400
> @@ -256,7 +256,7 @@ static int qe_sdma_init(void)
>   		return -ENOMEM;
>
>   	out_be32(&sdma->sdebcr, sdma_buf_offset & QE_SDEBCR_BA_MASK);
> -	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK | (0x1 >>
> +	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK | (0x1 <<
>   					QE_SDMR_CEN_SHIFT)));
>
>   	return 0;
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
