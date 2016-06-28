Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf72V34pBzDqrW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 00:08:49 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5SE4IYo114038
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 10:08:47 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23spf9ta5h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 10:08:47 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 28 Jun 2016 08:07:03 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Dan Williams <dan.j.williams@intel.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Scott Wood <scottwood@freescale.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/mm: update arch_{add,remove}_memory() for radix
In-Reply-To: <1467112865.16036.4.camel@ellerman.id.au>
References: <1466699962-22412-1-git-send-email-arbab@linux.vnet.ibm.com>
 <87mvmbygdb.fsf@skywalker.in.ibm.com>
 <20160623193739.GA19202@arbab-laptop.austin.ibm.com>
 <1467112865.16036.4.camel@ellerman.id.au>
Date: Tue, 28 Jun 2016 19:33:06 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87ziq54did.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> On Thu, 2016-06-23 at 14:37 -0500, Reza Arbab wrote:
>> On Thu, Jun 23, 2016 at 10:47:20PM +0530, Aneesh Kumar K.V wrote:
>> > Reza Arbab <arbab@linux.vnet.ibm.com> writes:
>> > > These functions are making direct calls to the hash table APIs,
>> > > leading to a BUG() on systems using radix.
>> > > 
>> > > Switch them to the vmemmap_{create,remove}_mapping() wrappers, and
>> > > move to the __meminit section.
>> > 
>> > They are really not the same. They can possibly end up using different
>> > base page size. Also vmemmap is available only with SPARSEMEM_VMEMMAP
>> > enabled. Does hotplug depend on sparsemem vmemmap ?
>> 
>> I'm not sure. Maybe it's best if I back up a step and explain what lead 
>> me to this patch. During hotplug, you get
>> 
>> ...
>> 	arch_add_memory
>> 		create_section_mapping
>> 			htab_bolt_mapping
>> 				BUG_ON(!ppc_md.hpte_insert);
>> 
>> So it seemed to me that I needed a radix equivalent of 
>> create_section_mapping().
>> 
>> After some digging, I found hash__vmemmap_create_mapping() and 
>> radix__vmemmap_create_mapping() did what I needed. I did not notice the 
>> #ifdef SPARSEMEM_VMEMMAP around them.
>
> I think that's more by luck than design. The vmemmap routines use
> mmu_vmemmap_psize which is probably but not definitely the same as
> mmu_linear_psize.
>
>> Could it be that the functions just need to be renamed 
>> hash__create_mapping()/radix__create_mapping() and moved out of #ifdef 
>> SPARSEMEM_VMEMMAP?
>
> No, you need to use mmu_linear_psize for the hotplug case.
>
> But you can probably factor out a common routine that both cases use, and hide
> the hash vs radix check in that.
>
> And probably send me a patch to make MEMORY_HOTPLUG depend on !RADIX for v4.7?

Few other stuff we need to still look from Radix point
1) machine check handling/memory errors
2) kexec

-aneesh
