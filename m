Return-Path: <anton@ozlabs.org>
Date: Mon, 19 Oct 2009 11:42:26 +1100
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 3/3] powerpc perf_event: Add alignment-faults and
	emulation-faults software events
Message-ID: <20091019004226.GT4808@kryten>
References: <20091018110929.GK4808@kryten> <20091018111126.GL4808@kryten>
	<20091018111300.GM4808@kryten> <1255909805.4192.5.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1255909805.4192.5.camel@concordia>
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> > +#define PPC_WARN_ALIGNMENT(type, regs)				\
> > +	do {								\
> > +		perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS,		\
> > +			1, 0, regs, regs->dar);				\
> > +		__PPC_WARN_EMULATED(type);				\
> > +	} while (0)
> 
> Does that work with perfxxx configured off?

Yeah, perf_event.h defines an empty version if its configured off:

static inline void
perf_sw_event(u32 event_id, u64 nr, int nmi,
                     struct pt_regs *regs, u64 addr)                    { }

Anton
