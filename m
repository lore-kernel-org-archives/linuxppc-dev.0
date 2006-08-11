Return-Path: <mkravetz@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6E7E067BA6
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 04:29:39 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7BITWMG024024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 14:29:34 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k7BITVXU273490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 14:29:32 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7BITVTt012347
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 14:29:31 -0400
Date: Fri, 11 Aug 2006 11:30:30 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC] asm code for Hypervisor Call Instrumentation
Message-ID: <20060811183029.GA4535@monkey.ibm.com>
References: <20060802175947.GA7489@w-mikek2.ibm.com>
	<17622.56592.41532.206800@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17622.56592.41532.206800@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 07, 2006 at 04:26:24PM +1000, Paul Mackerras wrote:
> Hmmm, doing the update in assembly would avoid the need to create a
> stack frame, which would be nice...  Maybe we need to add some macros
> to include/asm-powerpc/percpu.h to make it easier to access per-cpu
> variables from assembly code.
> 
> Alternatively, we could put a pointer to the hcall_stats array for
> each cpu in its paca.  That's very easily accessed from assembly code.

I finally got around to doing the update in assembly.  I have attached
the code in question below.  Macros were added (elsewhere) for things like 
stat structure and offsets within the structure.  No macros for per-cpu
data.  Rather, I just used some existing definitions and based code on
descriptions in asm-powerpc/percpu.h.  Let me know if this introduces too
many (unchecked at compile time assumptions) into the code.

The many comments are mostly for my benefit. :)

Thanks,
-- 
Mike

#define STK_PARM(i)     (48 + ((i)-3)*8)

#ifdef CONFIG_HCALL_STATS
/*
 * precall must preserve all registers.  use unused STK_PARM()
 * areas to save snapshots and opcode.
 */
#define HCALL_INST_PRECALL					\
	std	r3,STK_PARM(r3)(r1);	/* save opcode */	\
	mftb	r3;			/* get timebase and */	\
	std     r3,STK_PARM(r5)(r1);	/* save for later */	\
BEGIN_FTR_SECTION;						\
	mfspr	r3,SPRN_PURR;		/* get PURR and */	\
END_FTR_SECTION_IFSET(CPU_FTR_PURR);				\
	std	r3,STK_PARM(r6)(r1);	/* save for later */	\
	ld	r3,STK_PARM(r3)(r1);	/* opcode back in r3 */
	
/*
 * postcall is performed immediately before function return which
 * allows liberal use of non-volital registers.
 */
#define HCALL_INST_POSTCALL					\
	/* get time and PURR snapshots after hcall */		\
	mftb	r7;			/* timebase after */	\
BEGIN_FTR_SECTION;						\
	mfspr	r8,SPRN_PURR;		/* PURR after */	\
END_FTR_SECTION_IFSET(CPU_FTR_PURR);				\
								\
	/* calculate time and PURR deltas for call */		\
	ld	r5,STK_PARM(r5)(r1);	/* timebase before */	\
	subf	r5,r5,r7;					\
	ld	r6,STK_PARM(r6)(r1);	/* PURR before */	\
	subf	r6,r6,r8;					\
								\
	/* calculate address of stat structure */		\
	ld	r4,STK_PARM(r3)(r1);	/* use opcode as */	\
	rldicl	r4,r4,62,2;		/* index into array */	\
	mulli	r4,r4,HCALL_STAT_SIZE;				\
	LOAD_REG_ADDR(r7, per_cpu__hcall_stats);		\
	add	r4,r4,r7;					\
	ld	r7,PACA_DATA_OFFSET(r13); /* per cpu offset */	\
	add	r4,r4,r7;					\
								\
	/* update stats	*/					\
	ld	r7,HCALL_STAT_CALLS(r4); /* count */		\
	addi	r7,r7,1;					\
	std	r7,HCALL_STAT_CALLS(r4);			\
	ld      r7,HCALL_STAT_TB(r4);	/* timebase */		\
	add	r7,r7,r5;					\
	std	r7,HCALL_STAT_TB(r4);				\
	ld	r7,HCALL_STAT_PURR(r4);	/* PURR */		\
	add	r7,r7,r6;					\
	std	r7,HCALL_STAT_PURR(r4);
#else

#define HCALL_INST_PRECALL
#define HCALL_INST_POSTCALL
#endif
