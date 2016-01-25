Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D69731A1914
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 05:43:02 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 25 Jan 2016 11:43:00 -0700
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id C07F219D804A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 11:30:58 -0700 (MST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0PIgwnE34209978
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 18:42:58 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0PIc3a7007488
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 13:38:05 -0500
Subject: Re: [PATCH] powerpc/mm: Allow user space to map rtas_rmo_buf
To: Denis Kirjanov <kda@linux-powerpc.org>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <1453392931-20707-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <1453440564.21683.8.camel@ellerman.id.au>
 <56A1CC1C.3000009@linux.vnet.ibm.com>
 <1453451744.24910.4.camel@ellerman.id.au>
 <CAOJe8K2nE-49zBrCNrwNoepccv5UZ2SvdX0Ut_2XtzMhJd2T7Q@mail.gmail.com>
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Dan Williams <dan.j.williams@intel.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Message-ID: <56A66CAD.9040707@linux.vnet.ibm.com>
Date: Mon, 25 Jan 2016 12:42:53 -0600
MIME-Version: 1.0
In-Reply-To: <CAOJe8K2nE-49zBrCNrwNoepccv5UZ2SvdX0Ut_2XtzMhJd2T7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/22/2016 04:41 AM, Denis Kirjanov wrote:
> On 1/22/16, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> On Fri, 2016-01-22 at 11:58 +0530, Vasant Hegde wrote:
>>> On 01/22/2016 10:59 AM, Michael Ellerman wrote:
>>>> On Thu, 2016-01-21 at 21:45 +0530, Vasant Hegde wrote:
>>>>
>>>>> With commit 90a545e9 (restrict /dev/mem to idle io memory ranges)
>>>>> mapping
>>>>> rtas_rmo_buf from user space is failing. Hence we are not able to make
>>>>> RTAS syscall.
>>>>
>>>> Having said that, why the <expletive deleted> is librtas mapping
>>>> /dev/mem in
>>>> the first place? Unless there is a very good reason, and probably even
>>>> if there
>>>> is, we should fix that to use a sane API.
>>>
>>> We use rtas system call. We use /dev/mem interface to map the RTAS memory
>>> region
>>> (allocated by kernel and information is passed to user space via procfs)
>>> so that
>>> we can read/write to RTAS memory.
>>>
>>> I do not have historical information. May be Nathan has more information
>>> on this.
>>
>> Yeah, we need to dig into what it's actually doing and why. I had a quick
>> look
>> but it wasn't obvious.
>>
>> We should not need 1) a system call, 2) a proc interface, and 3) a mmap of
>> /dev/mem.
>>
>> If the syscall's not sufficient and we really need to mmap, we should create
>> a
>> device which can then be mmapped in a more standard way.
>>
>> Having said that, Nathan's been moving more of the hotplug logic into the
>> kernel, so I'm also not clear on how much of the existing API we will need
>> in
>> the future. So yep hopefully Nathan can chime in.
> 
> Yeah, but if we're going to move to only one interface to work with
> RTAS we can break existing applications.
> 

Yes, but I doubt that anything other than librtas is using this. I don't think
this interface was ever documented anywhere.

-Nathan

>>
>> cheers
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
