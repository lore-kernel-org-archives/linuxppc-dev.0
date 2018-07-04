Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LM19442DzF1NW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 23:15:25 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>, Nicholas Piggin
 <npiggin@gmail.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH v5 5/7] powerpc/pseries: flush SLB contents on SLB MCE
 errors.
In-Reply-To: <20180703123758.7705260b@naga.suse.cz>
References: <153051022088.30541.5610525713141009848.stgit@jupiter.in.ibm.com>
 <153051042206.30541.2156877677180900261.stgit@jupiter.in.ibm.com>
 <20180703080814.5a57f52b@roar.ozlabs.ibm.com>
 <20180703123758.7705260b@naga.suse.cz>
Date: Wed, 04 Jul 2018 23:15:23 +1000
Message-ID: <87h8lfkuqc.fsf@concordia.ellerman.id.au>
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
> Nicholas Piggin <npiggin@gmail.com> wrote:
>> On Mon, 02 Jul 2018 11:17:06 +0530
>> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
>> > From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> >=20
>> > On pseries, as of today system crashes if we get a machine check
>> > exceptions due to SLB errors. These are soft errors and can be
>> > fixed by flushing the SLBs so the kernel can continue to function
>> > instead of system crash. We do this in real mode before turning on
>> > MMU. Otherwise we would run into nested machine checks. This patch
>> > now fetches the rtas error log in real mode and flushes the SLBs on
>> > SLB errors.
>> >=20
>> > Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> > ---
>> >  arch/powerpc/include/asm/book3s/64/mmu-hash.h |    1=20
>> >  arch/powerpc/include/asm/machdep.h            |    1=20
>> >  arch/powerpc/kernel/exceptions-64s.S          |   42
>> > +++++++++++++++++++++ arch/powerpc/kernel/mce.c
>> > |   16 +++++++- arch/powerpc/mm/slb.c                         |
>> > 6 +++ arch/powerpc/platforms/powernv/opal.c         |    1=20
>> >  arch/powerpc/platforms/pseries/pseries.h      |    1=20
>> >  arch/powerpc/platforms/pseries/ras.c          |   51
>> > +++++++++++++++++++++++++
>> > arch/powerpc/platforms/pseries/setup.c        |    1 9 files
>> > changed, 116 insertions(+), 4 deletions(-)=20
>>=20
>>=20
>> > +TRAMP_REAL_BEGIN(machine_check_pSeries_early)
>> > +BEGIN_FTR_SECTION
>> > +	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
>> > +	mr	r10,r1			/* Save r1 */
>> > +	ld	r1,PACAMCEMERGSP(r13)	/* Use MC emergency
>> > stack */
>> > +	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack
>> > frame		*/
>> > +	mfspr	r11,SPRN_SRR0		/* Save SRR0 */
>> > +	mfspr	r12,SPRN_SRR1		/* Save SRR1 */
>> > +	EXCEPTION_PROLOG_COMMON_1()
>> > +	EXCEPTION_PROLOG_COMMON_2(PACA_EXMC)
>> > +	EXCEPTION_PROLOG_COMMON_3(0x200)
>> > +	addi	r3,r1,STACK_FRAME_OVERHEAD
>> > +	BRANCH_LINK_TO_FAR(machine_check_early) /* Function call
>> > ABI */=20=20
>>=20
>> Is there any reason you can't use the existing
>> machine_check_powernv_early code to do all this?
>
> Code sharing is nice but if we envision this going to stable kernels
> butchering the existing handler is going to be a nightmare. The code is
> quite a bit different between kernel versions.

I'm not sure if we'll send it to stable kernels. But we obviously will
back port it to some distros :)

So if sharing the code is a significant impediment to that, then I'm
happy if we don't share code initially. That could be done as a
follow-up to this series.

cheers
