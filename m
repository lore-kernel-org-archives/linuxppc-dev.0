Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mZyz5BSvzF14x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 12:30:19 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id u6-v6so1548237pls.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 19:30:19 -0700 (PDT)
Date: Thu, 17 May 2018 10:30:15 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 05/10] KVM: PPC: reimplement non-SIMD LOAD/STORE
 instruction mmio emulation with analyse_intr() input
Message-ID: <20180517023015.GB2754@simonLocalRHEL7.x64>
References: <1525674016-6703-1-git-send-email-wei.guo.simon@gmail.com>
 <1525674016-6703-6-git-send-email-wei.guo.simon@gmail.com>
 <20180516234918.GB24778@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180516234918.GB24778@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,
On Thu, May 17, 2018 at 09:49:18AM +1000, Paul Mackerras wrote:
> On Mon, May 07, 2018 at 02:20:11PM +0800, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > This patch reimplements non-SIMD LOAD/STORE instruction MMIO emulation
> > with analyse_intr() input. It utilizes the BYTEREV/UPDATE/SIGNEXT
> > properties exported by analyse_instr() and invokes
> > kvmppc_handle_load(s)/kvmppc_handle_store() accordingly.
> > 
> > It also move CACHEOP type handling into the skeleton.
> > 
> > instruction_type within kvm_ppc.h is renamed to avoid conflict with
> > sstep.h.
> > 
> > Suggested-by: Paul Mackerras <paulus@ozlabs.org>
> > Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> 
> Looks pretty good, but one comment below...
> 
> > -		case OP_31_XOP_LWAUX:
> > -			emulated = kvmppc_handle_loads(run, vcpu, rt, 4, 1);
> > -			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
> > -			break;
> > +	if (emulated == EMULATE_DONE)
> > +		goto out;
> 
> Shouldn't this also goto out if emulated == EMULATE_DO_MMIO?
Yes. Let me update this.

Thanks,
- Simon
