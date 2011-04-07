Return-Path: <nacc@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5FA691007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Apr 2011 04:12:03 +1000 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p37Hp5Eo000792
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Apr 2011 13:51:05 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D173338C803E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Apr 2011 14:11:50 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p37IBwAe2809942
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Apr 2011 14:11:58 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p37IBvce026446
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Apr 2011 15:11:57 -0300
Date: Thu, 7 Apr 2011 11:11:49 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] rtas: Only sleep in rtas_busy_delay if we have useful
	work to do
Message-ID: <20110407181149.GA3851@us.ibm.com>
References: <20110407215407.4f6ca50f@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110407215407.4f6ca50f@kryten>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07.04.2011 [21:54:07 +1000], Anton Blanchard wrote:
> 
> RTAS returns extended error codes as a hint of how long the
> OS might want to wait before retrying a call. If we have nothing
> else useful to do we may as well call back straight away.
> 
> This was found when testing the new dynamic dma window feature.
> Firmware split the zeroing of the TCE table into 32k chunks but
> returned 9901 (which is a suggested wait of 10ms). All up this took
> about 10 minutes to complete since msleep is jiffies based and will
> round 10ms up to 20ms.
> 
> With the patch below we take 3 seconds to complete the same test.
> The hint firmware is returning in the RTAS call should definitely
> be decreased, but even if we slept 1ms each iteration this would
> take 32s.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Acked-by: Nishanth Aravamudan <nacc@us.ibm.com>

> ---
> 
> Index: linux-2.6/arch/powerpc/kernel/rtas.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/kernel/rtas.c	2011-04-05 11:19:35.023234011 +1000
> +++ linux-2.6/arch/powerpc/kernel/rtas.c	2011-04-07 21:25:24.646414629 +1000
> @@ -494,7 +494,7 @@ unsigned int rtas_busy_delay(int status)
> 
>  	might_sleep();
>  	ms = rtas_busy_delay_time(status);
> -	if (ms)
> +	if (ms && need_resched())
>  		msleep(ms);
> 
>  	return ms;
