Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xylxW0yH5zDrJL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 04:48:30 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8LIhZBw024793
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 14:48:28 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2d4bwmrj9q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 14:48:28 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 21 Sep 2017 12:48:27 -0600
Subject: Re: [mainline][DLPAR][Oops] OF: ERROR: Bad of_node_put() on /cpus
To: Michael Ellerman <mpe@ellerman.id.au>, Rob Herring <robh@kernel.org>,
 abdul <abdhalee@linux.vnet.ibm.com>
Cc: sachinp <sachinp@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <1505473476.9665.13.camel@abdul.in.ibm.com>
 <CAL_JsqLXpU3kr7bD0NYZhYBbzxmGzqPL3j0jfLLMpSmXwPGvOw@mail.gmail.com>
 <87bmm5lhuu.fsf@concordia.ellerman.id.au>
 <3c15ac5c-c966-be45-1a6c-ba3fa1b9e439@linux.vnet.ibm.com>
 <87fubgcr2g.fsf@concordia.ellerman.id.au>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Thu, 21 Sep 2017 11:48:22 -0700
MIME-Version: 1.0
In-Reply-To: <87fubgcr2g.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <bef5b448-cc23-a656-7048-3d74ef82f508@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/21/2017 02:57 AM, Michael Ellerman wrote:
> Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
>> On 09/20/2017 04:39 AM, Michael Ellerman wrote:
>>> Rob Herring <robh@kernel.org> writes:

<snip>

>>>
>>> Testing a fix, will report back.
>>
>> So, that patch slipped past me. Not only is the parent reference not ours to drop, but
>> when I went and looked at dlpar_cpu_add() I also noticed that of_node_put() was done on
>> the parent prior to the call to dlpar_attach_node(). With the addition of "parent" to the
>> dlpar_attach_node() parameter list dlpar_cpu_add() needs to be fixed up to hold the
>> "parent" reference until after dlpar_attach_node() returns.
> 
> Yep. I wrote the same patch :)
> 
> Rob asked me to test it, which I did, but /cpus starts out with an
> elevated ref count, so you have to do ~30 (on my system) DLPAR removes
> to hit the bug, which I didn't do.

Yeah, there are a lot of things that grab references to /cpus. So, I had a good idea that
I needed to loop a few times adding and removing multiple cpus to trigger the issue. Its
also obvious when using those OF trace points I wrote a while back that refcount for /cpus
is dropping off uncharacteristically in response to symmetrical adds/removes of cpus. I
saw your note about getting that patchset resubmitted. I'll try and get that queued back
up soon.

-Tyrel

> 
> I've updated my test script to do roughly $(nproc) x 10 DLPAR removes,
> which is hopefully sufficient to catch these bugs in future.
> 
> cheers
> 
