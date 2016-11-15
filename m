Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJ82j0HCJzDvfs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 00:52:12 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAFDnLvt063816
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 08:52:10 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26qx8wgepx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 08:52:10 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Tue, 15 Nov 2016 13:52:08 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6AC0317D8042
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 13:54:29 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAFDq5rT34078824
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 13:52:05 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAFCq5VC001872
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 05:52:06 -0700
Subject: Re: [GIT PULL v2 1/5] processor.h: introduce cpu_relax_yield
To: Russell King - ARM Linux <linux@armlinux.org.uk>
References: <1477386195-32736-1-git-send-email-borntraeger@de.ibm.com>
 <1477386195-32736-2-git-send-email-borntraeger@de.ibm.com>
 <20161115123029.GT1041@n2100.armlinux.org.uk>
 <7f7850e4-c7bb-9cc1-2d65-a1555e97988a@de.ibm.com>
 <20161115133758.GV1041@n2100.armlinux.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
 linux-s390 <linux-s390@vger.kernel.org>, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Noam Camus <noamc@ezchip.com>, sparclinux@vger.kernel.org,
 x86@kernel.org, Will Deacon <will.deacon@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 virtualization@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 15 Nov 2016 14:52:03 +0100
MIME-Version: 1.0
In-Reply-To: <20161115133758.GV1041@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=windows-1252
Message-Id: <7ebfbdba-02bb-e837-dbce-6a5acaf3a374@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/15/2016 02:37 PM, Russell King - ARM Linux wrote:
> On Tue, Nov 15, 2016 at 02:19:53PM +0100, Christian Borntraeger wrote:
>> On 11/15/2016 01:30 PM, Russell King - ARM Linux wrote:
>>> On Tue, Oct 25, 2016 at 11:03:11AM +0200, Christian Borntraeger wrote:
>>>> For spinning loops people do often use barrier() or cpu_relax().
>>>> For most architectures cpu_relax and barrier are the same, but on
>>>> some architectures cpu_relax can add some latency.
>>>> For example on power,sparc64 and arc, cpu_relax can shift the CPU
>>>> towards other hardware threads in an SMT environment.
>>>> On s390 cpu_relax does even more, it uses an hypercall to the
>>>> hypervisor to give up the timeslice.
>>>> In contrast to the SMT yielding this can result in larger latencies.
>>>> In some places this latency is unwanted, so another variant
>>>> "cpu_relax_lowlatency" was introduced. Before this is used in more
>>>> and more places, lets revert the logic and provide a cpu_relax_yield
>>>> that can be called in places where yielding is more important than
>>>> latency. By default this is the same as cpu_relax on all architectures.
>>>
>>> Rather than having to update all these architectures in this way, can't
>>> we put in some linux/*.h header something like:
>>>
>>> #ifndef cpu_relax_yield
>>> #define cpu_relax_yield() cpu_relax()
>>> #endif
>>>
>>> so only those architectures that need to do something need to be
>>> modified?
>>
>> These patches are part of linux-next since a month or so, changing that 
>> would invalidate all the next testing. If people want that, I can certainly
>> do that, though.
> 
> It's three weeks since you posted them.  For one of those weeks (the
> week you posted them) I was away, and missed them while catching up.
> Sorry, but it sometimes takes a while to spot things amongst the
> backlog, and normally takes some subsequent activity on the thread to
> bring it back into view.

Absolutely no need to apologize. Thank you for doing the review and the proposal. 
I will do whatever is consensus, but since this looks like tip/locking material
I will wait for Peter or Ingo to decide about the if and how.

Christian
