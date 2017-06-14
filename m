Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnnpd2BsQzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 23:41:13 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5EDdoHn081933
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 09:41:10 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b35c7uj3g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 09:41:10 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 14 Jun 2017 07:41:08 -0600
Subject: Re: RESEND Re: [Patch 2/2]: powerpc/hotplug/mm: Fix hot-add memory
 node assoc
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Reza Arbab <arbab@linux.vnet.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Shailendra Singh <shailendras@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michael Bringmann from Kernel Team <mbringm@us.ibm.com>
References: <3bb44d92-b2ff-e197-4bdf-ec6d588d6dab@linux.vnet.ibm.com>
 <8e2417d8-d108-2949-40f2-997d53a3f367@linux.vnet.ibm.com>
 <87a861a25y.fsf@concordia.ellerman.id.au>
 <20170525151011.m4ae4ipxbqsj3mn7@arbab-laptop.localdomain>
 <87zie08ekt.fsf@concordia.ellerman.id.au>
 <20170526143147.z4lmtrs7vowucbkf@arbab-laptop.localdomain>
 <87lgpg6xe2.fsf@concordia.ellerman.id.au>
 <54877b2b-8446-20f6-e316-25af809ae11f@linux.vnet.ibm.com>
 <87tw402go0.fsf@concordia.ellerman.id.au>
 <54ebacf1-1249-cc6a-80a5-b293e581f401@linux.vnet.ibm.com>
 <8760g9qwfd.fsf@concordia.ellerman.id.au>
 <ba7d7010-44ed-cc20-661c-2078f0f522b7@linux.vnet.ibm.com>
 <87tw3sdmpj.fsf@concordia.ellerman.id.au>
 <d0027ac9-48cb-2d31-ce26-a29c0fc0a32c@linux.vnet.ibm.com>
 <87o9tsgo9b.fsf@concordia.ellerman.id.au>
 <ca6ef126-4bc7-5b93-11d1-1342c46fa9b6@linux.vnet.ibm.com>
 <CAKTCnz==4vA4PevndTLF7p2PPKCM8ZkqpuCXPp9kFcjn+CqUKA@mail.gmail.com>
 <CAKTCnzm7jB1doPjySSjBe6B6YhTOkU+Cm+DJA94PQ7rNyXpx4Q@mail.gmail.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Wed, 14 Jun 2017 08:41:03 -0500
MIME-Version: 1.0
In-Reply-To: <CAKTCnzm7jB1doPjySSjBe6B6YhTOkU+Cm+DJA94PQ7rNyXpx4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <26b88035-b377-a594-0b7b-cfcf25e43e57@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello:

On 06/14/2017 12:27 AM, Balbir Singh wrote:
> On Wed, Jun 14, 2017 at 3:25 PM, Balbir Singh <bsingharora@gmail.com> wrote:
>>
>>
>> On Wed, Jun 14, 2017 at 8:21 AM, Michael Bringmann <mwb@linux.vnet.ibm.com>
>> wrote:
>>>
>>> On a related note, we are discussing the addition of 2 new device-tree
>>> properties
>>> with Pete Heyrman and his fellows that should simplify the determination
>>> of the
>>> set of required nodes.
>>>
>>> * One property would provide the total/max number of nodes needed by the
>>> kernel
>>>   on the current hardware.
>>
>>
> 
> Yes, that would be nice to have
> 
>>
>>>
>>> * A second property would provide the total/max number of nodes that the
>>> kernel
>>>   could use on any system to which it could be migrated.
>>>
>>
> 
> Not sure about this one, are you suggesting more memory can be added
> depending on the migration target?

We would use only one of these numbers to allocate nodes.  I have only been
on the periphery of the discussions, so I can not communicate the full
reasoning as to why both measures would be needed.  We would like to have
the first number for node allocation/initialization, but if only the second
value were provided, we would likely need to use it.

>>
>>
>>>
>>> These properties aren't available, yet, and it takes time to define new
>>> properties
>>> in the PAPR and have them implemented in pHyp and the kernel.  As an
>>> intermediary
>>> step, the systems which are doing a lot of dynamic hot-add/hot-remove
>>> configuration
>>> could provide equivalent information to the PowerPC kernel with a command
>>> line
>>> parameter.  The 'numa.c' code would then read this value and fill in the
>>> necessary
>>> entries in the 'node_possible_map'.
>>>
>>> Would you foresee any problems with using such a feature?
>>
>>
> 
> Sorry my mailer goofed up, resending
> 
> Balbir Singh
> 

Thanks.


-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
