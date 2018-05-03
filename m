Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40c6Zh4s57zF2Vg
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 17:43:24 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id j5so14025194pfh.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 May 2018 00:43:24 -0700 (PDT)
Date: Thu, 3 May 2018 15:43:19 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/11] KVM: PPC: add pt_regs into kvm_vcpu_arch and move
 vcpu->arch.gpr[] into it
Message-ID: <20180503074304.GB6755@simonLocalRHEL7.x64>
References: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
 <1524657284-16706-2-git-send-email-wei.guo.simon@gmail.com>
 <20180503053401.GB6795@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180503053401.GB6795@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 03, 2018 at 03:34:01PM +1000, Paul Mackerras wrote:
> On Wed, Apr 25, 2018 at 07:54:34PM +0800, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > Current regs are scattered at kvm_vcpu_arch structure and it will
> > be more neat to organize them into pt_regs structure.
> > 
> > Also it will enable reconstruct MMIO emulation code with
> 
> "reimplement" would be clearer than "reconstruct" here, I think.
> 
ok.

> > @@ -438,7 +438,7 @@ int main(void)
> >  	OFFSET(VCPU_TAR, kvm_vcpu, arch.tar);
> >  #endif
> >  	OFFSET(VCPU_CR, kvm_vcpu, arch.cr);
> > -	OFFSET(VCPU_PC, kvm_vcpu, arch.pc);
> > +	OFFSET(VCPU_PC, kvm_vcpu, arch.nip);
> 
> This hunk shouldn't be in this patch.
Yes. sorry my patch split has some issue in patch 00/01.

> 
> Paul.

Thanks,
- Simon
