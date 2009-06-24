Return-Path: <jschopp@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6B8FCB70A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Jun 2009 02:39:19 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5OGYRPv026906
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2009 12:34:27 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5OGdEXB207084
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2009 12:39:14 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5OGdEhr021774
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2009 12:39:14 -0400
Message-ID: <4A4256AD.3080507@austin.ibm.com>
Date: Wed, 24 Jun 2009 11:39:09 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Gautham R Shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] pseries: cpu: Reduce the polling interval in __cpu_up()
References: <20090624092637.32078.88042.stgit@sofia.in.ibm.com>
In-Reply-To: <20090624092637.32078.88042.stgit@sofia.in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Nathan Lynch <ntl@pobox.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> The code needs testing on other powerpc platforms.
>   
I think given the numbers you showed this is a good improvement, and it 
clearly can't do any harm on platforms that implement msleep correctly.

For what it's worth:
Acked-by: Joel Schopp <jschopp@austin.ibm.com>
> Signed-off-by: Gautham R Shenoy <ego@in.ibm.com>
> ---
>  arch/powerpc/kernel/smp.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 65484b2..00c13a1 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -411,9 +411,8 @@ int __cpuinit __cpu_up(unsigned int cpu)
>  		 * CPUs can take much longer to come up in the
>  		 * hotplug case.  Wait five seconds.
>  		 */
> -		for (c = 25; c && !cpu_callin_map[cpu]; c--) {
> -			msleep(200);
> -		}
> +		for (c = 5000; c && !cpu_callin_map[cpu]; c--)
> +			msleep(1);
>  #endif
>  
>  	if (!cpu_callin_map[cpu]) {
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>   
