Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WZ7l5thrzDq6t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 23:08:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>, Nicholas Piggin
 <npiggin@gmail.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH v5 5/7] powerpc/pseries: flush SLB contents on SLB MCE
 errors.
In-Reply-To: <20180712154113.46845936@kitsune.suse.cz>
References: <153051022088.30541.5610525713141009848.stgit@jupiter.in.ibm.com>
 <153051042206.30541.2156877677180900261.stgit@jupiter.in.ibm.com>
 <20180703080814.5a57f52b@roar.ozlabs.ibm.com>
 <20180712154113.46845936@kitsune.suse.cz>
Date: Thu, 19 Jul 2018 23:08:02 +1000
Message-ID: <87zhynbcgd.fsf@concordia.ellerman.id.au>
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

Michal Such=C3=A1nek <msuchanek@suse.de> writes:
> On Tue, 3 Jul 2018 08:08:14 +1000
> "Nicholas Piggin" <npiggin@gmail.com> wrote: >> On Mon, 02 Jul 2018 11:17=
:06 +0530
>> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
>> > From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> > diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
>> > index efdd16a79075..221271c96a57 100644
>> > --- a/arch/powerpc/kernel/mce.c
>> > +++ b/arch/powerpc/kernel/mce.c
>> > @@ -488,9 +488,21 @@ long machine_check_early(struct pt_regs *regs)
>> >  {
>> >  	long handled =3D 0;
>> >=20=20
>> > -	__this_cpu_inc(irq_stat.mce_exceptions);
>> > +	/*
>> > +	 * For pSeries we count mce when we go into virtual mode
>> > machine
>> > +	 * check handler. Hence skip it. Also, We can't access per
>> > cpu
>> > +	 * variables in real mode for LPAR.
>> > +	 */
>> > +	if (early_cpu_has_feature(CPU_FTR_HVMODE))
>> > +		__this_cpu_inc(irq_stat.mce_exceptions);
>> >=20=20
>> > -	if (cur_cpu_spec && cur_cpu_spec->machine_check_early)
>> > +	/*
>> > +	 * See if platform is capable of handling machine check.
>> > +	 * Otherwise fallthrough and allow CPU to handle this
>> > machine check.
>> > +	 */
>> > +	if (ppc_md.machine_check_early)
>> > +		handled =3D ppc_md.machine_check_early(regs);
>> > +	else if (cur_cpu_spec && cur_cpu_spec->machine_check_early)
>> >  		handled =3D
>> > cur_cpu_spec->machine_check_early(regs);=20=20
>>=20
>> Would be good to add a powernv ppc_md handler which does the
>> cur_cpu_spec->machine_check_early() call now that other platforms are
>> calling this code. Because those aren't valid as a fallback call, but
>> specific to powernv.
>>=20
>
> Something like this (untested)?
>
> Subject: [PATCH] powerpc/powernv: define platform MCE handler.

LGTM.

cheers
