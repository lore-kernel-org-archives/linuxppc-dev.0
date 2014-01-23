Return-Path: <cody@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id ABCC72C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jan 2014 11:12:01 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Wed, 22 Jan 2014 17:11:58 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id CD48419D8051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 17:11:45 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0N0BfxF8978756
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jan 2014 01:11:41 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s0N0FDgg016115
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 17:15:13 -0700
Message-ID: <52E05E49.3010903@linux.vnet.ibm.com>
Date: Wed, 22 Jan 2014 16:11:53 -0800
From: Cody P Schafer <cody@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 0/8] Add support for PowerPC Hypervisor supplied
 performance counters
References: <1389916434-2288-1-git-send-email-cody@linux.vnet.ibm.com>
 <1390354379.11104.3.camel@concordia>
In-Reply-To: <1390354379.11104.3.camel@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/21/2014 05:32 PM, Michael Ellerman wrote:
> On Thu, 2014-01-16 at 15:53 -0800, Cody P Schafer wrote:
>> These patches add basic pmus for 2 powerpc hypervisor interfaces to obtain
>> performance counters: gpci ("get performance counter info") and 24x7.
>>
>> The counters supplied by these interfaces are continually counting and never
>> need to be (and cannot be) disabled or enabled. They additionally do not
>> generate any interrupts. This makes them in some regards similar to software
>> counters, and as a result their implimentation shares some common code (which
>> an initial patch exposes) with the sw counters.
> 
> Hi Cody,
> 
> Can you please add some more explanation of this series.
Sure
 > In particular why do we need two new PMUs, and how do they relate to each
> other?
These 2 PMUs end up providing access to some cpu, core, and chip level counters not
exposed via other interfaces, and additionally allow monitoring the performance of
other lpars (guests) on the same host system. Because it provides access to core and
chip level counters, this pair of PMUs could be thought of as powerpc's counterpart
to x86's uncore events.

As an example, "processor_bus_utilization_abc" and "processor_bus_utilization_wxyz"
(in hv_gpci.h) allow retreval of total cycles and idle cycles for various inter-chip buses.

GPCI is an interface that already exists on some power7 machines (depending on the fw
version), but is rather in-flexible and code intensive to add additional counters to.
The 24x7 interfaces currently are designed to co-exist with the gpci interface while
replacing most of gpci's functionality on newer systems. Right now, the 24x7 code I've
submitted uses the gpci calls to check if it has permission to access certain classes
of counters.

> And can you add an example of how I'd actually use them using perf.

# For gpci (formed from reading hv_gpci.h), gets "processor_time_in_timebase_cycles"
perf stat -e 'hv_gpci/counter_info_version=3,offset=0,length=8,secondary_index=0,starting_index=0xffffffff,request=0x10/' -r 0 -a -x ' ' sleep 0.1

# For 24x7, assuming access to hw+fw that supports it, gets a yet-to-be identified counter:
perf stat -e 'hv_24x7/domain=2,offset=8,starting_index=0,lpar=0xffffffff/' -r 0 -C 0 -x ' ' sleep 0.1
