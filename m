Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHMJ04KFBzDrHx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 02:15:44 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7LG9Dgr072154
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Aug 2016 12:15:42 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24y17m4x8g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Aug 2016 12:15:42 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 21 Aug 2016 10:15:41 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC v2 0/2] powerpc/mm: enable memory hotplug on radix
In-Reply-To: <1471449083-15931-1-git-send-email-arbab@linux.vnet.ibm.com>
References: <1471449083-15931-1-git-send-email-arbab@linux.vnet.ibm.com>
Date: Sun, 21 Aug 2016 21:45:35 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <871t1ijdy0.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reza Arbab <arbab@linux.vnet.ibm.com> writes:

> Memory hotplug is leading to hash page table calls, even on radix:
>
> ...
> 	arch_add_memory
> 		create_section_mapping
> 			htab_bolt_mapping
> 				BUG_ON(!ppc_md.hpte_insert);
>
> Refactor {create,remove}_section_mapping() into hash__ and radix__ variants.
>
> RFC/TODO:
> I wasn't sure what to do in radix__remove_section_mapping(). Its vmemmap
> counterpart radix__vmemmap_remove_mapping() is stubbed as a FIXME. I left it
> empty for now.

For linear mapping and for vmemmap area we should do something equivalent of

static void __meminit
remove_pagetable(unsigned long start, unsigned long end, bool direct)

as done for x86.

-aneesh
