Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4106B1A001D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 05:42:30 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 25 Jan 2016 13:42:28 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 011FBC90041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 13:42:25 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0PIgQDJ26411012
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 18:42:26 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0PIbVNi006754
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 13:37:33 -0500
Subject: Re: [PATCH] powerpc/mm: Allow user space to map rtas_rmo_buf
To: Michael Ellerman <mpe@ellerman.id.au>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1453392931-20707-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <1453440564.21683.8.camel@ellerman.id.au>
 <56A1CC1C.3000009@linux.vnet.ibm.com>
 <1453451744.24910.4.camel@ellerman.id.au>
Cc: Dan Williams <dan.j.williams@intel.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Message-ID: <56A66C8E.3070605@linux.vnet.ibm.com>
Date: Mon, 25 Jan 2016 12:42:22 -0600
MIME-Version: 1.0
In-Reply-To: <1453451744.24910.4.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/22/2016 02:35 AM, Michael Ellerman wrote:
> On Fri, 2016-01-22 at 11:58 +0530, Vasant Hegde wrote:
>> On 01/22/2016 10:59 AM, Michael Ellerman wrote:
>>> On Thu, 2016-01-21 at 21:45 +0530, Vasant Hegde wrote:
>>>
>>>> With commit 90a545e9 (restrict /dev/mem to idle io memory ranges) mapping
>>>> rtas_rmo_buf from user space is failing. Hence we are not able to make
>>>> RTAS syscall.
>>>
>>> Having said that, why the <expletive deleted> is librtas mapping /dev/mem in
>>> the first place? Unless there is a very good reason, and probably even if there
>>> is, we should fix that to use a sane API.
>>
>> We use rtas system call. We use /dev/mem interface to map the RTAS memory region
>> (allocated by kernel and information is passed to user space via procfs) so that
>> we can read/write to RTAS memory.
>>
>> I do not have historical information. May be Nathan has more information on this.
> 
> Yeah, we need to dig into what it's actually doing and why. I had a quick look
> but it wasn't obvious.

This was done many years ago, going on memory for now...

I will have to dig back into this code further but what I remember is that the
following process is used. At boot time a piece of low memory (buffers passed
to rtas have to be in low memory) is reserved to use for rtas calls. This memory
is made available to userspace, namely the librtas library. The code in librtas
will then reserve pieces of this memory to use for buffers when making rtas
calls that require large buffers. I think the biggest user of this is the rtas
configure-connector call which can require two 1-page buffers.

If I remember correctly this was done to avoid having the kernel do all of the
copying to/from user of the buffers used.


> 
> We should not need 1) a system call, 2) a proc interface, and 3) a mmap of
> /dev/mem.
> 

It seems that we could move to an interface that just uses a syscall and have
the kernel copy the buffers in from userspace into the kernels reserved rtas
buffer space.

> If the syscall's not sufficient and we really need to mmap, we should create a
> device which can then be mmapped in a more standard way.
> 
This would also work if having the kernel copy the buffers is not what we
want to do.

-Nathan

> Having said that, Nathan's been moving more of the hotplug logic into the
> kernel, so I'm also not clear on how much of the existing API we will need in
> the future. So yep hopefully Nathan can chime in.
> 
> cheers
> 
