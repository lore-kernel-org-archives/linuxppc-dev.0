Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wC3Zx2366zDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 23:14:33 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3PDDpcH033537
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 09:14:31 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a206m5yj4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 09:14:29 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Tue, 25 Apr 2017 23:14:11 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3PDDxss41812222
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 23:14:07 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3PDDYMD021622
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 23:13:34 +1000
Subject: Re: [PATCH v2 1/2] fadump: reduce memory consumption for capture
 kernel
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
References: <148647105867.9464.16492047069430229118.stgit@hbathini.in.ibm.com>
 <878tnd7zim.fsf@concordia.ellerman.id.au>
 <d50dfb98-68ac-0135-8e65-560aec1d752e@linux.vnet.ibm.com>
 <87efx4gwk2.fsf@concordia.ellerman.id.au>
 <e1377bf8-e574-6ffa-6b63-3748a01dcdfa@linux.vnet.ibm.com>
 <20170413215826.367dbdf0@kitsune.suse.cz>
 <c1591a61-6499-4364-9d37-a3035e0eaddf@linux.vnet.ibm.com>
 <20170418161816.20e124f0@kitsune.suse.cz>
 <878tmx6nbw.fsf@concordia.ellerman.id.au>
 <20170419160826.617d173f@kitsune.suse.cz>
 <4dcf00a6-9293-a261-9ebe-68c80ce49a83@linux.vnet.ibm.com>
 <20170424122459.31761099@kitsune.suse.cz>
 <ba8d55c0-0dd0-d72b-1fbe-5bb6bf79749b@linux.vnet.ibm.com>
 <20170424160040.2659da38@kitsune.suse.cz>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Tue, 25 Apr 2017 18:43:11 +0530
MIME-Version: 1.0
In-Reply-To: <20170424160040.2659da38@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <983a9293-e92a-64dc-6866-8bde74b20e1e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 24 April 2017 07:30 PM, Michal Suchánek wrote:
> On Mon, 24 Apr 2017 18:26:37 +0530
> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
>
>> Hi Michal.
>>
>> On Monday 24 April 2017 03:54 PM, Michal Suchánek wrote:
>>> On Fri, 21 Apr 2017 00:19:55 +0530
>>> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
>>>   
>>>> On Wednesday 19 April 2017 07:38 PM, Michal Suchánek wrote:
>>>>> On Wed, 19 Apr 2017 14:19:47 +1000
>>>>> Michael Ellerman <mpe@ellerman.id.au> wrote:
>>>>>      
>>>> With the fadump_append= approach I posted in this response thread,
>>>> additional parameters are enforced when fadump is active. If f/w
>>>> supports appending additional parameters, it has to update
>>>> chosen/bootargs whenever fadump is active. Almost the same thing
>>>> except the dirty job is now done by f/w? Hence I thought
>>>> fadump_append= kernel parameter approach is simple and lesser of
>>>> the two evils? Am i missing something here..
>>>>   
>>> The firmware already has to set the parameter by which the kernel
>>> can tell it is a fadump kernel. Hence it already modifies the
>>> devicetree for fadump and you have to rely on it to do so.
>> Right, devicetree is modified to include new 'ibm,kernel-dump' rtas
>> node informing that fadump is active.
>>
>>> The handover area which stores the additional parameters is
>>> reserved by the running kernel so now you also have to rely on the
>>> running kernel, the running kernel and fadum kernel having the same
>>> idea about the location of handover area, the crashing kernel not
>>> randomly overwriting the handover area, etc.
>>>
>>> In short it is additional potential for trouble which can be
>>> avoided.
>>>
>>> I don't know if the firmware does protect the fadump reserved area
>>> and devicetree from being randomly overwritten by the crashing
>>> kernel but it is in the position to do so if desired. The handover
>>> area is controlled by the crashing kernel and cannot have this
>>> guarantee.
>>>
>>>   
>> I thinks there is a mixup here..
>> I am no longer batting for handover area approach but
>> "fadump_append=" approach (suggested by Michael Ellerman in this
>> thread) where there is no need for a handover area but an additional
>> kernel parameter fadump_append=numa=off,nr_cpus=1.. which is a comma
>> separated list of parameters the user wants to enforce when fadump is
>> active.
>>
>> I was trying to say that passing additional parameters with
>> 'fadump_append=' kernel parameter is better over f/w changing the
>> chosen/bootargs node.
>
> Ok, so a fadump specific parameter was just removed in
> 25031865553e5a2bd9b6e0a5d044952cfa2925d8 and with this we get one back.

I think you mean commit c2afb7ce9d088696427018ba2135b898058507b8
from linux-next. If so, yes.

> If this is going to be added as an extra kernel parameter can't this be
> passed to kdump kernel as well? Does kdump not have the same
> restrictions?
>

kdump kernel is loaded with kexec and additional parameters can be 
passed to it at the
time of loading. But fadump kernel boots like a regular kernel (through 
f/w & bootloader,
resetting all the h/w) except that f/w guarantees to keep the memory 
intact. So, there is
a need for a different approach to pass additional parameters in case of 
fadump..

Thanks
Hari
