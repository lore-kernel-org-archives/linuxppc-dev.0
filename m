Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYVkf2hjpzDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 23:40:10 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4PDd3gC016782
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 09:40:07 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2anyb8m1fm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 09:40:07 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 25 May 2017 09:40:06 -0400
Subject: Re: [Patch 2/2]: powerpc/hotplug/mm: Fix hot-add memory node assoc
To: Michael Ellerman <mpe@ellerman.id.au>,
 Reza Arbab <arbab@linux.vnet.ibm.com>
References: <3bb44d92-b2ff-e197-4bdf-ec6d588d6dab@linux.vnet.ibm.com>
 <20170523155251.bqwc5mc4jpgzkqlm@arbab-laptop.localdomain>
 <1c1d70e3-4e45-b035-0e75-1b0f531c111b@linux.vnet.ibm.com>
 <20170523214922.bns675oqzqj4pkhc@arbab-laptop.localdomain>
 <ee96df3d-ad0f-c4dc-e7d5-290018ec8afd@linux.vnet.ibm.com>
 <87poeya4dt.fsf@concordia.ellerman.id.au>
 <8e2417d8-d108-2949-40f2-997d53a3f367@linux.vnet.ibm.com>
 <87a861a25y.fsf@concordia.ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Bharata B Rao <bharata@linux.vnet.ib>,
 Shailendra Singh <shailendras@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Thu, 25 May 2017 08:40:00 -0500
MIME-Version: 1.0
In-Reply-To: <87a861a25y.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <847696cc-69b2-c228-20fd-132b265b50c5@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 05/25/2017 01:19 AM, Michael Ellerman wrote:
> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
> 
>> On 05/24/2017 06:19 AM, Michael Ellerman wrote:
>>> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
>>>>
>>>> With or without 3af229f2071f, we would still need to add something, somewhere to add new
>>>> bits to the 'node_possible_map'.  That is not being done.
>>>
>>> You mustn't add bits to the possible map after boot.
>>>
>>> That's its purpose, to tell you what nodes could ever *possibly* exist.
>>
>> The problem that I have been encountering is that the 'possible map' did *not*
>> show all of the possible nodes.
> 
> OK so how did that happen?
> 
> The commit message for 3af229f2071f says:
> 
>     In practice, we never see a system with 256 NUMA nodes, and in fact, we
>     do not support node hotplug on power in the first place, so the nodes
>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     that are online when we come up are the nodes that will be present for
>     the lifetime of this kernel.
> 
> Is that no longer true?

Take a look at the last part of commit 3af229f2071f for file numa.c.  It undoes
a piece of code that restricts the 'node possible map', created earlier, to the
set of online nodes.  That piece of code has not made it into the mainline, at
least not into 4.12.  I am testing to verify whether it is sufficient for my
configuration now.

> 
> cheers
> 
Regards.

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
