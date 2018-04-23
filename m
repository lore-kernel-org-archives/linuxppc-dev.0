Return-Path: <srs0=im6g=hm=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40TvnY22PFzDr5X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 15:16:17 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40TvnY1QCvz8svR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 15:16:17 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40TvnX4hKvz9s19
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2018 15:16:16 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3N5Dns1132790
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2018 01:16:14 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hh44ngxkp-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2018 01:16:13 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 23 Apr 2018 06:16:11 +0100
Subject: Re: [PATCH v4 1/7] powerpc/fadump: Move the metadata region to start
 of the reserved area.
To: Nicholas Piggin <nicholas.piggin@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Ananth Narayan
 <ananth@in.ibm.com>, kernelfans@gmail.com,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <152420062000.31037.770773018944092449.stgit@jupiter.in.ibm.com>
 <152420065839.31037.9373191008433546810.stgit@jupiter.in.ibm.com>
 <20180422115816.701d0837@roar.ozlabs.ibm.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Mon, 23 Apr 2018 10:46:06 +0530
MIME-Version: 1.0
In-Reply-To: <20180422115816.701d0837@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <f2bbcdfd-65be-0a50-7d24-b66f101437b7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/22/2018 07:28 AM, Nicholas Piggin wrote:
> On Fri, 20 Apr 2018 10:34:18 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> 
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> Currently the metadata region that holds crash info structure and ELF core
>> header is placed towards the end of reserved memory area. This patch places
>> it at the beginning of the reserved memory area. It also introduces
>> additional dump section called metadata section to communicate location
>> of metadata region to 2nd kernel. This patch also maintains the
>> compatibility between production/capture kernels irrespective of their
>> kernel versions. Both combination older/newer and newer/older works fine.
> 
> Trying to look at the patches it might help me if you document reasons
> for why this change is made changelog, even if it may be obvious to
> someone who knows the code better.

Yeah, I should have mentioned that this patch provides the foundation
for CMA patch 4. With CMA reservation we now allocate metadata region
using cma_alloc() which always allocates metadata region at the start of
CMA reserved region. Earlier in v1, I had this change included along
with CMA reservation patch. But then to make things simpler for review I
did a logical split of movement of metadata region and CMA reservation
patch separately. I think I should order patch 1, 2 and 4 in a sequence
and Move patch3 to patch 1.

> 
> I thought you could include the documentation change in this patch as
> well, but maybe that's a matter of preference.

Yeah that's how I prefer it :-), but that just me. But if it helps in
review I can fold it into 1.

Thanks,
-Mahesh.
