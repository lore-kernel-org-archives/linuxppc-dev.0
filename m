Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40c4sn2CcYzF2Tl
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 16:26:21 +1000 (AEST)
Date: Thu, 3 May 2018 15:34:01 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/11] KVM: PPC: add pt_regs into kvm_vcpu_arch and move
 vcpu->arch.gpr[] into it
Message-ID: <20180503053401.GB6795@fergus.ozlabs.ibm.com>
References: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
 <1524657284-16706-2-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524657284-16706-2-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 25, 2018 at 07:54:34PM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> Current regs are scattered at kvm_vcpu_arch structure and it will
> be more neat to organize them into pt_regs structure.
> 
> Also it will enable reconstruct MMIO emulation code with

"reimplement" would be clearer than "reconstruct" here, I think.

> @@ -438,7 +438,7 @@ int main(void)
>  	OFFSET(VCPU_TAR, kvm_vcpu, arch.tar);
>  #endif
>  	OFFSET(VCPU_CR, kvm_vcpu, arch.cr);
> -	OFFSET(VCPU_PC, kvm_vcpu, arch.pc);
> +	OFFSET(VCPU_PC, kvm_vcpu, arch.nip);

This hunk shouldn't be in this patch.

Paul.
