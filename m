Return-Path: <srs0=m5y3=3p=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w06N70v5XzDqHl
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Apr 2017 03:42:15 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w06N65K9Xz8sxT
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Apr 2017 03:42:14 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w06N61P5gz9s7m
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Apr 2017 03:42:12 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v37HcdKe020956
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2017 13:42:10 -0400
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29p5rr711k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 07 Apr 2017 13:42:10 -0400
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 7 Apr 2017 23:12:07 +0530
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v37HeiGP16646346
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2017 23:10:44 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v37Hg334023238
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2017 23:12:04 +0530
Subject: Re: [PATCH v2 1/2] fadump: reduce memory consumption for capture
 kernel
To: Michael Ellerman <mpe@ellerman.id.au>
References: <148647105867.9464.16492047069430229118.stgit@hbathini.in.ibm.com>
 <878tnd7zim.fsf@concordia.ellerman.id.au>
 <d50dfb98-68ac-0135-8e65-560aec1d752e@linux.vnet.ibm.com>
 <87efx4gwk2.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Fri, 7 Apr 2017 23:11:54 +0530
MIME-Version: 1.0
In-Reply-To: <87efx4gwk2.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <a52dc3ad-d2ac-e228-2231-7c725167965d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,


On Friday 07 April 2017 07:16 PM, Michael Ellerman wrote:
> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
>> On Friday 07 April 2017 07:24 AM, Michael Ellerman wrote:
>>> My preference would be that the fadump kernel "just works". If it's
>>> using too much memory then the fadump kernel should do whatever it needs
>>> to use less memory, eg. shrinking nr_cpu_ids etc.
>>> Do we actually know *why* the fadump kernel is running out of memory?
>>> Obviously large numbers of CPUs is one of the main drivers (lots of
>>> stacks required). But other than that what is causing the memory
>>> pressure? I would like some data on that before we proceed.
>> Almost the same amount of memory in comparison with the memory
>> required to boot the production kernel but that is unwarranted for fadump
>> (dump capture) kernel.
> That's not data! :)

I am collating the data. Sorry! I should have mentioned it :)

> The dump kernel is booted with *much* less memory than the production
> kernel (that's the whole issue!) and so it doesn't need to create struct
> pages for all that memory, which means it should need less memory.

What I meant was, if we were to boot production kernel with mem=X, where 
X is
the smallest possible value to boot the kernel without resulting in an 
OOM, fadump
needed nearly the same amount to be reserved for it to capture dump without
hitting an OOM. But this was an observation on system with not so much 
memory.
Will try on a system with large memory and report back with data..

>
> The vfs caches are also sized based on the available memory, so they
> should also shrink in the dump kernel.
>
> I want some actual numbers on what's driving the memory usage.
>
> I tried some of these parameters to see how much memory they would save:
>
>> So, if parameters like
>> cgroup_disable=memory,
> 0 bytes saved.

Interesting.. was CONFIG_MEMCG set on the kernel?

>
>> transparent_hugepages=never,
> 0 bytes saved.

Not surprising unless transparent hugepages were used

>> numa=off,
> 64KB saved.

In the memory starved dump capture environment, every byte counts, I 
guess :)
Also, depends on the numa config?

>> nr_cpus=1,
> 3MB saved (vs 16 CPUs)
>
>
> Now maybe on your system those do save memory for some reason, but
> please prove it to me. Otherwise I'm inclined to merge:
>
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 8ff0dd4e77a7..03f1f253c372 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -79,8 +79,10 @@ int __init early_init_dt_scan_fw_dump(unsigned long node,
>   	 * dump data waiting for us.
>   	 */
>   	fdm_active = of_get_flat_dt_prop(node, "ibm,kernel-dump", NULL);
> -	if (fdm_active)
> +	if (fdm_active) {
>   		fw_dump.dump_active = 1;
> +		nr_cpu_ids = 1;
> +	}
>
>   	/* Get the sizes required to store dump data for the firmware provided
>   	 * dump sections.

Necessary but not sufficient is the point I am trying to make. 
Apparently not
convincing enough. Will try and come back with relevant data :)

Thanks
Hari
