Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C606AB6EDF
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jul 2011 21:47:15 +1000 (EST)
Subject: Re: [PATCH 05/17] KVM: PPC: Deliver program interrupts right away
	instead of queueing them
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20110629101852.GF25406@bloggs.ozlabs.ibm.com>
Date: Fri, 1 Jul 2011 13:47:09 +0200
Message-Id: <65ACE3C2-D150-46A6-BE68-6D081A1DCAA7@suse.de>
References: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
	<20110629101852.GF25406@bloggs.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 29.06.2011, at 12:18, Paul Mackerras wrote:

> Doing so means that we don't have to save the flags anywhere and gets
> rid of the last reference to to_book3s(vcpu) in =
arch/powerpc/kvm/book3s.c.
>=20
> Doing so is OK because a program interrupt won't be generated at the
> same time as any other synchronous interrupt.  If a program interrupt
> and an asynchronous interrupt (external or decrementer) are generated
> at the same time, the program interrupt will be delivered, which is
> correct because it has a higher priority, and then the asynchronous
> interrupt will be masked.
>=20
> We don't ever generate system reset or machine check interrupts to the
> guest, but if we did, then we would need to make sure they got =
delivered
> rather than the program interrupt.  The current code would be wrong in
> this situation anyway since it would deliver the program interrupt as
> well as the reset/machine check interrupt.
>=20
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
> arch/powerpc/kvm/book3s.c |    8 +++-----
> 1 files changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index 163e3e1..f68a34d 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -129,8 +129,8 @@ void kvmppc_book3s_queue_irqprio(struct kvm_vcpu =
*vcpu, unsigned int vec)
>=20
> void kvmppc_core_queue_program(struct kvm_vcpu *vcpu, ulong flags)
> {
> -	to_book3s(vcpu)->prog_flags =3D flags;

Now that prog_flags is unused, please remove it from the headers.


Alex
