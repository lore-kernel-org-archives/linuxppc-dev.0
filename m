Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 032552C0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 05:23:25 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Wed, 26 Jun 2013 00:46:19 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id EB762E0058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 00:52:49 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5PJNWWe25821280
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 00:53:32 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5PJNFuo030711
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 05:23:17 +1000
Message-ID: <51C9ED61.1060306@linux.vnet.ibm.com>
Date: Wed, 26 Jun 2013 00:50:01 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 40/45] powerpc, irq: Use GFP_ATOMIC allocations in atomic
 context
References: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
 <20130623134657.19094.93687.stgit@srivatsabhat.in.ibm.com>
 <20130625020842.GD14051@concordia> <1372126384.3944.177.camel@pasglop>
 <20130625025858.GE14051@concordia> <1372130007.3944.185.camel@pasglop>
In-Reply-To: <1372130007.3944.185.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: peterz@infradead.org, fweisbec@gmail.com, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, walken@google.com, mingo@kernel.org,
 linux-arch@vger.kernel.org, vincent.guittot@linaro.org,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 Ian Munsie <imunsie@au1.ibm.com>, namhyung@kernel.org, tglx@linutronix.de,
 laijs@cn.fujitsu.com, zhong@linux.vnet.ibm.com, netdev@vger.kernel.org,
 oleg@redhat.com, sbw@mit.edu, tj@kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/25/2013 08:43 AM, Benjamin Herrenschmidt wrote:
> On Tue, 2013-06-25 at 12:58 +1000, Michael Ellerman wrote:
>> On Tue, Jun 25, 2013 at 12:13:04PM +1000, Benjamin Herrenschmidt wrote:
>>> On Tue, 2013-06-25 at 12:08 +1000, Michael Ellerman wrote:
>>>> We're not checking for allocation failure, which we should be.
>>>>
>>>> But this code is only used on powermac and 85xx, so it should probably
>>>> just be a TODO to fix this up to handle the failure.
>>>
>>> And what can we do if they fail ?
>>
>> Fail up the chain and not unplug the CPU presumably.
> 
> BTW. Isn't Srivatsa series removing the need to stop_machine() for
> unplug ? 

Yes.

That should mean we should be able to use GFP_KERNEL no ?

No, because whatever code was being executed in stop_machine() context
would still be executed with interrupts disabled. So allocations that
can sleep would continue to be forbidden in this path.

In the CPU unplug sequence, the CPU_DYING notifications (and the surrounding
code) is guaranteed to be run:
a. _on_ the CPU going offline
b. with interrupts disabled on that CPU.

My patchset will retain these guarantees even after removing stop_machine().
And these are required for the correct execution of the code in this path,
since they rely on these semantics.

So I guess I'll retain the patch as it is. Thank you!

Regards,
Srivatsa S. Bhat
