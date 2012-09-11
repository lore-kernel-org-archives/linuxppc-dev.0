Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D3C432C0086
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 15:37:30 +1000 (EST)
Message-ID: <1347341841.2603.31.camel@pasglop>
Subject: Re: [PATCH 5/6] powerpc: Macros for saving/restore PPR
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Date: Tue, 11 Sep 2012 15:37:21 +1000
In-Reply-To: <504EC99B.7000302@linux.vnet.ibm.com>
References: <1347191001.3418.19.camel@hbabu-laptop>
 <1347251044.2385.144.camel@pasglop> <504EC99B.7000302@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, paulus@samba.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-09-10 at 22:18 -0700, Haren Myneni wrote:

> We can also use thread struct, but the saved ppr is needed as long as
> the process is in kernel context. Once the process exits, we do not need
> this value - means the kernel or any other command will not be reading
> this value.
>
>  Even the process can change this value later. Need to add
> ppr in thread_struct which uses extra 8 bytes for each task.

Allright so the real answer is that the thread info is easier to get at
than the thread struct :-) However, the most logical place to put that
stuff is along the lines of the surrounding code... in the pt_regs on
the stack.

It should be fairly easy to carve some space here, for example softe
doesn't have to be 64-bit (it's really one bit, you can make it one
byte, just make sure to adapt the corresponding assembly).

The main issue with that approach is that you then need to audit a bit
to see how pt_regs might be constructed here or there in case you end up
with a 0 (illegal PPR) value in there.

> Whereas thread_info is at the top of stack. No need to allocate extra
> memory. Since the saved process PPR value is needed temporarily whenever
> the process is in kernel, thought thread_info is proper. Also easy to
> read - one less load instruction.

The advantage of pt_regs is that a signal can "peek" at the PPR value
which could be useful for debugging purposes.

> Saving in thread_info:
> 
> ld      r4,area+EX_PPR(r13);
> clrrdi  r5,r1,THREAD_SHIFT;
> std     r4,TI_PPR(r5);
> 
> Saving in thread_struct:
> 
>  ld      r4,PACACURRENT(r13)
>  addi    r5,r4,THREAD
>  ld      r4,paca+EX_PPR(r13);
>  std     r4,THREAD_PPR(r5)
> 
> If you prefer thread_struct, I will change the patch. Please let me know.

Cheers,
Ben.

> Thanks
> Haren
> 
> > 
> > Cheers,
> > Ben.
> > 
> >> +#define RESTORE_PPR(ra,rb)						\
> >> +BEGIN_FTR_SECTION_NESTED(941)						\
> >> +	clrrdi	ra,r1,THREAD_SHIFT;					\
> >> +	ld	rb,TI_PPR(ra);		/* Read PPR from thread_info */	\
> >> +	mtspr	SPRN_PPR,rb;		/* Restore PPR */		\
> >> +END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,941)
> >> +
> >> +#define RESTORE_PPR_PACA(area,ra)					\
> >> +BEGIN_FTR_SECTION_NESTED(942)						\
> >> +	ld	ra,area+EX_PPR(r13);					\
> >> +	mtspr	SPRN_PPR,ra;						\
> >> +END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,942)
> >> +
> >> +#define HMT_MEDIUM_NO_PPR						\
> >> +BEGIN_FTR_SECTION_NESTED(944)						\
> >> +	HMT_MEDIUM;							\
> >> +END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,0,944)  /*non P7*/		
> >> +
> >> +#define HMT_MEDIUM_HAS_PPR(area, ra)					\
> >> +BEGIN_FTR_SECTION_NESTED(943)						\
> >> +	mfspr	ra,SPRN_PPR;						\
> >> +	std	ra,area+EX_PPR(r13);					\
> >> +	HMT_MEDIUM;							\
> >> +END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,943) /* P7 */
> >> +
> >>  #define __EXCEPTION_PROLOG_1(area, extra, vec)				\
> >>  	GET_PACA(r13);							\
> >>  	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
> >> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> >> index 6386086..dff2f89 100644
> >> --- a/arch/powerpc/include/asm/reg.h
> >> +++ b/arch/powerpc/include/asm/reg.h
> >> @@ -284,6 +284,7 @@
> >>  #define SPRN_DBAT6U	0x23C	/* Data BAT 6 Upper Register */
> >>  #define SPRN_DBAT7L	0x23F	/* Data BAT 7 Lower Register */
> >>  #define SPRN_DBAT7U	0x23E	/* Data BAT 7 Upper Register */
> >> +#define SPRN_PPR	0x380	/* SMT Thread status Register */
> >>  
> >>  #define SPRN_DEC	0x016		/* Decrement Register */
> >>  #define SPRN_DER	0x095		/* Debug Enable Regsiter */
> > 
> > 
