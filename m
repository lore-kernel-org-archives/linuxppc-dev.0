Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfn546knXzDqr5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 01:43:20 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5TFd4ov086190
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 11:43:19 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23uwt7qj5k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 11:43:18 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Wed, 29 Jun 2016 09:43:14 -0600
Date: Wed, 29 Jun 2016 10:37:31 -0500
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
References: <1466699962-22412-1-git-send-email-arbab@linux.vnet.ibm.com>
 <87mvmbygdb.fsf@skywalker.in.ibm.com>
 <20160623193739.GA19202@arbab-laptop.austin.ibm.com>
 <1467112865.16036.4.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <1467112865.16036.4.camel@ellerman.id.au>
Message-Id: <20160629153731.GA31214@arbab-laptop.austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 28, 2016 at 09:21:05PM +1000, Michael Ellerman wrote:
>No, you need to use mmu_linear_psize for the hotplug case.
>
>But you can probably factor out a common routine that both cases use, and hide
>the hash vs radix check in that.

Okay, I'm trying to refactor {create,remove}_section_mapping() into 
hash__ and radix__ variants. This lead to a couple of questions.

Pseudocode for radix__create_section_mapping(start, end):

	page_size = 1 << mmu_psize_defs[mmu_linear_psize].shift;
	start = _ALIGN_DOWN(start, page_size);

	for (; start < end; start += page_size) {
		radix__map_kernel_page(start, __pa(start),
				       PAGE_KERNEL, page_size);
	}

Should the above use PAGE_KERNEL, like the the hash table bolt, or 
(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_KERNEL_RW), like in the radix 
vmemmap creation?

The other question is what radix__remove_section_mapping() should do.
I don't know offhand what the opposite of map_kernel_page() is. As 
Aneesh mentioned, radix vmemmap removal is currently stubbed as a FIXME 
so I couldn't use that as a reference.

-- 
Reza Arbab
