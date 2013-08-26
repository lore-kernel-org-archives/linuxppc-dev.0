Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: Detecting LD/ST instruction
In-reply-to: <20130824084734.GA30210@us.ibm.com>
References: <20130822225525.GA5214@us.ibm.com>
 <5184.1377214264@ale.ozlabs.ibm.com> <20130824084734.GA30210@us.ibm.com>
Date: Mon, 26 Aug 2013 11:37:05 +1000
Message-ID: <27850.1377481025@ale.ozlabs.ibm.com>
Cc: eraninan@google.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> wrote:

> Michael Neuling [mikey@neuling.org] wrote:
> | > I am working on implementing the 'perf mem' command for Power
> | > systems. This would for instance, let us know where in the memory
> | > hierarchy (L1, L2, Local RAM etc) the data for a load/store
> | > instruction was found (hit).
> | > 
> | > On Power7, if the mcmcra[DCACHE_MISS] is clear _and_ the
> | > instruction is a load/store, then it implies a L1-hit.
> | > 
> | > Unlike on Power8, the Power7 event vector has no indication
> | > if the instruction was load/store.
> | > 
> | > In the context of a PMU interrupt, is there any way to determine
> | > if an instruction is a load/store ?
> | 
> | You could read the instruction from memory and work it out.  
> | 
> | We do something similar to this in power_pmu_bhrb_to() where we read the
> | instruction and work out where the branch is going to.
> | 
> | If you do this, please use and/or extend the functions in
> | arch/powerpc/lib/code-patching.c
> 
> Here is a draft of what I could come up with.  With this patch, 
> the number of L1 hits on Power7 matches that on Power8 for one
> application.

Nice, the approach is along the lines of what I was thinking.

> But, wondering if there is a more efficient way to do this - there
> are over 50 flavors of load and store!

I dunno, there might be.  If you look at all the opcodes in binary,
there's often a nice little pattern you can use. 

Did you catch all the VSX and VMX loads/stores?

<snip>
> +	if (op == 31) {
> +		n = sizeof(x_form_load_store) / sizeof(int);
> +
> +		for (i = 0; i < n; i++) {

Yeah, this might be a bit slow... Are there any instructions with op ==
31 that aren't a load/store?

> 
> +			if (x_form_load_store[i] == load_store_xval(*instr))
> +				return 1;
> +		}
> +	}
> +
> +	return 0;
> +}
