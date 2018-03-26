Return-Path: <okaya@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408v1Q2CdBzF1wc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 23:42:33 +1100 (AEDT)
Subject: Re: RFC on writel and writel_relaxed
From: Sinan Kaya <okaya@codeaurora.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Oliver <oohall@gmail.com>, linuxppc dev list
 <linuxppc-dev@lists.ozlabs.org>, linux-rdma@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>
References: <3611eabe-2999-1482-b2b4-6d216bbe4762@codeaurora.org>
 <CAOSf1CFmoK2XSn0=qAtiVEO9t4i-DHGgfieiedDfuO6E3tpkQw@mail.gmail.com>
 <4e5c745a-8b9b-959e-8893-d99cd6032484@codeaurora.org>
 <1521692689.16434.293.camel@kernel.crashing.org>
 <CAOSf1CFv1HHCL3YOVhRn2U=grdNjaQ=A4m3xwxN2Rek1-_TySg@mail.gmail.com>
 <1521726722.16434.312.camel@kernel.crashing.org>
 <5ccdb208-4664-0a7f-df5d-2e12cbe4c239@codeaurora.org>
 <1521764168.16434.324.camel@kernel.crashing.org>
 <20180326114449.GC6579@arm.com>
 <495123579cbc031ca7f1a6b0b305db18@codeaurora.org>
Message-ID: <49283e2d-7ca8-a020-5fc6-5f5d5d0ef4e5@codeaurora.org>
Date: Mon, 26 Mar 2018 08:42:28 -0400
MIME-Version: 1.0
In-Reply-To: <495123579cbc031ca7f1a6b0b305db18@codeaurora.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/26/2018 8:11 AM, okaya@codeaurora.org wrote:
> On 2018-03-26 07:44, Will Deacon wrote:
>> Hi Ben,
>>
>> I don't seem to have the beginning of this thread, so please bounce it over
>> if you'd like me to look at it!
>>
> 
> https://www.spinics.net/lists/linux-rdma/msg62570.html
> 
> https://www.spinics.net/lists/linux-rdma/index.html#62666
> 

To add some more details on why we are looking at this now:

I posted several patches last week to remove duplicate barriers on ARM while
trying to make the code friendly with other architectures.

https://www.spinics.net/lists/netdev/msg491842.html
https://www.spinics.net/lists/linux-rdma/msg62434.html
https://www.spinics.net/lists/arm-kernel/msg642336.html

The conversation on this thread is interesting.

https://patchwork.kernel.org/patch/10288987/

1. I tried to replace wmb()+writel() with wmb()+writel_relaxed().
2. writel_relaxed() is equal to writel() at this moment for PPC.
3. Chelsio developers wanted to pull it into wmb()+__raw_writel() direction
to take advantage of the same optimization for PPC.
4. Dave informed us that behavior of __raw_write() is not identical on all
architectures.
5. We decided to go back to PPC and ask to implement writel_relaxed()
instead of coming up with writel_realy_relaxed() API.

> 
>> On Fri, Mar 23, 2018 at 11:16:08AM +1100, Benjamin Herrenschmidt wrote:
>>> On Thu, 2018-03-22 at 12:51 -0500, Sinan Kaya wrote:
>>> > On 3/22/2018 8:52 AM, Benjamin Herrenschmidt wrote:
>>> > > > > No, it's not sufficient.
>>> > >
>>> > > Just to clarify ... barrier() is just a compiler barrier, it means the
>>> > > compiler will generate things in the order they are written. This isn't
>>> > > sufficient on archs with an OO memory model, where an actual memory
>>> > > barrier instruction needs to be emited.
>>> >
>>> > Surprisingly, ARM64 GCC compiler generates a write barrier as
>>> > opposed to preventing code reordering.
>>
>> In context, this looks like a misunderstanding somewhere. barrier() is a
>> compiler barrier for us just like everybody else and we use the generic
>> implementation with the empty asm + memory clobber.
>>
> 
> True, I clarified it this weekend
> 
> https://www.spinics.net/lists/linux-rdma/msg62788.html
> 
> 
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
