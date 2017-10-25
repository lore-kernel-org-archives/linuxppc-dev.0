Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMPhf1g0zzDqkp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 20:18:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 3/7] powerpc: Free up four 64K PTE bits in 4K backed HPTE
 pages
In-Reply-To: <20171023162934.GA5454@ram.oc3035372033.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-4-git-send-email-linuxram@us.ibm.com>
 <87o9p3kedg.fsf@concordia.ellerman.id.au> <871slu9ro4.fsf@linux.vnet.ibm.com>
 <20171023162934.GA5454@ram.oc3035372033.ibm.com>
Date: Wed, 25 Oct 2017 11:18:49 +0200
Message-ID: <87d15b1t6u.fsf@concordia.ellerman.id.au>
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

Ram Pai <linuxram@us.ibm.com> writes:
> On Mon, Oct 23, 2017 at 02:17:39PM +0530, Aneesh Kumar K.V wrote:
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>> > Ram Pai <linuxram@us.ibm.com> writes:
...
>> > Should be:
>> > 	/*
>> > 	 * Initialize all hidx entries to invalid value, the first time
>> >          * the PTE is about to allocate a 4K HPTE.
>> > 	 */
>> >
>> >> +	if (!(old_pte & H_PAGE_COMBO))
>> >> +		rpte.hidx = ~0x0UL;
>> >> +
>> >
>> > Paul had the idea that if we biased the slot number by 1, we could make
>> > the "invalid" value be == 0.
>> >
>> > That would avoid needing to that above, and also mean the value is
>> > correctly invalid from the get-go, which would be good IMO.
>> >
>> > I think now that you've added the slot accessors it would be pretty easy
>> > to do.
>> 
>> That would be imply, we loose one slot in primary group, which means we
>> will do extra work in some case because our primary now has only 7
>> slots. And in case of pseries, the hypervisor will always return the
>> least available slot, which implie we will do extra hcalls in case of an
>> hpte insert to an empty group?
>
> No. that is not the idea.  The idea is that slot 'F' in the seconday
> will continue to be a invalid slot, but will be represented as
> offset-by-one in the PTE.  In other words, 0 will be repesented as 1,
> 1 as 2....   and  n as (n+1)%32

Right.

> The idea seems feasible.  It has the advantage -- where 0 in the PTE
> means invalid slot. But it can be confusing to the casual code-
> reader. Will need to put in a big-huge comment to explain that.

This code is already confusing to *any* reader, so I don't think it's a
worry. :)

cheers
