Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xzBq22jqgzDqjC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 21:59:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>,
 abdul <abdhalee@linux.vnet.ibm.com>
Cc: sachinp <sachinp@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [mainline][DLPAR][Oops] OF: ERROR: Bad of_node_put() on /cpus
In-Reply-To: <bef5b448-cc23-a656-7048-3d74ef82f508@linux.vnet.ibm.com>
References: <1505473476.9665.13.camel@abdul.in.ibm.com>
 <CAL_JsqLXpU3kr7bD0NYZhYBbzxmGzqPL3j0jfLLMpSmXwPGvOw@mail.gmail.com>
 <87bmm5lhuu.fsf@concordia.ellerman.id.au>
 <3c15ac5c-c966-be45-1a6c-ba3fa1b9e439@linux.vnet.ibm.com>
 <87fubgcr2g.fsf@concordia.ellerman.id.au>
 <bef5b448-cc23-a656-7048-3d74ef82f508@linux.vnet.ibm.com>
Date: Fri, 22 Sep 2017 21:59:24 +1000
Message-ID: <87shfft04j.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:

> On 09/21/2017 02:57 AM, Michael Ellerman wrote:
>> Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
>>> On 09/20/2017 04:39 AM, Michael Ellerman wrote:
>>>> Rob Herring <robh@kernel.org> writes:
>
> <snip>
>
>>>>
>>>> Testing a fix, will report back.
>>>
>>> So, that patch slipped past me. Not only is the parent reference not ours to drop, but
>>> when I went and looked at dlpar_cpu_add() I also noticed that of_node_put() was done on
>>> the parent prior to the call to dlpar_attach_node(). With the addition of "parent" to the
>>> dlpar_attach_node() parameter list dlpar_cpu_add() needs to be fixed up to hold the
>>> "parent" reference until after dlpar_attach_node() returns.
>> 
>> Yep. I wrote the same patch :)
>> 
>> Rob asked me to test it, which I did, but /cpus starts out with an
>> elevated ref count, so you have to do ~30 (on my system) DLPAR removes
>> to hit the bug, which I didn't do.
>
> Yeah, there are a lot of things that grab references to /cpus. So, I had a good idea that
> I needed to loop a few times adding and removing multiple cpus to trigger the issue. Its
> also obvious when using those OF trace points I wrote a while back that refcount for /cpus
> is dropping off uncharacteristically in response to symmetrical adds/removes of cpus. I
> saw your note about getting that patchset resubmitted. I'll try and get that queued back
> up soon.

Thanks, it'd be great to get it in. I applied it from the list and used
it for testing this.

cheers
