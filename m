Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17645.19790.527223.207556@cargo.ozlabs.ibm.com>
Date: Thu, 24 Aug 2006 16:55:10 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: [PATCH] powerpc: Instrument Hypervisor Calls
In-Reply-To: <20060816160456.GA4170@w-mikek2.ibm.com>
References: <20060816160456.GA4170@w-mikek2.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mike Kravetz writes:

> Add instrumentation for hypervisor calls on pseries.  Call statistics
> include number of calls, wall time and cpu cycles (if available) and
> are made available via debugfs.  Instrumentation code is behind the
> HCALL_STATS config option and has no impact if not enabled.

Starting to look really good, just a few minor comments below...

> +/*
> + * precall must preserve all registers.  use unused STK_PARM()
> + * areas to save snapshots and opcode.
> + */
> +#define HCALL_INST_PRECALL					\
> +	std	r3,STK_PARM(r3)(r1);	/* save opcode */	\
> +	mftb	r3;			/* get timebase and */	\
> +	std     r3,STK_PARM(r5)(r1);	/* save for later */	\
> +BEGIN_FTR_SECTION;						\
> +	mfspr	r3,SPRN_PURR;		/* get PURR and */	\
> +	std	r3,STK_PARM(r6)(r1);	/* save for later */	\
> +END_FTR_SECTION_IFSET(CPU_FTR_PURR);				\
> +	ld	r3,STK_PARM(r3)(r1);	/* opcode back in r3 */

You can use r0 here; maybe you could use it instead of having to
restore r3 (I see that you still need to save r3 for later).

> + * postcall is performed immediately before function return which
> + * allows liberal use of volital registers.

"volatile"

> +	/* calculate address of stat structure */		\
> +	ld	r4,STK_PARM(r3)(r1);	/* use opcode as */	\
> +	rldicl	r4,r4,62,2;		/* index into array */	\
> +	mulli	r4,r4,HCALL_STAT_SIZE;				\

It's a pity our multiplies are slow (6 cycles).  The rldicl would I
think be more clearly expressed as srdi r4,r4,2.  We could use a shift
and add instead of the multiply if we put a big fat comment in the
header that defines the structure warning people to adjust the
assembly if they change the structure.  Might not be worth it though.

> +	LOAD_REG_ADDR(r7, per_cpu__hcall_stats);		\

We could use a load from the TOC here rather than the 5 instructions
that LOAD_REG_ADDR turns into.  Look at some gcc -S output to see how
it's done.

BTW are we going to die horribly if someone uses an hcall greater than
MAX_HCALL_OPCODES?  The hcall functions are available to modules, so
it would be quite possible for a module to come along and try to use
some new hcalls that weren't known about when the kernel was built.

Paul.
