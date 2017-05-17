Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wSKXV6bwbzDqZR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 13:28:26 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4H3ImnM098536
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 23:28:21 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ag7ewrssn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 23:28:21 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 17 May 2017 13:28:19 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4H3S8Io54198296
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 13:28:16 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4H3RhF0024129
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 13:27:43 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] powerpc/mm: Rename find_linux_pte_or_hugepte
In-Reply-To: <1494933772.21847.48.camel@kernel.crashing.org>
References: <1494926782-25700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1494926782-25700-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1494933772.21847.48.camel@kernel.crashing.org>
Date: Wed, 17 May 2017 08:57:26 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <87wp9g17tt.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Tue, 2017-05-16 at 14:56 +0530, Aneesh Kumar K.V wrote:
>> +static inline pte_t *find_linux_pte(pgd_t *pgdir, unsigned long ea,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool *is_thp, =
unsigned *hshift)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VM_WARN((!arch_irqs_disabled(=
) && !__hard_irqs_disabled()) ,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0"%s called with irq enabled\n", __func__);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return __find_linux_pte(pgdir=
, ea, is_thp, hshift);
>> +}
>> +
>
> When is arch_irqs_disabled() not sufficient ?

We can do lockless page table walk in interrupt handlers where we find
MSR_EE =3D 0. I was not sure we mark softenabled 0 there. What I wanted to
indicate in the patch is that we are safe with either softenable =3D 0 or M=
SR_EE =3D 0

-aneesh
