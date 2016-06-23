Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rbBZS3TYszDql5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 05:37:51 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5NJYard126162
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 15:37:48 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23rj7h91y3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 15:37:48 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Thu, 23 Jun 2016 13:37:48 -0600
Date: Thu, 23 Jun 2016 14:37:39 -0500
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Dan Williams <dan.j.williams@intel.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Scott Wood <scottwood@freescale.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/mm: update arch_{add,remove}_memory() for radix
References: <1466699962-22412-1-git-send-email-arbab@linux.vnet.ibm.com>
 <87mvmbygdb.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <87mvmbygdb.fsf@skywalker.in.ibm.com>
Message-Id: <20160623193739.GA19202@arbab-laptop.austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 23, 2016 at 10:47:20PM +0530, Aneesh Kumar K.V wrote:
>Reza Arbab <arbab@linux.vnet.ibm.com> writes:
>> These functions are making direct calls to the hash table APIs,
>> leading to a BUG() on systems using radix.
>>
>> Switch them to the vmemmap_{create,remove}_mapping() wrappers, and
>> move to the __meminit section.
>
>They are really not the same. They can possibly end up using different
>base page size. Also vmemmap is available only with SPARSEMEM_VMEMMAP
>enabled. Does hotplug depend on sparsemem vmemmap ?

I'm not sure. Maybe it's best if I back up a step and explain what lead 
me to this patch. During hotplug, you get

...
	arch_add_memory
		create_section_mapping
			htab_bolt_mapping
				BUG_ON(!ppc_md.hpte_insert);

So it seemed to me that I needed a radix equivalent of 
create_section_mapping().

After some digging, I found hash__vmemmap_create_mapping() and 
radix__vmemmap_create_mapping() did what I needed. I did not notice the 
#ifdef SPARSEMEM_VMEMMAP around them.

Hotplug/remove are now working for me as far as I can tell, so I think
the functional change in itself was correct. Hotplug may not depend on 
sparsemem vmemmap, but we seem to need a radix create_section_mapping() 
regardless.

Could it be that the functions just need to be renamed 
hash__create_mapping()/radix__create_mapping() and moved out of #ifdef 
SPARSEMEM_VMEMMAP?

-- 
Reza Arbab
