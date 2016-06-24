Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rbNtw4pxTzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 13:22:48 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id hf6so7848616pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 20:22:48 -0700 (PDT)
Subject: Re: [PATCH] powerpc/mm: update arch_{add,remove}_memory() for radix
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Reza Arbab <arbab@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Dan Williams <dan.j.williams@intel.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Scott Wood <scottwood@freescale.com>, Oliver O'Halloran <oohall@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1466699962-22412-1-git-send-email-arbab@linux.vnet.ibm.com>
 <87mvmbygdb.fsf@skywalker.in.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <b76f3a48-76ee-fd8c-f889-136d189620fe@gmail.com>
Date: Fri, 24 Jun 2016 13:22:37 +1000
MIME-Version: 1.0
In-Reply-To: <87mvmbygdb.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 24/06/16 03:17, Aneesh Kumar K.V wrote:
> Reza Arbab <arbab@linux.vnet.ibm.com> writes:
> 
>> These functions are making direct calls to the hash table APIs,
>> leading to a BUG() on systems using radix.
>>
>> Switch them to the vmemmap_{create,remove}_mapping() wrappers, and
>> move to the __meminit section.
> 
> 
> They are really not the same. They can possibly end up using different
> base page size. Also vmemmap is available only with SPARSEMEM_VMEMMAP
> enabled. Does hotplug depend on sparsemem vmemmap ?

# eventually, we can have this option just 'select SPARSEMEM'
config MEMORY_HOTPLUG
        bool "Allow for memory hot-add"
        depends on SPARSEMEM || X86_64_ACPI_NUMA
        depends on ARCH_ENABLE_MEMORY_HOTPLUG

We depend on sparsemem for sure. vmemmap is just a way of getting the memory
virtually mapped. From the patch perspective, I think we need the equivalent of
just mapping the pages in kernel. The address may differ based on whether vmemmap
is used or not and of-course page_size, 

Balbir Singh
