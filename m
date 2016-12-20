Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjLfF2yKvzDwGy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 13:03:01 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBK1wtBT106520
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 21:02:58 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27erfhrqku-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 21:02:58 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 19 Dec 2016 19:02:58 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Reza Arbab <arbab@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, Balbir Singh <bsingharora@gmail.com>,
 Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH v3 1/5] powerpc/mm: set the radix linear page mapping size
In-Reply-To: <1482180827.15937.30.camel@kernel.crashing.org>
References: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1481831443-22761-2-git-send-email-arbab@linux.vnet.ibm.com>
 <8760mguwfx.fsf@linux.vnet.ibm.com>
 <1482180827.15937.30.camel@kernel.crashing.org>
Date: Tue, 20 Dec 2016 07:32:50 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <87oa07tl11.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Mon, 2016-12-19 at 14:28 +0530, Aneesh Kumar K.V wrote:
>> Reza Arbab <arbab@linux.vnet.ibm.com> writes:
>>=20
>> > This was defaulting to 4K, regardless of PAGE_SIZE.
>> >=20
>> > Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
>> > ---
>> > =C2=A0arch/powerpc/mm/pgtable-radix.c | 2 ++
>> > =C2=A01 file changed, 2 insertions(+)
>> >=20
>> > diff --git a/arch/powerpc/mm/pgtable-radix.c
>> > b/arch/powerpc/mm/pgtable-radix.c
>> > index 623a0dc..54bd70e 100644
>> > --- a/arch/powerpc/mm/pgtable-radix.c
>> > +++ b/arch/powerpc/mm/pgtable-radix.c
>> > @@ -351,8 +351,10 @@ void __init radix__early_init_mmu(void)
>> > =C2=A0#ifdef CONFIG_PPC_64K_PAGES
>> > =C2=A0	/* PAGE_SIZE mappings */
>> > =C2=A0	mmu_virtual_psize =3D MMU_PAGE_64K;
>> > +	mmu_linear_psize =3D MMU_PAGE_64K;
>>=20
>> That is not clearly correct, we map the linear address with either
>> 64K,
>> 2M or 1G depending on the memory available. Take a look at
>> static void __init radix_init_pgtable(void)
>>=20
>
> So should we fix that initialization regardless or take it out ?

We should not be usuing mmu_linear_psize on radix. Hence we can skip
that initialization.

-aneesh
