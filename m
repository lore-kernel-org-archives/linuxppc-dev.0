Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wZ59c1DchzDqCv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 22:32:03 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4QCTpkF085636
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 08:31:57 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ap8vrb48k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 08:31:56 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 26 May 2017 08:31:55 -0400
Subject: Re: [Patch 2/2]: powerpc/hotplug/mm: Fix hot-add memory node assoc
To: Michael Ellerman <mpe@ellerman.id.au>,
 Reza Arbab <arbab@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Shailendra Singh <shailendras@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <3bb44d92-b2ff-e197-4bdf-ec6d588d6dab@linux.vnet.ibm.com>
 <20170523155251.bqwc5mc4jpgzkqlm@arbab-laptop.localdomain>
 <1c1d70e3-4e45-b035-0e75-1b0f531c111b@linux.vnet.ibm.com>
 <20170523214922.bns675oqzqj4pkhc@arbab-laptop.localdomain>
 <ee96df3d-ad0f-c4dc-e7d5-290018ec8afd@linux.vnet.ibm.com>
 <87poeya4dt.fsf@concordia.ellerman.id.au>
 <8e2417d8-d108-2949-40f2-997d53a3f367@linux.vnet.ibm.com>
 <87a861a25y.fsf@concordia.ellerman.id.au>
 <20170525151011.m4ae4ipxbqsj3mn7@arbab-laptop.localdomain>
 <87zie08ekt.fsf@concordia.ellerman.id.au>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Fri, 26 May 2017 07:31:51 -0500
MIME-Version: 1.0
In-Reply-To: <87zie08ekt.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <0def3557-7296-916a-f7d5-441cf5f1e00c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I am running into this problem on PowerPC systems where Balbir's patch set
was targeted.  So, yes, I do need to be able to add/enable a new numa node
during system execution in cases where more resources (memory, virtual
processors) are added to the system dynamically.

On 05/25/2017 10:46 PM, Michael Ellerman wrote:
> Reza Arbab <arbab@linux.vnet.ibm.com> writes:
> 
>> On Thu, May 25, 2017 at 04:19:53PM +1000, Michael Ellerman wrote:
>>> The commit message for 3af229f2071f says:
>>>
>>>    In practice, we never see a system with 256 NUMA nodes, and in fact, we
>>>    do not support node hotplug on power in the first place, so the nodes
>>>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>    that are online when we come up are the nodes that will be present for
>>>    the lifetime of this kernel.
>>>
>>> Is that no longer true?
>>
>> I don't know what the reasoning behind that statement was at the time, 
>> but as far as I can tell, the only thing missing for node hotplug now is 
>> Balbir's patchset [1]. He fixes the resource issue which motivated 
>> 3af229f2071f and reverts it.
>>
>> With that set, I can instantiate a new numa node just by doing 
>> add_memory(nid, ...) where nid doesn't currently exist.
> 
> But does that actually happen on any real system?
> 
> cheers
> 
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
