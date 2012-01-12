Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 56C81B6EFF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2012 17:44:43 +1100 (EST)
Message-ID: <1326350666.23910.209.camel@pasglop>
Subject: Re: [RFC PATCH 14/16] KVM: PPC: booke: category E.HV (GS-mode) support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Thu, 12 Jan 2012 17:44:26 +1100
In-Reply-To: <A1483A2E-FF86-4E25-93CC-9EA1BA4925D4@suse.de>
References: <20111221013443.GN8378@schlenkerla.am.freescale.net>
 <1A656B06-E290-4B75-8F98-F8FAB8B817F1@suse.de> <4F0B8B7D.4@freescale.com>
 <A1483A2E-FF86-4E25-93CC-9EA1BA4925D4@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-01-10 at 04:11 +0100, Alexander Graf wrote:
> This is what book3s does:
> 
>                 case EMULATE_FAIL:
>                         printk(KERN_CRIT "%s: emulation at %lx failed
> (%08x)\n",
>                                __func__, kvmppc_get_pc(vcpu),
> kvmppc_get_last_inst(vcpu));
>                         kvmppc_core_queue_program(vcpu, flags);
>                         r = RESUME_GUEST;
> 
> which also doesn't throttle the printk, but I think injecting a
> program fault into the guest is the most sensible thing to do if we
> don't know what the instruction is supposed to do. Best case we get an
> oops inside the guest telling us what broke :).

You can also fallback to a slow path that reads the guest TLB,
translates then reads the instruction. Of course you have to be careful
as such a manual translate + read + execute needs to be somewhat
synchronized with a possible TLB invalidation :-)

(MMIO emulation is broken in this regard too btw)

Cheers,
Ben.
