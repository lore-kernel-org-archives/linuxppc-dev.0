Return-Path: <santosh@fossix.org>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9VZ7068HzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Oct 2017 17:23:58 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id z11so7864329pfk.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Oct 2017 23:23:58 -0700 (PDT)
Date: Mon, 9 Oct 2017 11:53:53 +0530
From: Santosh Sivaraj <santosh@fossix.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/vdso64: Add support for
 CLOCK_{REALTIME/MONOTONIC}_COARSE
Message-ID: <20171009062353.5axbrfjw2lu4yjns@santosiv.in.ibm.com>
References: <20170918092336.21912-1-santosh@fossix.org>
 <20170918092336.21912-2-santosh@fossix.org>
 <20171006112528.zryd4l2yl2k6xk2h@naverao1-tp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171006112528.zryd4l2yl2k6xk2h@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com> wrote (on 2017-10-06 11:25:28 +0000):

> On 2017/09/18 09:23AM, Santosh Sivaraj wrote:
> > Current vDSO64 implementation does not have support for coarse clocks
> > (CLOCK_MONOTONIC_COARSE, CLOCK_REALTIME_COARSE), for which it falls back
> > to system call, increasing the response time, vDSO implementation reduces
> > the cycle time. Below is a benchmark of the difference in execution time
> > with and without vDSO support.
> > 
> > (Non-coarse clocks are also included just for completion)
> > 
> > Without vDSO support:
> > --------------------
> > clock-gettime-realtime: syscall: 172 nsec/call
> > clock-gettime-realtime:    libc: 26 nsec/call
> > clock-gettime-realtime:    vdso: 21 nsec/call
> > clock-gettime-monotonic: syscall: 170 nsec/call
> > clock-gettime-monotonic:    libc: 30 nsec/call
> > clock-gettime-monotonic:    vdso: 24 nsec/call
> > clock-gettime-realtime-coarse: syscall: 153 nsec/call
> > clock-gettime-realtime-coarse:    libc: 15 nsec/call
> > clock-gettime-realtime-coarse:    vdso: 9 nsec/call
> > clock-gettime-monotonic-coarse: syscall: 167 nsec/call
> > clock-gettime-monotonic-coarse:    libc: 15 nsec/call
> > clock-gettime-monotonic-coarse:    vdso: 11 nsec/call
> > 
> > CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> > ---
> >  arch/powerpc/kernel/asm-offsets.c         |  2 ++
> >  arch/powerpc/kernel/vdso64/gettimeofday.S | 56 +++++++++++++++++++++++++++++++
> >  2 files changed, 58 insertions(+)
> > 
> > diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> > index 8cfb20e38cfe..b55c68c54dc1 100644
> > --- a/arch/powerpc/kernel/asm-offsets.c
> > +++ b/arch/powerpc/kernel/asm-offsets.c
> > @@ -396,6 +396,8 @@ int main(void)
> >  	/* Other bits used by the vdso */
> >  	DEFINE(CLOCK_REALTIME, CLOCK_REALTIME);
> >  	DEFINE(CLOCK_MONOTONIC, CLOCK_MONOTONIC);
> > +	DEFINE(CLOCK_REALTIME_COARSE, CLOCK_REALTIME_COARSE);
> > +	DEFINE(CLOCK_MONOTONIC_COARSE, CLOCK_MONOTONIC_COARSE);
> >  	DEFINE(NSEC_PER_SEC, NSEC_PER_SEC);
> >  	DEFINE(CLOCK_REALTIME_RES, MONOTONIC_RES_NSEC);
> > 
> > diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
> > index a0b4943811db..bae197a81add 100644
> > --- a/arch/powerpc/kernel/vdso64/gettimeofday.S
> > +++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
> > @@ -71,6 +71,11 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
> >  	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
> >  	beq	cr0,49f
> > 
> > +	cmpwi	cr0,r3,CLOCK_REALTIME_COARSE
> > +	cmpwi	cr1,r3,CLOCK_MONOTONIC_COARSE
> > +	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
> > +	beq	cr0,65f
> > +
> >  	b	99f		/* Fallback to syscall */
> >    .cfi_register lr,r12
> >  49:	bl	V_LOCAL_FUNC(__get_datapage)	/* get data page */
> > @@ -112,6 +117,57 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
> >  1:	bge	cr1,80f
> >  	addi	r4,r4,-1
> >  	add	r5,r5,r7
> > +	b	80f
> > +
> > +	/*
> > +	 * For coarse clocks we get data directly from the vdso data page, so
> > +	 * we don't need to call __do_get_tspec, but we still need to do the
> > +	 * counter trick.
> > +	 */
> > +65:	bl	V_LOCAL_FUNC(__get_datapage)	/* get data page */
> > +70:	ld	r8,CFG_TB_UPDATE_COUNT(r3)
> > +	andi.	r0,r8,1			/* pending update ? loop */
> > +	bne-	70b
> > +	xor	r0,r8,r8		/* create dependency */
> > +	add	r3,r3,r0
> > +
> > +	/*
> > +	 * CLOCK_REALTIME_COARSE, below values are needed for MONOTONIC_COARSE
> > +	 * too
> > +	 */
> > +	ld	r4,STAMP_XTIME+TSPC64_TV_SEC(r3)
> > +	ld	r5,STAMP_XTIME+TSPC64_TV_NSEC(r3)
> > +	bne	cr1,78f
> > +
> > +	/* CLOCK_MONOTONIC_COARSE */
> > +	lwa	r6,WTOM_CLOCK_SEC(r3)
> > +	lwa	r9,WTOM_CLOCK_NSEC(r3)
> > +
> > +	/* check if counter has updated */
> > +78:	or	r0,r6,r9
> > +	xor	r0,r0,r0
> > +	add	r3,r3,r0
> > +	ld	r0,CFG_TB_UPDATE_COUNT(r3)
> > +	cmpld	cr0,r0,r8		/* check if updated */
> > +	bne-	70b
> 
> Don't you need a dependency on r4/r5 here for REALTIME_COARSE?
> Something like:
> 
> 	/* check if counter has updated */
> 	or	r0,r6,r9
> 78:	or	r0,r4,r5
> 	xor	r0,r0,r0
>

Yes, we would need it. Will update in v2.
> > +
> > +	/* Counter has not updated, so continue calculating proper values for
> > +	 * sec and nsec if monotonic coarse, or just return with the proper
> > +	 * values for realtime.
> > +	 */
> > +	bne	cr1,80f
> > +
> 
> I think the below hunk can surely be shared across the _COARSE and 
> regular clocks, if not more.

Yes, except for the label its the same for both monotonic and
monotonic_coarse, will update in the next set.

Thanks,
Santosh
> 
> - Naveen
> 
> > +	/* Add wall->monotonic offset and check for overflow or underflow */
> > +	add	r4,r4,r6
> > +	add	r5,r5,r9
> > +	cmpd	cr0,r5,r7
> > +	cmpdi	cr1,r5,0
> > +	blt	79f
> > +	subf	r5,r7,r5
> > +	addi	r4,r4,1
> > +79:	bge	cr1,80f
> > +	addi	r4,r4,-1
> > +	add	r5,r5,r7
> > 
> >  80:	std	r4,TSPC64_TV_SEC(r11)
> >  	std	r5,TSPC64_TV_NSEC(r11)
> > -- 
> > 2.13.5
> > 
> 

-- 
