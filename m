Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mWlQ4cLFzF0QC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 10:05:06 +1000 (AEST)
Date: Thu, 17 May 2018 09:49:18 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 05/10] KVM: PPC: reimplement non-SIMD LOAD/STORE
 instruction mmio emulation with analyse_intr() input
Message-ID: <20180516234918.GB24778@fergus.ozlabs.ibm.com>
References: <1525674016-6703-1-git-send-email-wei.guo.simon@gmail.com>
 <1525674016-6703-6-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525674016-6703-6-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 07, 2018 at 02:20:11PM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> This patch reimplements non-SIMD LOAD/STORE instruction MMIO emulation
> with analyse_intr() input. It utilizes the BYTEREV/UPDATE/SIGNEXT
> properties exported by analyse_instr() and invokes
> kvmppc_handle_load(s)/kvmppc_handle_store() accordingly.
> 
> It also move CACHEOP type handling into the skeleton.
> 
> instruction_type within kvm_ppc.h is renamed to avoid conflict with
> sstep.h.
> 
> Suggested-by: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

Looks pretty good, but one comment below...

> -		case OP_31_XOP_LWAUX:
> -			emulated = kvmppc_handle_loads(run, vcpu, rt, 4, 1);
> -			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
> -			break;
> +	if (emulated == EMULATE_DONE)
> +		goto out;

Shouldn't this also goto out if emulated == EMULATE_DO_MMIO?

Paul.
