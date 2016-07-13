Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqLBp2X5hzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 00:02:58 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6DDx512040946
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 10:02:54 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 245jp9j0jn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 10:02:54 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 08:02:53 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH for-4.8_set4 0/2] Segment table support
In-Reply-To: <1468411441.20552.80.camel@kernel.crashing.org>
References: <1468402850-6052-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1468411441.20552.80.camel@kernel.crashing.org>
Date: Wed, 13 Jul 2016 19:32:46 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <87mvlly6t5.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Wed, 2016-07-13 at 15:10 +0530, Aneesh Kumar K.V wrote:
>> Hi,
>>=20
>> This series add support for ISA 3.0 memory segment table.
>>=20
>> Aneesh Kumar K.V (2):
>> =C2=A0 powerpc/mm: Switch user slb fault handling to translation enabled
>> =C2=A0 powerpc/mm: Support segment table for Power9
>
> The segment table will only be used for the nest MMU, shouldn't we keep
> that a separate path that we call explictly from fault interrupts
> coming from NestMMU agents instead ?
>

I haven't looked at the Nest MMU use of this. This patch is looking at
implementing the ISA 3.0 Segment table support for core. We determine
whether cpu will support this mode by looking at ibm,pa-features bit
value. If ibm,pa-features byte 40 bit 1 is not set, it indicates that
Segment table support is not there and hence we fallback to other MMU
mode supported by the CPU.

Going foward we may want to look at the possibility of having Nest use
segment table without core supporting them. But then that is not done as
a part of this patch.

-aneesh
