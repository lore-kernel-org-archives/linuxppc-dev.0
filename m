Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 32DACB6F0B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Mar 2011 04:25:23 +1100 (EST)
Date: Tue, 29 Mar 2011 12:25:14 -0500
From: Scott Wood <scottwood@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 4/4] KVM: PPC: e500: SPE switch between guest and host
Message-ID: <20110329122514.32c767ca@schlenkerla.am.freescale.net>
In-Reply-To: <6785E5D0-DEE9-4661-88A4-B35A99DB3C66@suse.de>
References: <20110328192559.GC11104@schlenkerla.am.freescale.net>
	<6785E5D0-DEE9-4661-88A4-B35A99DB3C66@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 29 Mar 2011 11:47:51 +0200
Alexander Graf <agraf@suse.de> wrote:

> On 28.03.2011, at 21:25, Scott Wood wrote:
> 
> > @@ -344,10 +345,19 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
> > 		r = RESUME_GUEST;
> > 		break;
> > 
> > -	case BOOKE_INTERRUPT_SPE_UNAVAIL:
> > -		kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_SPE_UNAVAIL);
> > +#ifdef CONFIG_SPE
> > +	case BOOKE_INTERRUPT_SPE_UNAVAIL: {
> 
> This means that on non-SPE enabled host kernels you'll get a KVM fatal error when the guest triggers SPE_UNAVAIL, as the exit simply isn't handled and triggers:
> 
>         default:
>                 printk(KERN_EMERG "exit_nr %d\n", exit_nr);
>                 BUG();

Right, thanks for spotting -- will have it send an illegal instruction trap
to the guest in that case.

-Scott
