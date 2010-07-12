Return-Path: <B13201@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8D876B6F19
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 12 Jul 2010 21:24:45 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o6CBOQSn025594 for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 12 Jul 2010 04:24:36 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o6CBbFqa024509
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 12 Jul 2010 06:37:16 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 14/27] KVM: PPC: Magic Page BookE support
Date: Mon, 12 Jul 2010 19:24:23 +0800
Message-ID: <A9833F0F7901024DA08417AA5A9887D9085860@zch01exm26.fsl.freescale.net>
In-Reply-To: <1277980982-12433-15-git-send-email-agraf@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
	<1277980982-12433-15-git-send-email-agraf@suse.de>
From: "Liu Yu-B13201" <B13201@freescale.com>
To: "Alexander Graf" <agraf@suse.de>, <kvm-ppc@vger.kernel.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: kvm-owner@vger.kernel.org=20
> [mailto:kvm-owner@vger.kernel.org] On Behalf Of Alexander Graf
> Sent: Thursday, July 01, 2010 6:43 PM
> To: kvm-ppc@vger.kernel.org
> Cc: KVM list; linuxppc-dev
> Subject: [PATCH 14/27] KVM: PPC: Magic Page BookE support
>=20
> As we now have Book3s support for the magic page, we also=20
> need BookE to
> join in on the party.
>=20
> This patch implements generic magic page logic for BookE and specific
> TLB logic for e500. I didn't have any 440 around, so I didn't dare to
> blindly try and write up broken code.
>=20
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  arch/powerpc/kvm/booke.c    |   29 +++++++++++++++++++++++++++++
>  arch/powerpc/kvm/e500_tlb.c |   19 +++++++++++++++++--
>  2 files changed, 46 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 0f8ff9d..9609207 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c

> @@ -380,6 +406,9 @@ int kvmppc_handle_exit(struct kvm_run=20
> *run, struct kvm_vcpu *vcpu,
>  		gpa_t gpaddr;
>  		gfn_t gfn;
> =20
> +		if (kvmppc_dtlb_magic_page(vcpu, eaddr))
> +			break;
> +
>  		/* Check the guest TLB. */
>  		gtlb_index =3D kvmppc_mmu_dtlb_index(vcpu, eaddr);
>  		if (gtlb_index < 0) {

How about moving this part into tlb search fail path?
