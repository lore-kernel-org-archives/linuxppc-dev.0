Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40c8rJ0RKqzF2SM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 19:25:20 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id a14so14244991pfi.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 May 2018 02:25:19 -0700 (PDT)
Date: Thu, 3 May 2018 17:25:15 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 09/11] KVM: PPC: reconstruct LOAD_FP/STORE_FP instruction
 mmio emulation with analyse_intr() input
Message-ID: <20180503092515.GI6755@simonLocalRHEL7.x64>
References: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
 <1524657284-16706-10-git-send-email-wei.guo.simon@gmail.com>
 <20180503061049.GJ6795@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180503061049.GJ6795@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 03, 2018 at 04:10:49PM +1000, Paul Mackerras wrote:
> On Wed, Apr 25, 2018 at 07:54:42PM +0800, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > This patch reconstructs LOAD_FP/STORE_FP instruction MMIO emulation with
> > analyse_intr() input. It utilizes the FPCONV/UPDATE properties exported by
> > analyse_instr() and invokes kvmppc_handle_load(s)/kvmppc_handle_store()
> > accordingly.
> > 
> > The FP regs need to be flushed so that the right FP reg vals can be read
> > from vcpu->arch.fpr.
> 
> This only applies for store instructions; it would be clearer if you
> said that explicitly.
I will correct this message.

> 
> > 
> > Suggested-by: Paul Mackerras <paulus@ozlabs.org>
> > Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> 
> Same comment about updating RA as for the other patches.  Otherwise
> this looks fine.
> 
> Paul.

Thanks,
- Simon
