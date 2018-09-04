Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424lMh0HskzF33c
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 10:44:31 +1000 (AEST)
Date: Tue, 4 Sep 2018 16:12:07 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Sandipan Das <sandipan@linux.ibm.com>
Cc: mpe@ellerman.id.au, paulus@samba.org, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, anton@samba.org, ravi.bangoria@linux.ibm.com
Subject: Re: [PATCH 3/6] powerpc sstep: Add cnttzw,
 cnttzd instruction emulation
Message-ID: <20180904211207.GO24439@gate.crashing.org>
References: <cover.1535609090.git.sandipan@linux.ibm.com>
 <f989c31bcf4bd8a80a50fa6899bcd239ed1bec69.1535609090.git.sandipan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f989c31bcf4bd8a80a50fa6899bcd239ed1bec69.1535609090.git.sandipan@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 03, 2018 at 08:49:35PM +0530, Sandipan Das wrote:
> +		case 538:	/* cnttzw */
> +			if (!cpu_has_feature(CPU_FTR_ARCH_300))
> +				return -1;
> +			val = (unsigned int) regs->gpr[rd];
> +			op->val = ( val ? __builtin_ctz(val) : 32 );
> +			goto logical_done;
> +#ifdef __powerpc64__
> +		case 570:	/* cnttzd */
> +			if (!cpu_has_feature(CPU_FTR_ARCH_300))
> +				return -1;
> +			val = regs->gpr[rd];
> +			op->val = ( val ? __builtin_ctzl(val) : 64 );
> +			goto logical_done;

__builtin_ctz(val) is undefined for val == 0.


Segher
