Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424ftT0HZXzF35q
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 07:22:24 +1000 (AEST)
Date: Tue, 4 Sep 2018 16:21:09 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Sandipan Das <sandipan@linux.ibm.com>
Cc: mpe@ellerman.id.au, paulus@samba.org, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, anton@samba.org, ravi.bangoria@linux.ibm.com
Subject: Re: [PATCH 6/6] powerpc sstep: Add modsd, modud instruction emulation
Message-ID: <20180904212109.GP24439@gate.crashing.org>
References: <cover.1535609090.git.sandipan@linux.ibm.com>
 <15e572f61bb5c74b01210b9245ce2750a31d6002.1535609090.git.sandipan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15e572f61bb5c74b01210b9245ce2750a31d6002.1535609090.git.sandipan@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 03, 2018 at 08:49:38PM +0530, Sandipan Das wrote:
> +#ifdef __powerpc64__
> +		case 265:	/* modud */
> +			if (!cpu_has_feature(CPU_FTR_ARCH_300))
> +				return -1;
> +			op->val = regs->gpr[ra] % regs->gpr[rb];
> +			goto compute_done;
> +#endif

The mod instruction has special cases that aren't handled by this C code,
too (divide by 0, or signed division of the most negative number by -1).
For the mod intruction the behaviour is undefined in those cases, but you
probably should force some specific behaviour.  You don't want the kernel
to execute a trap instruction, etc. :-)


Segher
