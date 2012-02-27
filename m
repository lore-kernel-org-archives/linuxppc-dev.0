Return-Path: <R65777@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe002.messaging.microsoft.com
 [65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E5B06B6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2012 05:29:15 +1100 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [PATCH 24/37] KVM: PPC: booke: rework rescheduling checks
Date: Mon, 27 Feb 2012 18:29:06 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D141615@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1330093591-19523-1-git-send-email-agraf@suse.de>
 <1330093591-19523-25-git-send-email-agraf@suse.de>
 <6A3DF150A5B70D4F9B66A25E3F7C888D141083@039-SN2MPN1-023.039d.mgd.msft.net>
 <4F4BBE55.6020204@suse.de> <4F4BCA1F.5040905@suse.de>
In-Reply-To: <4F4BCA1F.5040905@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Alexander Graf [mailto:agraf@suse.de]
> Sent: Monday, February 27, 2012 11:53 PM
> To: Bhushan Bharat-R65777
> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-dev@lists.ozla=
bs.org;
> Wood Scott-B07421
> Subject: Re: [PATCH 24/37] KVM: PPC: booke: rework rescheduling checks
>=20
> On 02/27/2012 06:33 PM, Alexander Graf wrote:
> > On 02/27/2012 05:34 PM, Bhushan Bharat-R65777 wrote:
> >>
> >>> +}
> >>> +
> >>> +/*
> >>> + * Common checks before entering the guest world.  Call with
> >>> interrupts
> >>> + * disabled.
> >>> + *
> >>> + * returns !0 if a signal is pending and check_signal is true  */
> >>> +static int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu, bool
> >>> +check_signal) {
> >>> +    int r =3D 0;
> >>> +
> >>> +    WARN_ON_ONCE(!irqs_disabled());
> >>> +    while (true) {
> >>> +        if (need_resched()) {
> >>> +            local_irq_enable();
> >>> +            cond_resched();
> >>> +            local_irq_disable();
> >>> +            continue;
> >>> +        }
> >>> +
> >>> +        if (kvmppc_core_prepare_to_enter(vcpu)) {
> >> kvmppc_prepare_to_enter() is called even on heavyweight_exit. Should
> >> not this be called only on lightweight_exit?
> >
> > Yeah, we don't need to call it when exiting anyways. That's a
> > functional change though, which this patch is trying not to introduce.
> > So we should rather do that as a patch on top.
>=20
> So how about this (warning! broken whitespace)?
>=20
>=20
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c index
> 7a16b56..616aa2d 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -464,7 +464,7 @@ int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcp=
u)
>    *
>    * returns !0 if a signal is pending and check_signal is true
>    */
> -static int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu, bool
> check_signal)
> +static int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>   {
>          int r =3D 0;
>=20
> @@ -483,7 +483,7 @@ static int kvmppc_prepare_to_enter(struct kvm_vcpu *v=
cpu,
> bool check_signal)
>                          continue;
>                  }
>=20
> -               if (check_signal && signal_pending(current))
> +               if (signal_pending(current))
>                          r =3D 1;
>=20
>                  break;
> @@ -507,7 +507,7 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct k=
vm_vcpu
> *vcpu)
>          }
>=20
>          local_irq_disable();
> -       if (kvmppc_prepare_to_enter(vcpu, true)) {
> +       if (kvmppc_prepare_to_enter(vcpu)) {
>                  kvm_run->exit_reason =3D KVM_EXIT_INTR;
>                  ret =3D -EINTR;
>                  goto out;
> @@ -941,13 +941,16 @@ int kvmppc_handle_exit(struct kvm_run *run, struct
> kvm_vcpu *vcpu,
>           * To avoid clobbering exit_reason, only check for signals if we
>           * aren't already exiting to userspace for some other reason.
>           */
> -       local_irq_disable();
> -       if (kvmppc_prepare_to_enter(vcpu, !(r & RESUME_HOST))) {
> -               run->exit_reason =3D KVM_EXIT_INTR;
> -               r =3D (-EINTR << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
> -               kvmppc_account_exit(vcpu, SIGNAL_EXITS);
> +       if (!(r & RESUME_HOST)) {
> +               local_irq_disable();
> +               if (kvmppc_prepare_to_enter(vcpu)) {
> +                       run->exit_reason =3D KVM_EXIT_INTR;
> +                       r =3D (-EINTR << 2) | RESUME_HOST | (r &
> RESUME_FLAG_NV);
> +                       kvmppc_account_exit(vcpu, SIGNAL_EXITS);
> +               }
>          }
>=20
> +out:

Why?
Otherwise looks ok to me.

Thanks
-Bharat

>          return r;
>   }
>=20
>=20
