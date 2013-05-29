Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 478622C0087
 for <linuxppc-dev@ozlabs.org>; Thu, 30 May 2013 09:57:47 +1000 (EST)
Message-ID: <1369871852.3928.79.camel@pasglop>
Subject: Re: [PATCH] KVM: PPC: Book3S: Add support for H_IPOLL and H_XIRR_X
 in XICS emulation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Thu, 30 May 2013 09:57:32 +1000
In-Reply-To: <1369870703.18630.49@snotra>
References: <1369870703.18630.49@snotra>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-05-29 at 18:38 -0500, Scott Wood wrote:

> > Yes. I'd like to have them in. Their implementation is actually fairly
> > trivial and they cannot be emulated by qemu if the rest of the XICS is
> > in the kernel, so it's a problem.
> 
> OK.  Does it make more sense for you to take it as Paul suggested, or  
> for Gleb or Marcelo to pick it up directly?

I'll take it.

> Then rm_action should always be 0 for these hcalls, right?  So there's  
> no correctness reason to keep the hcalls in separate switch  
> statements.  You shave off a few cycles checking rm_action, at the cost  
> of needing to change kvmppc_xics_hcall() if a real-mode version of  
> these hcalls is ever done.

No, because rm_action will also be 0 if the hcall was fully done in real
mode (which can happen, that's our fast path), in which case we do *NOT*
want to to be re-done in virtual mode.

That's why we always return whether rm_action is 0 or not when real-mode
is enabled.

Cheers,
Ben.
