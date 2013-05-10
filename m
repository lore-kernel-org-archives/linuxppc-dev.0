Return-Path: <R65777@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C48462C0132
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2013 15:01:34 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Alexander Graf <agraf@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: [PATCH v2 2/4] kvm/ppc/booke64: Fix lazy ee handling in
 kvmppc_handle_exit()
Date: Fri, 10 May 2013 05:01:19 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D0700F847@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1368155384-11035-1-git-send-email-scottwood@freescale.com>
 <1368155384-11035-3-git-send-email-scottwood@freescale.com>
In-Reply-To: <1368155384-11035-3-git-send-email-scottwood@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: kvm-ppc-owner@vger.kernel.org [mailto:kvm-ppc-owner@vger.kernel.org=
] On
> Behalf Of Scott Wood
> Sent: Friday, May 10, 2013 8:40 AM
> To: Alexander Graf; Benjamin Herrenschmidt
> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-dev@lists.ozla=
bs.org;
> Wood Scott-B07421
> Subject: [PATCH v2 2/4] kvm/ppc/booke64: Fix lazy ee handling in
> kvmppc_handle_exit()
>=20
> EE is hard-disabled on entry to kvmppc_handle_exit(), so call
> hard_irq_disable() so that PACA_IRQ_HARD_DIS is set, and soft_enabled
> is unset.
>=20
> Without this, we get warnings such as arch/powerpc/kernel/time.c:300,
> and sometimes host kernel hangs.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/kvm/booke.c |    5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 1020119..705fc5c 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -833,6 +833,11 @@ int kvmppc_handle_exit(struct kvm_run *run, struct k=
vm_vcpu
> *vcpu,
>  	int r =3D RESUME_HOST;
>  	int s;
>=20
> +#ifdef CONFIG_PPC64
> +	WARN_ON(local_paca->irq_happened !=3D 0);
> +#endif
> +	hard_irq_disable();

It is not actually to hard disable as EE is already clear but to make it lo=
oks like hard_disable to host. Right?
If so, should we write a comment here on why we are doing this?=20

-Bharat

> +
>  	/* update before a new last_exit_type is rewritten */
>  	kvmppc_update_timing_stats(vcpu);
>=20
> --
> 1.7.10.4
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
