Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tj84y3VjCzDwNp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 05:06:58 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBJI4C1h087264
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 13:06:55 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27egf397p1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 13:06:55 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Mon, 19 Dec 2016 11:06:55 -0700
Date: Mon, 19 Dec 2016 12:06:50 -0600
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Balbir Singh <bsingharora@gmail.com>, Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH v3 3/5] powerpc/mm: add radix__create_section_mapping()
References: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1481831443-22761-4-git-send-email-arbab@linux.vnet.ibm.com>
 <87zijsthma.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <87zijsthma.fsf@linux.vnet.ibm.com>
Message-Id: <20161219180649.igsddi5zlhttoeaq@arbab-laptop.austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 19, 2016 at 02:34:13PM +0530, Aneesh Kumar K.V wrote:
>Reza Arbab <arbab@linux.vnet.ibm.com> writes:
>> Add the linear page mapping function for radix, used by memory 
>> hotplug. This is similar to vmemmap_populate().
>>
>
>Ok with this patch your first patch becomes useful. Can you merge that
>with this and rename mmu_linear_psize to mmu_hotplug_psize or even use
>mmu_virtual_psize. The linear naming is confusing.

Thanks for pointing out radix_init_pgtable(). I think the right thing to 
do here is create these mappings the same way it does. We can probably 
factor out a common function.

-- 
Reza Arbab
