Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2zNH1HwgzDqfJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 05:37:03 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0HIY02a078465
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 13:37:00 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 281ktgy8yp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 13:37:00 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Tue, 17 Jan 2017 11:36:59 -0700
Date: Tue, 17 Jan 2017 12:36:53 -0600
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH v5 4/4] powerpc/mm: unstub radix__vmemmap_remove_mapping()
References: <1484593666-8001-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1484593666-8001-5-git-send-email-arbab@linux.vnet.ibm.com>
 <20170117072513.GE8963@dhcp-9-109-223-248.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <20170117072513.GE8963@dhcp-9-109-223-248.in.ibm.com>
Message-Id: <20170117183653.7bd62joj5yog5yca@arbab-vm>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 17, 2017 at 12:55:13PM +0530, Balbir Singh wrote:
>On Mon, Jan 16, 2017 at 01:07:46PM -0600, Reza Arbab wrote:
>> Use remove_pagetable() and friends for radix vmemmap removal.
>>
>> We do not require the special-case handling of vmemmap done in the x86
>> versions of these functions. This is because vmemmap_free() has already
>> freed the mapped pages, and calls us with an aligned address range.
>>
>> So, add a few failsafe WARNs, but otherwise the code to remove physical
>> mappings is already sufficient for vmemmap.
>
>I wonder if we really need them?

Not sure what the guideline is for a "this shouldn't happen" WARN. It 
could save us some grief, should our vmemmap code ever start calling 
with an unaligned range, like it does on x86.

-- 
Reza Arbab
