Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yPzqL6RNHzDqkH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 01:03:41 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9TDx95q031384
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Oct 2017 10:03:38 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dvnw41ta3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Oct 2017 10:03:37 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 29 Oct 2017 14:03:36 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Ram Pai <linuxram@us.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Subject: Re: [PATCH 20/25] powerpc: Handle exceptions caused by pkey violation
In-Reply-To: <874lqo4kf9.fsf@concordia.ellerman.id.au>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-29-git-send-email-linuxram@us.ibm.com>
 <874lqo4kf9.fsf@concordia.ellerman.id.au>
Date: Sun, 29 Oct 2017 19:33:25 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8737622gr6.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Ram Pai <linuxram@us.ibm.com> writes:
>
>> Handle Data and  Instruction exceptions caused by memory
>> protection-key.
>>
>> The CPU will detect the key fault if the HPTE is already
>> programmed with the key.
>>
>> However if the HPTE is not  hashed, a key fault will not
>> be detected by the  hardware. The   software will detect
>> pkey violation in such a case.
>
> That seems like the wrong trade off to me.
>
> It means every fault has to go through arch_vma_access_permitted(),
> which is at least a function call in the best case, even when pkeys are
> not in use, and/or the range in question is not protected by a key.

We don't really need to call arch_vma_access_permitted() in
arch/powerpc/ do_page_fault(). Core kernel does that in
handle_mm_fault(). So if the first fault is a bad access handle_mm_fault
handle this. If it is a valid access we insert the right hash page table
entry and then we do a wrong access, we detect that a key fault in the
low level hash fault handler. IIUC, the call the
arch_vma_access_permitted() from arch/powerpc/ can go away?

-aneesh
