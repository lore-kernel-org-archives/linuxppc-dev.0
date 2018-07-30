Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41f4yW44nNzF0pD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 13:37:39 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6U3YKJw137324
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 23:37:37 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2khtrnr8sv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 23:37:36 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Mon, 30 Jul 2018 04:37:34 +0100
Date: Mon, 30 Jul 2018 13:37:27 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/2] KVM: PPC: Book3S HV: Allow creating max number of
 VCPUs on POWER9
References: <20180726054353.GB1672@fergus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
In-Reply-To: <20180726054353.GB1672@fergus>
Message-Id: <20180730033725.GA28225@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 26, 2018 at 03:43:54PM +1000, Paul Mackerras wrote:
> Commit 1e175d2 ("KVM: PPC: Book3S HV: Pack VCORE IDs to access full
> VCPU ID space", 2018-07-25) allowed use of VCPU IDs up to
> KVM_MAX_VCPU_ID on POWER9 in all guest SMT modes and guest emulated
> hardware SMT modes.  However, with the current definition of
> KVM_MAX_VCPU_ID, a guest SMT mode of 1 and an emulated SMT mode of 8,
> it is only possible to create KVM_MAX_VCPUS / 2 VCPUS, because
> threads_per_subcore is 4 on POWER9 CPUs.  (Using an emulated SMT mode
> of 8 is useful when migrating VMs to or from POWER8 hosts.)
>=20
> This increases KVM_MAX_VCPU_ID to 8 * KVM_MAX_VCPUS when HV KVM is
> configured in, so that a full complement of KVM_MAX_VCPUS VCPUs can
> be created on POWER9 in all guest SMT modes and emulated hardware
> SMT modes.
>=20
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
> This and the next patch apply on my kvm-ppc-next branch, which
> includes Sam Bobroff's patch "KVM: PPC: Book3S HV: Pack VCORE IDs to
> access full VCPU ID space".

Thanks!

I've tested kvm-ppc-next with all three above patches, and I'm able to
access the entire VCPU ID space (tested using CONFIG_NR_CPUS 1024 in the
host, rather than the default 2048, as that's the limit imposed by
QEMU). So:

Tested-by: Sam Bobroff <sbobroff@linux.ibm.com>

>=20
>  arch/powerpc/include/asm/kvm_host.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/a=
sm/kvm_host.h
> index 5b9e660..906bcbdf 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -42,7 +42,14 @@
>  #define KVM_USER_MEM_SLOTS	512
> =20
>  #include <asm/cputhreads.h>
> -#define KVM_MAX_VCPU_ID                (threads_per_subcore * KVM_MAX_VC=
ORES)
> +
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +#include <asm/kvm_book3s_asm.h>		/* for MAX_SMT_THREADS */
> +#define KVM_MAX_VCPU_ID		(MAX_SMT_THREADS * KVM_MAX_VCORES)
> +
> +#else
> +#define KVM_MAX_VCPU_ID		KVM_MAX_VCPUS
> +#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
> =20
>  #define __KVM_HAVE_ARCH_INTC_INITIALIZED
> =20
> --=20
> 2.7.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp=
-3A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3Djf_iaSHvJObTbx-si=
A1ZOg&r=3DFFlZoKpUuHop_w02rKHYxbjM9foF4tIm4FyKg8muba0&m=3DXJuK_j7qbnfsRxN3u=
HJ65CPxG7brNIut6LNuFyQYF8k&s=3D2zUtzqXA51owzthAuMl8kD0fWpLcjXBZswb_t6SYFSI&=
e=3D
>=20

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlteh+8ACgkQMX8w6AQl
/iKXuQf7BNPEJBJfdVX9kE5F4E+1PUdtIxxtE+hV1nR/u+Nyl/ydMk1QoPFzP7I2
D6klIAYsWMtxGAoISwReDDVt+Llm0G+J+8kH4qq8mm1k+YMdGqJ3C1bpYlaUlaCe
24kAhG5r5h2rW0GmRHZE2BsWqRoWKMvijAFbOm1SC2HH/Qs1vmkj28YqXwHJGH+H
qt4VUETQY8Q+nQkj4LDMFaHuuzlB2zZmXAJ1Q67bMkWRYhehqNKd+u9UFcGOoE2e
bmiuVZYINE7dd3KzlX9cuqhH/YJGPVmopMfCdtFRJXsknYhJWYZSp1DB7cVEQ8KV
b25+WxeZIbiRwxPWfLpnZqmrxnnPCg==
=rtuC
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
