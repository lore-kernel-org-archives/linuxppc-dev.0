Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLCmb1GKbzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 21:48:15 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9NAix4F034565
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 06:48:13 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dsdha42ur-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 06:48:13 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Oct 2017 11:48:11 +0100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9NAm6GW26935542
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 10:48:07 GMT
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9NAmAMn025985
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 21:48:11 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Subject: Re: [PATCH 03/25] powerpc: track allocation status of all pkeys
In-Reply-To: <1504910713-7094-12-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-12-git-send-email-linuxram@us.ibm.com>
Date: Mon, 23 Oct 2017 15:11:28 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87po9e8alz.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

> Total 32 keys are available on power7 and above. However
> pkey 0,1 are reserved. So effectively we  have  30 pkeys.

When you say reserved, reserved by whom? Is that part of ISA or PAPR ?
Also do you expect that to change. If not why all these indirection?
Can we have the mask as a #define for 4K and 64K page size
config?

>
> On 4K kernels, we do not  have  5  bits  in  the  PTE to
> represent  all the keys; we only have 3bits.Two of those
> keys are reserved; pkey 0 and pkey 1. So effectively  we
> have 6 pkeys.
>
> This patch keeps track of reserved keys, allocated  keys
> and keys that are currently free.
>
> Also it  adds  skeletal  functions  and macros, that the
> architecture-independent code expects to be available.


-aneesh
