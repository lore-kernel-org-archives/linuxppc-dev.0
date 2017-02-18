Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vQMcX2cc1zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2017 18:54:52 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org
Subject: Re: [PATCH v2] powerpc: Add POWER9 architected mode to cputable
In-Reply-To: <1487333213.11368.2.camel@russell.cc>
References: <20170217020135.6361-1-ruscur@russell.cc>
 <87y3x5i04k.fsf@concordia.ellerman.id.au>
 <1487333213.11368.2.camel@russell.cc>
Date: Sat, 18 Feb 2017 18:54:48 +1100
Message-ID: <87ino8hr1z.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Russell Currey <ruscur@russell.cc> writes:
> On Fri, 2017-02-17 at 21:26 +1100, Michael Ellerman wrote:
>> Russell Currey <ruscur@russell.cc> writes:
>> > diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cput=
able.c
>> > index 6a82ef039c50..d23a54b09436 100644
>> > --- a/arch/powerpc/kernel/cputable.c
>> > +++ b/arch/powerpc/kernel/cputable.c
>> > @@ -386,6 +386,25 @@ static struct cpu_spec __initdata cpu_specs[] =3D=
 {
>> > =C2=A0		.machine_check_early	=3D
>> > __machine_check_early_realmode_p8,
>> > =C2=A0		.platform		=3D "power8",
>> > =C2=A0	},
>> > +	{	/* 3.00-compliant processor, i.e. Power9 "architected"
>> > mode */
>> > +		.pvr_mask		=3D 0xffffffff,
>> > +		.pvr_value		=3D 0x0f000005,
>> > +		.cpu_name		=3D "POWER9 (architected)",
>> > +		.cpu_features		=3D CPU_FTRS_POWER9,
>> > +		.cpu_user_features	=3D COMMON_USER_POWER9,
>> > +		.cpu_user_features2	=3D COMMON_USER2_POWER9,
>> > +		.mmu_features		=3D MMU_FTRS_POWER9,
>> > +		.icache_bsize		=3D 128,
>> > +		.dcache_bsize		=3D 128,
>> > +		.num_pmcs		=3D 6,
>>=20
>> It's important *not* to set num_pmcs for the architected PVRs.
...
>
> Oh and also, do you want me to respin or are you happy to drop it on your=
 end?

I fixed it up:

commit 6ae3f8ad2017079292cb49c8959b527bcbcbefed
Author:     Russell Currey <ruscur@russell.cc>
AuthorDate: Fri Feb 17 13:01:35 2017 +1100
Commit:     Michael Ellerman <mpe@ellerman.id.au>
CommitDate: Fri Feb 17 21:48:56 2017 +1100

    powerpc: Add POWER9 architected mode to cputable
=20=20=20=20
    PVR value of 0x0F000005 means we are arch v3.00 compliant (i.e. POWER9).
=20=20=20=20
    Acked-by: Michael Neuling <mikey@neuling.org>
    Signed-off-by: Russell Currey <ruscur@russell.cc>
    [mpe: Don't set num_pmcs, so we keep the PMU fields from the raw entry]
    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 6a82ef039c50..bb7a1890aeb7 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -386,6 +386,23 @@ static struct cpu_spec __initdata cpu_specs[] =3D {
 		.machine_check_early	=3D __machine_check_early_realmode_p8,
 		.platform		=3D "power8",
 	},
+	{	/* 3.00-compliant processor, i.e. Power9 "architected" mode */
+		.pvr_mask		=3D 0xffffffff,
+		.pvr_value		=3D 0x0f000005,
+		.cpu_name		=3D "POWER9 (architected)",
+		.cpu_features		=3D CPU_FTRS_POWER9,
+		.cpu_user_features	=3D COMMON_USER_POWER9,
+		.cpu_user_features2	=3D COMMON_USER2_POWER9,
+		.mmu_features		=3D MMU_FTRS_POWER9,
+		.icache_bsize		=3D 128,
+		.dcache_bsize		=3D 128,
+		.oprofile_type		=3D PPC_OPROFILE_INVALID,
+		.oprofile_cpu_type	=3D "ppc64/ibm-compat-v1",
+		.cpu_setup		=3D __setup_cpu_power9,
+		.cpu_restore		=3D __restore_cpu_power9,
+		.flush_tlb		=3D __flush_tlb_power9,
+		.platform		=3D "power9",
+	},
 	{	/* Power7 */
 		.pvr_mask		=3D 0xffff0000,
 		.pvr_value		=3D 0x003f0000,


cheers
