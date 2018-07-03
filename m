Return-Path: <srs0=n6ax=jt=suse.de=msuchanek@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KgZ439L3zF1LQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 20:38:04 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41KgZ42XCZz8t4k
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 20:38:04 +1000 (AEST)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41KgZ34CQ3z9s1b
 for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2018 20:38:03 +1000 (AEST)
Date: Tue, 3 Jul 2018 12:37:58 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>, Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 5/7] powerpc/pseries: flush SLB contents on SLB MCE
 errors.
Message-ID: <20180703123758.7705260b@naga.suse.cz>
In-Reply-To: <20180703080814.5a57f52b@roar.ozlabs.ibm.com>
References: <153051022088.30541.5610525713141009848.stgit@jupiter.in.ibm.com>
 <153051042206.30541.2156877677180900261.stgit@jupiter.in.ibm.com>
 <20180703080814.5a57f52b@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 3 Jul 2018 08:08:14 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> On Mon, 02 Jul 2018 11:17:06 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> 
> > From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> > 
> > On pseries, as of today system crashes if we get a machine check
> > exceptions due to SLB errors. These are soft errors and can be
> > fixed by flushing the SLBs so the kernel can continue to function
> > instead of system crash. We do this in real mode before turning on
> > MMU. Otherwise we would run into nested machine checks. This patch
> > now fetches the rtas error log in real mode and flushes the SLBs on
> > SLB errors.
> > 
> > Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/include/asm/book3s/64/mmu-hash.h |    1 
> >  arch/powerpc/include/asm/machdep.h            |    1 
> >  arch/powerpc/kernel/exceptions-64s.S          |   42
> > +++++++++++++++++++++ arch/powerpc/kernel/mce.c
> > |   16 +++++++- arch/powerpc/mm/slb.c                         |
> > 6 +++ arch/powerpc/platforms/powernv/opal.c         |    1 
> >  arch/powerpc/platforms/pseries/pseries.h      |    1 
> >  arch/powerpc/platforms/pseries/ras.c          |   51
> > +++++++++++++++++++++++++
> > arch/powerpc/platforms/pseries/setup.c        |    1 9 files
> > changed, 116 insertions(+), 4 deletions(-) 
> 
> 
> > +TRAMP_REAL_BEGIN(machine_check_pSeries_early)
> > +BEGIN_FTR_SECTION
> > +	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
> > +	mr	r10,r1			/* Save r1 */
> > +	ld	r1,PACAMCEMERGSP(r13)	/* Use MC emergency
> > stack */
> > +	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack
> > frame		*/
> > +	mfspr	r11,SPRN_SRR0		/* Save SRR0 */
> > +	mfspr	r12,SPRN_SRR1		/* Save SRR1 */
> > +	EXCEPTION_PROLOG_COMMON_1()
> > +	EXCEPTION_PROLOG_COMMON_2(PACA_EXMC)
> > +	EXCEPTION_PROLOG_COMMON_3(0x200)
> > +	addi	r3,r1,STACK_FRAME_OVERHEAD
> > +	BRANCH_LINK_TO_FAR(machine_check_early) /* Function call
> > ABI */  
> 
> Is there any reason you can't use the existing
> machine_check_powernv_early code to do all this?

Code sharing is nice but if we envision this going to stable kernels
butchering the existing handler is going to be a nightmare. The code is
quite a bit different between kernel versions.

This code as is requires the bit that introduces
EXCEPTION_PROLOG_COMMON_1 and then should work on Linux 3.14+

Thanks

Michal
