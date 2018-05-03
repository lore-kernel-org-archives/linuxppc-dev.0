Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40c4sm73RgzF2Tn
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 16:26:20 +1000 (AEST)
Date: Thu, 3 May 2018 16:10:49 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 09/11] KVM: PPC: reconstruct LOAD_FP/STORE_FP instruction
 mmio emulation with analyse_intr() input
Message-ID: <20180503061049.GJ6795@fergus.ozlabs.ibm.com>
References: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
 <1524657284-16706-10-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524657284-16706-10-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 25, 2018 at 07:54:42PM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> This patch reconstructs LOAD_FP/STORE_FP instruction MMIO emulation with
> analyse_intr() input. It utilizes the FPCONV/UPDATE properties exported by
> analyse_instr() and invokes kvmppc_handle_load(s)/kvmppc_handle_store()
> accordingly.
> 
> The FP regs need to be flushed so that the right FP reg vals can be read
> from vcpu->arch.fpr.

This only applies for store instructions; it would be clearer if you
said that explicitly.

> 
> Suggested-by: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

Same comment about updating RA as for the other patches.  Otherwise
this looks fine.

Paul.
