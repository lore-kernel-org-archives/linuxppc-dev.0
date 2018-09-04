Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424h7l1Y9DzF09x
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 08:18:58 +1000 (AEST)
Date: Tue, 4 Sep 2018 17:12:23 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Sandipan Das <sandipan@linux.ibm.com>
Cc: mpe@ellerman.id.au, paulus@samba.org, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, anton@samba.org, ravi.bangoria@linux.ibm.com
Subject: Re: [PATCH 1/6] powerpc sstep: Add maddhd, maddhdu,
 maddld instruction emulation
Message-ID: <20180904221223.GR24439@gate.crashing.org>
References: <cover.1535609090.git.sandipan@linux.ibm.com>
 <2962112510464de01b24f9e1014909fde3380d52.1535609090.git.sandipan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2962112510464de01b24f9e1014909fde3380d52.1535609090.git.sandipan@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 03, 2018 at 08:49:33PM +0530, Sandipan Das wrote:
> +#ifdef __powerpc64__
> +	case 4:
> +		if (!cpu_has_feature(CPU_FTR_ARCH_300))
> +			return -1;
> +
> +		switch (instr & 0x3f) {
> +		case 48:	/* maddhd */
> +			asm("maddhd %0,%1,%2,%3" : "=r" (op->val) :
> +			    "r" (regs->gpr[ra]), "r" (regs->gpr[rb]),
> +			    "r" (regs->gpr[rc]));
> +			goto compute_done;

If running maddhd does not work, will running it in kernel mode work?

I think you should *actually* emulate it.

(Same for the next patch, "darn", but emulation of that is much more
interesting).


Segher
