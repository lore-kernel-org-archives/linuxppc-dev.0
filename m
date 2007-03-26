Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4D48FDDEEE
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Mar 2007 06:10:38 +1000 (EST)
In-Reply-To: <4602C74F.6040402@mindspring.com>
References: <460292FA.8050206@mindspring.com>	<E9D1DC31-9730-4431-9414-0870FDD3EAF6@kernel.crashing.org>	<4602BD39.9020102@mindspring.com>
	<20070322125712.2229ff99.kim.phillips@freescale.com>
	<4602C74F.6040402@mindspring.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DD2F76DD-4427-4182-B17A-B470CF14E41D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: MPC83xx SDMR setup error
Date: Mon, 26 Mar 2007 15:10:08 -0500
To: Chuck Meade <chuckmeade@mindspring.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 22, 2007, at 1:13 PM, Chuck Meade wrote:

>>> However, as I mention below, it is unclear whether the buffer  
>>> alignment
>>> requirement is 64 bytes or 4Kbytes.  The code aligns the buffer  
>>> to 64 bytes.
>> The rev.1 8360 manual changes the rev.0 manual's 64 bytes to a  
>> 4Kbytes alignment requirement, so it's probably best to go with 4KiB.
>
> Thanks for the information Kim.
>
> In light of this alignment requirement, I have updated the patch  
> and included
> it below.  The new part of the patch (the alignment change) could  
> prevent
> potentially serious problems of the SDMA using MURAM that is owned  
> by other
> units.
>
> Chuck

Can you send this with a more proper header/subject and Signed-off- 
by, according to Documentation/SubmittingPatches

- kumar

> diff -uprN a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/ 
> qe_lib/qe.c
> --- a/arch/powerpc/sysdev/qe_lib/qe.c	2007-03-22 14:00:02.000000000  
> -0400
> +++ b/arch/powerpc/sysdev/qe_lib/qe.c	2007-03-22 14:01:30.000000000  
> -0400
> @@ -251,12 +251,12 @@ static int qe_sdma_init(void)
>
>  	/* allocate 2 internal temporary buffers (512 bytes size each) for
>  	 * the SDMA */
> -	sdma_buf_offset = qe_muram_alloc(512 * 2, 64);
> +	sdma_buf_offset = qe_muram_alloc(512 * 2, 4096);
>  	if (IS_MURAM_ERR(sdma_buf_offset))
>  		return -ENOMEM;
>
>  	out_be32(&sdma->sdebcr, sdma_buf_offset & QE_SDEBCR_BA_MASK);
> -	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK | (0x1 >>
> +	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK | (0x1 <<
>  					QE_SDMR_CEN_SHIFT)));
>
>  	return 0;
