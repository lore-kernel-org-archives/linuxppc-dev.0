Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40c7ww70KTzF2T1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 18:44:16 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id g20-v6so5949192pgv.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 May 2018 01:44:16 -0700 (PDT)
Date: Thu, 3 May 2018 16:37:37 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 05/11] KVM: PPC: add GPR RA update skeleton for MMIO
 emulation
Message-ID: <20180503083737.GE6755@simonLocalRHEL7.x64>
References: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
 <1524657284-16706-6-git-send-email-wei.guo.simon@gmail.com>
 <20180503055814.GF6795@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180503055814.GF6795@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 03, 2018 at 03:58:14PM +1000, Paul Mackerras wrote:
> On Wed, Apr 25, 2018 at 07:54:38PM +0800, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > To optimize kvm emulation code with analyse_instr, adds new
> > mmio_update_ra flag to aid with GPR RA update.
> > 
> > This patch arms RA update at load/store emulation path for both
> > qemu mmio emulation or coalesced mmio emulation.
> 
> It's not clear to me why you need to do this.  The existing code
> writes RA at the point where the instruction is decoded.  In later
> patches, you change that so the RA update occurs after the MMIO
> operation is performed.  Is there a particular reason why you made
> that change?
> 
> Paul.

I wanted to avoid the case that GPR RA was updated even when EMULATE_FAIL. But
if it is not mandatory, I can update RA in kvmppc_emulate_loadstore()
instead..

Thanks,
- Simon
