Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C69F41A08A8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 16:55:29 +1100 (AEDT)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 00D141402DD
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2015 16:55:28 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 16 Oct 2015 11:25:26 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id C9811394005C
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2015 11:25:22 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9G5tLUL4129058
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2015 11:25:22 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9G5tKr3002927
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2015 11:25:21 +0530
Message-ID: <56209148.7020507@linux.vnet.ibm.com>
Date: Fri, 16 Oct 2015 11:25:20 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: linuxppc-dev@ozlabs.org, mikey@neuling.org, nacc@linux.vnet.ibm.com
Subject: Re: [RFC] powerpc/numa: Use VPHN based node ID information on shared
 processor LPARs
References: <1444813335-4009-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1444814360.1843.1.camel@ellerman.id.au>
 <561E2AB4.3040608@linux.vnet.ibm.com>
 <1444962288.28419.2.camel@ellerman.id.au>
In-Reply-To: <1444962288.28419.2.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/16/2015 07:54 AM, Michael Ellerman wrote:
> On Wed, 2015-10-14 at 15:43 +0530, Anshuman Khandual wrote:
>> On 10/14/2015 02:49 PM, Michael Ellerman wrote:
>>> On Wed, 2015-10-14 at 14:32 +0530, Anshuman Khandual wrote:
>>>> On shared processor LPARs, H_HOME_NODE_ASSOCIATIVITY hcall provides the
>>>> dynamic virtual-physical mapping for any given processor. Currently we
>>>> use VPHN node ID information only after getting either a PRRN or a VPHN
>>>> event. But during boot time inside the function numa_setup_cpu, we still
>>>> query the OF device tree for the node ID value which might be different
>>>> than what can be fetched from the H_HOME_NODE_ASSOCIATIVITY hcall. In a
>>>> scenario where there are no PRRN or VPHN event after boot, all node-cpu
>>>> mapping will remain incorrect there after.
>>>>
>>>> With this proposed change, numa_setup_cpu will try to override the OF
>>>> device tree fetched node ID information with H_HOME_NODE_ASSOCIATIVITY
>>>> hcall fetched node ID value. Right now shared processor property of the
>>>> LPAR cannot be queried as VPA inializaion happens after numa_setup_cpu
>>>> during boot time. So initmem_init function has been moved after ppc_md.
>>>> setup_arch inside setup_arch during boot.
>>>
>>> I would be *very* reluctant to change the order of initmem_init() vs
>>> setup_arch().
>>>
>>> At a minimum you'd need to go through every setup_arch() implementation and
>>> carefully determine if the ordering of what it does matters vs initmem_init().
>>> And then you'd need to test on every affected platform.
>>>
>>> So I suggest you think of a different way to do it if at all possible.
>>
>> vpa_init() is being called inside pSeries_setup_arch which is ppc_md
>> .setup_arch for the platform. Its called directly for the boot cpu
>> and through smp_init_pseries_xics for other cpus on the system. Not
>> sure what is the reason behind calling vpa_init() from XICS init
>> though.
>>
>> If we can move all these vpa_init() calls from pSeries_setup_arch
>> to initmem_init just before calling numa_setup_cpu, the VPA area
>> would be initialized when we need it during boot. Will look in
>> this direction.
> 
> Back up a bit. The dependency on vpa_init() is only because you want to call
> lppaca_shared_proc() right?

Right.

> 
> But do you really need to? What happens if you call VPHN on a non-shared proc
> machine? Does it 1) give you something sane or 2) give you an error or 3) give
> you a junk value?
> 
> If it's either of 1 or 2 then you should be OK to just call it. You either use
> the value it returned which is sane or you see the error and just fall back to
> the device tree nid.

Most probably it will be a sane value without any error. But the
decision to override the DT fetched value will be based on whether
we are running on a shared processor LPAR or not. Hence dependency
on lppaca_shared_proc(). In case of error from VPHN on a shared
processor LPAR, we will still have the DT fetched value to fall
back on (will update the logic in the patch for this).
