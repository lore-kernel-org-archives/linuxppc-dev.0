Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2C1DBB6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Feb 2012 23:00:03 +1100 (EST)
Subject: Re: [PATCH 36/37] KVM: PPC: booke: expose guest registers on irq
 reinject
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4F481FE1.1080404@freescale.com>
Date: Sun, 26 Feb 2012 12:59:58 +0100
Message-Id: <810950A7-CD5A-46A5-865B-1209A5532DCC@suse.de>
References: <1330093591-19523-1-git-send-email-agraf@suse.de>
 <1330093591-19523-37-git-send-email-agraf@suse.de>
 <4F481FE1.1080404@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 25.02.2012, at 00:40, Scott Wood wrote:

> On 02/24/2012 08:26 AM, Alexander Graf wrote:
>> +static void kvmppc_fill_pt_regs(struct kvm_vcpu *vcpu, struct =
pt_regs *regs)
>> {
>> -	int r =3D RESUME_HOST;
>> +	int i;
>>=20
>> -	/* update before a new last_exit_type is rewritten */
>> -	kvmppc_update_timing_stats(vcpu);
>> +	for (i =3D 0; i < 32; i++)
>> +		regs->gpr[i] =3D kvmppc_get_gpr(vcpu, i);
>> +	regs->nip =3D vcpu->arch.pc;
>> +	regs->msr =3D vcpu->arch.shared->msr;
>> +	regs->ctr =3D vcpu->arch.ctr;
>> +	regs->link =3D vcpu->arch.lr;
>> +	regs->xer =3D kvmppc_get_xer(vcpu);
>> +	regs->ccr =3D kvmppc_get_cr(vcpu);
>> +	regs->dar =3D get_guest_dear(vcpu);
>> +	regs->dsisr =3D get_guest_esr(vcpu);
>> +}
>=20
> How much overhead does this add to every interrupt?  Can't we keep =
this
> to the minimum that perf cares about?

I would rather not make assumptions on what perf cares about - maybe we =
want to one day implement "perf kvm" and then perf could rely on pretty =
much anything in there.

>=20
>> +
>> +static void kvmppc_restart_interrupt(struct kvm_vcpu *vcpu,
>> +				     unsigned int exit_nr)
>> +{
>> +	struct pt_regs regs =3D *current->thread.regs;
>>=20
>> +	kvmppc_fill_pt_regs(vcpu, &regs);
>=20
> Why are you copying out of current->thread.regs?  That's old junk =
data,
> set by some previous exception and possibly overwritten since.

Because it gives us good default values for anything we don't set. Do =
you have other recommendations?


Alex
