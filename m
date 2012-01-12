Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D42F8B6EFF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2012 03:26:24 +1100 (EST)
Date: Thu, 12 Jan 2012 10:26:14 -0600
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 14/16] KVM: PPC: booke: category E.HV (GS-mode) support
Message-ID: <20120112162614.GB23595@schlenkerla.am.freescale.net>
References: <20111221013443.GN8378@schlenkerla.am.freescale.net>
 <1A656B06-E290-4B75-8F98-F8FAB8B817F1@suse.de>
 <4F0B8B7D.4@freescale.com>
 <A1483A2E-FF86-4E25-93CC-9EA1BA4925D4@suse.de>
 <1326350666.23910.209.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1326350666.23910.209.camel@pasglop>
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.de>, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 12, 2012 at 05:44:26PM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2012-01-10 at 04:11 +0100, Alexander Graf wrote:
> > This is what book3s does:
> > 
> >                 case EMULATE_FAIL:
> >                         printk(KERN_CRIT "%s: emulation at %lx failed
> > (%08x)\n",
> >                                __func__, kvmppc_get_pc(vcpu),
> > kvmppc_get_last_inst(vcpu));
> >                         kvmppc_core_queue_program(vcpu, flags);
> >                         r = RESUME_GUEST;
> > 
> > which also doesn't throttle the printk, but I think injecting a
> > program fault into the guest is the most sensible thing to do if we
> > don't know what the instruction is supposed to do. Best case we get an
> > oops inside the guest telling us what broke :).
> 
> You can also fallback to a slow path that reads the guest TLB,
> translates then reads the instruction. Of course you have to be careful
> as such a manual translate + read + execute needs to be somewhat
> synchronized with a possible TLB invalidation :-)

That's how we should deal with a failure to read the instruction due to
it being execute-only (once we add the ability to fix up a fault on a
booke KVM instruction fetch) -- but the above code is dealing with the
case where we read the instruction successfully, but don't have an
emulation handler for it.

-Scott
