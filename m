Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BA067B6F12
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 16:38:17 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp09.au.ibm.com (8.14.3/8.13.1) with ESMTP id nBGGcIwk014387
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2009 03:38:18 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBG5cH4h1769604
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 16:38:17 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBG5cGd6006307
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 16:38:16 +1100
Message-ID: <4B287242.5070002@in.ibm.com>
Date: Wed, 16 Dec 2009 11:08:10 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Next] CPU Hotplug test failures on powerpc
References: <4B2224C7.1020908@in.ibm.com> <1260786122.4165.142.camel@twins>
	<4B261D7A.9040802@in.ibm.com> <1260793182.4165.223.camel@twins>
	<1260825420.2217.40.camel@pasglop>
	<4B275A6B.9030200@in.ibm.com> <1260873827.4165.362.camel@twins>
	<4B279370.5050800@in.ibm.com> <1260889402.4165.434.camel@twins>
In-Reply-To: <1260889402.4165.434.camel@twins>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Ingo Molnar <mingo@elte.hu>, linux-next@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter Zijlstra wrote:
> Could you try the below?
>   
No luck. Still the same issue. The mask values don't change.

Thanks
-Sachin

> ---
>  init/main.c |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)
>
> diff --git a/init/main.c b/init/main.c
> index 4051d75..4be7de2 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -369,12 +369,6 @@ static void __init smp_init(void)
>  {
>  	unsigned int cpu;
>  
> -	/*
> -	 * Set up the current CPU as possible to migrate to.
> -	 * The other ones will be done by cpu_up/cpu_down()
> -	 */
> -	set_cpu_active(smp_processor_id(), true);
> -
>  	/* FIXME: This should be done in userspace --RR */
>  	for_each_present_cpu(cpu) {
>  		if (num_online_cpus() >= setup_max_cpus)
> @@ -486,6 +480,7 @@ static void __init boot_cpu_init(void)
>  	int cpu = smp_processor_id();
>  	/* Mark the boot cpu "present", "online" etc for SMP and UP case */
>  	set_cpu_online(cpu, true);
> +	set_cpu_active(cpu, true);
>  	set_cpu_present(cpu, true);
>  	set_cpu_possible(cpu, true);
>  }
>
>
>   


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
