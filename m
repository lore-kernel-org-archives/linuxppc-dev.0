Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYDPh43gszDqcF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 12:54:32 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4P2rS67006943
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 22:54:29 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2anh76umd5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 22:54:28 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 25 May 2017 12:54:26 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4P2sGlT524790
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 12:54:24 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4P2rqWb000760
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 12:53:52 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, anton@samba.org,
 Greg Johnson <gwj@google.com>
Subject: Re: [PATCH] powerpc: Fix booting P9 hash with CONFIG_PPC_RADIX_MMU=N
In-Reply-To: <1495671229.18002.1.camel@neuling.org>
References: <20170524070326.13531-1-mikey@neuling.org>
 <87bmqir5tl.fsf@skywalker.in.ibm.com> <1495671229.18002.1.camel@neuling.org>
Date: Thu, 25 May 2017 08:23:28 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <8737btr6jb.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:

> On Wed, 2017-05-24 at 14:26 +0530, Aneesh Kumar K.V wrote:
>> Michael Neuling <mikey@neuling.org> writes:
>>=20
>> > Currently if you disable CONFIG_PPC_RADIX_MMU you'll crash on boot on
>> > a P9. This is because we still set MMU_FTR_TYPE_RADIX via
>> > ibm,pa-features and MMU_FTR_TYPE_RADIX is what's used for code patching
>> > in much of the asm code (ie. slb_miss_realmode)
>> >=20
>> > This patch fixes the problem by stopping MMU_FTR_TYPE_RADIX from being
>> > set from ibm.pa-features.
>> >=20
>> > We may eventually end up removing the CONFIG_PPC_RADIX_MMU option
>> > completely but until then this fixes the issue.
>> >=20
>> > Signed-off-by: Michael Neuling <mikey@neuling.org>
>> > ---
>> > =C2=A0arch/powerpc/kernel/prom.c | 2 ++
>> > =C2=A01 file changed, 2 insertions(+)
>> >=20
>> > diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>> > index 40c4887c27..f830562974 100644
>> > --- a/arch/powerpc/kernel/prom.c
>> > +++ b/arch/powerpc/kernel/prom.c
>> > @@ -161,7 +161,9 @@ static struct ibm_pa_feature {
>> > =C2=A0	{ .pabyte =3D 0,=C2=A0=C2=A0.pabit =3D 3, .cpu_features=C2=A0=
=C2=A0=3D CPU_FTR_CTRL },
>> > =C2=A0	{ .pabyte =3D 0,=C2=A0=C2=A0.pabit =3D 6, .cpu_features=C2=A0=
=C2=A0=3D CPU_FTR_NOEXECUTE },
>> > =C2=A0	{ .pabyte =3D 1,=C2=A0=C2=A0.pabit =3D 2, .mmu_features=C2=A0=
=C2=A0=3D MMU_FTR_CI_LARGE_PAGE
>> > },
>> > +#ifdef CONFIG_PPC_RADIX_MMU
>> > =C2=A0	{ .pabyte =3D 40, .pabit =3D 0, .mmu_features=C2=A0=C2=A0=3D MM=
U_FTR_TYPE_RADIX },
>> > +#endif
>> > =C2=A0	{ .pabyte =3D 1,=C2=A0=C2=A0.pabit =3D 1, .invert =3D 1, .cpu_f=
eatures =3D
>> > CPU_FTR_NODSISRALIGN },
>> > =C2=A0	{ .pabyte =3D 5,=C2=A0=C2=A0.pabit =3D 0, .cpu_features=C2=A0=
=C2=A0=3D CPU_FTR_REAL_LE,
>> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0.cpu_user_ftrs =3D PPC_FEATURE_TRUE_=
LE },
>> > --=C2=A0
>> > 2.11.0
>>=20
>> Instead can we do that feature removal in mmu_early_init_devtree. ie,
>> something like
>
> It looks like mmu_early_init_devtree() gets called after parsing ibm,pa_f=
eatures
> so that should work.
>
>> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
>> index 8f6f2a173e47..8f43f3827bac 100644
>> --- a/arch/powerpc/mm/init_64.c
>> +++ b/arch/powerpc/mm/init_64.c
>> @@ -394,7 +394,7 @@ void __init mmu_early_init_devtree(v
>> oid)
>> =C2=A0{
>> =C2=A0	/* Disable radix mode based on kernel command line. */
>> =C2=A0	/* We don't yet have the machinery to do radix as a guest. */
>> -	if (disable_radix || !(mfmsr() & MSR_HV))
>> > +	if (!IS_ENABLED(CONFIG_PPC_RADIX_MMU) || disable_radix || !(mfmsr() =
& MSR_HV))
>
> What tree is this patch against?  Linus' tree doesn't look like that.
>

mpe/next at the time of this merge window. Do you want me to send a
complete patch against latest mpe/next ?

-aneesh
