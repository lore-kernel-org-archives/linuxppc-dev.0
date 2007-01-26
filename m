Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8A109DE014
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 18:25:40 +1100 (EST)
In-Reply-To: <Pine.LNX.4.60.0701252333210.13557@poirot.grange>
References: <Pine.LNX.4.60.0701252333210.13557@poirot.grange>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EB5DC4AE-E872-432E-A078-79A4385D6D52@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 82xx CPU features
Date: Fri, 26 Jan 2007 01:24:43 -0600
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 25, 2007, at 4:39 PM, Guennadi Liakhovetski wrote:

> Hi all
>
> wandering around the idle code, noticed the following:
>
> #define CPU_FTRS_603	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
> 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
> 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_PPC_LE)
>
> ...
>
> #define CPU_FTRS_82XX	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
> 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB)
>
> Whereas even in
>
> static struct cpu_spec cpu_specs[] = {
> ...
> 	{	/* 82xx (8240, 8245, 8260 are all 603e cores) */
> ...
>
> So, wanted to ask - is there a specific reason why  
> CPU_FTR_MAYBE_CAN_NAP
> is not set for 82xx (as well as CPU_FTR_PPC_LE for that matter...)

For _CAN_NAP, I'm guessing its historic, maybe Dan knows why it  
wasn't set.  What happens if you try to set it?  Are there  
implications at the system level with regards to _CAN_NAP?

I'm looking at the CPU_FTR_PPC_LE it varies if we should use _PPC_LE  
vs _TRUE_LE (or whatever the other one is called).

- k
