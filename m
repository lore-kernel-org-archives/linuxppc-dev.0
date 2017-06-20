Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsHQj31qdzDqhs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 16:06:03 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5K63V6u048917
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 02:06:02 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b6cs7nmx0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 02:06:01 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 20 Jun 2017 16:05:59 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5K65mW018481264
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 16:05:56 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5K65NUf025526
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 16:05:24 +1000
Subject: Re: [RFC v2 00/12] powerpc: Memory Protection Keys
To: Balbir Singh <bsingharora@gmail.com>, Ram Pai <linuxram@us.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497935415.2255.1.camel@gmail.com>
Cc: dave.hansen@intel.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 20 Jun 2017 11:35:00 +0530
MIME-Version: 1.0
In-Reply-To: <1497935415.2255.1.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <09886a82-872d-8a43-fd61-549cf006ce6e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/20/2017 10:40 AM, Balbir Singh wrote:
> On Fri, 2017-06-16 at 20:52 -0700, Ram Pai wrote:
>> Memory protection keys enable applications to protect its
>> address space from inadvertent access or corruption from
>> itself.
> 
> I presume by itself you mean protection between threads?

Between threads due to race conditions or from the same thread
because of programming error.

> 
>>
>> The overall idea:
>>
>>  A process allocates a   key  and associates it with
>>  a  address  range  within    its   address   space.
> 
> OK, so this is per VMA?

Yeah but the same key can be given to multiple VMAs. Any
change will effect every VMA who got tagged by it.

> 
>>  The process  than  can  dynamically  set read/write 
>>  permissions on  the   key   without  involving  the 
>>  kernel.
> 
> This bit is not clear, how can the key be set without
> involving the kernel? I presume you mean the key is set

With pkey_mprotect() system call, all the effected PTEs get
tagged for once. Switching the permission happens just by
writing into the register on the fly.

> in the PTE's and the access protection values can be
> set without involving the kernel?

PTE setting happens once, access protection values can be
changed on the fly through register.
