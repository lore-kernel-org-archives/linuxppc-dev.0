Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPsHt3H11zF03V
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 01:07:54 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u58F4Mdg041942
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 11:07:51 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23e9m3uc26-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 11:07:51 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 09:07:50 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 16/16] powerpc/mm: Support segment table for Power9
In-Reply-To: <1465397003-26812-17-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1465397003-26812-17-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 08 Jun 2016 20:37:45 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87twh31zy6.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> PowerISA 3.0 adds an in memory table for storing segment translation
> information. In this mode, which is enabled by setting both HOST RADIX
> and GUEST RADIX bits in partition table to 0 and enabling UPRT to
> 1, we have a per process segment table. The segment table details
> are stored in the process table indexed by PID value.
>
> Segment table mode also requires us to map the process table at the
> beginning of a 1TB segment.
>
> On the linux kernel side we enable this model if we find that
> the radix is explicitily disabled by setting the ibm,pa-feature radix
> bit (byte 40 bit 0) set to 0. If the size of ibm,pa-feature node is less
> than 40 bytes, we enable the legacy HPT mode using SLB. If radix bit
> is set to 1, we use the radix mode.


Missed updating the commit message.

On the linux kernel side we enable this model if we find hash mmu bit
(byte 58 bit 0) of ibm,pa-feature device tree node set to 1. If the size
of ibm,pa-feature node is less than 58 bytes or if the hash mmu bit is
set to 0, we enable the legacy HPT mode using SLB. If radix bit (byte 40
bit 0) is set to 1, we use the radix mode.

>
> With respect to SLB mapping, we bolt mapp the entire kernel range and
> and only handle user space segment fault.
>

-aneesh
