Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E17D1A106B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 13:32:04 +1100 (AEDT)
Date: Thu, 17 Dec 2015 13:32:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: paulus@ozlabs.org, linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org,
 mahesh@linux.vnet.ibm.com, michaele@au1.ibm.com, agraf@suse.de,
 kvm@vger.kernel.org
Subject: Re: [PATCH v2] KVM: PPC: Exit guest upon fatal machine check exception
Message-ID: <20151217023240.GF3011@voom.redhat.com>
References: <20151216055612.10203.28496.stgit@aravindap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5CUMAwwhRxlRszMD"
In-Reply-To: <20151216055612.10203.28496.stgit@aravindap>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--5CUMAwwhRxlRszMD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 16, 2015 at 11:26:12AM +0530, Aravinda Prasad wrote:
> This patch modifies KVM to cause a guest exit with
> KVM_EXIT_NMI instead of immediately delivering a 0x200
> interrupt to guest upon machine check exception in
> guest address. Exiting the guest enables QEMU to build
> error log and deliver machine check exception to guest
> OS (either via guest OS registered machine check
> handler or via 0x200 guest OS interrupt vector).
>=20
> This approach simplifies the delivering of machine
> check exception to guest OS compared to the earlier approach
> of KVM directly invoking 0x200 guest interrupt vector.
> In the earlier approach QEMU patched the 0x200 interrupt
> vector during boot. The patched code at 0x200 issued a
> private hcall to pass the control to QEMU to build the
> error log.
>=20
> This design/approach is based on the feedback for the
> QEMU patches to handle machine check exception. Details
> of earlier approach of handling machine check exception
> in QEMU and related discussions can be found at:
>=20
> https://lists.nongnu.org/archive/html/qemu-devel/2014-11/msg00813.html
>=20
> This patch also introduces a new KVM capability to
> control how KVM behaves on machine check exception.
> Without this capability, KVM redirects machine check
> exceptions to guest's 0x200 vector if the address in
> error belongs to guest. With this capability KVM
> causes a guest exit with NMI exit reason.
>=20
> This is required to avoid problems if a new kernel/KVM
> is used with an old QEMU for guests that don't issue
> "ibm,nmi-register". As old QEMU does not understand the
> NMI exit type, it treats it as a fatal error. However,
> the guest could have handled the machine check error
> if the exception was delivered to guest's 0x200 interrupt
> vector instead of NMI exit in case of old QEMU.
>=20
> Change Log v2:
>   - Added KVM capability
>=20
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/kvm_host.h     |    1 +
>  arch/powerpc/kernel/asm-offsets.c       |    1 +
>  arch/powerpc/kvm/book3s_hv.c            |   12 +++-------
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S |   37 +++++++++++++++----------=
------
>  arch/powerpc/kvm/powerpc.c              |    7 ++++++
>  include/uapi/linux/kvm.h                |    1 +
>  6 files changed, 31 insertions(+), 28 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/a=
sm/kvm_host.h
> index 827a38d..8a652ba 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -243,6 +243,7 @@ struct kvm_arch {
>  	int hpt_cma_alloc;
>  	struct dentry *debugfs_dir;
>  	struct dentry *htab_dentry;
> +	u8 fwnmi_enabled;
>  #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
>  #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
>  	struct mutex hpt_mutex;
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-=
offsets.c
> index 221d584..6a4e81a 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -506,6 +506,7 @@ int main(void)
>  	DEFINE(KVM_ENABLED_HCALLS, offsetof(struct kvm, arch.enabled_hcalls));
>  	DEFINE(KVM_LPCR, offsetof(struct kvm, arch.lpcr));
>  	DEFINE(KVM_VRMA_SLB_V, offsetof(struct kvm, arch.vrma_slb_v));
> +	DEFINE(KVM_FWNMI, offsetof(struct kvm, arch.fwnmi_enabled));
>  	DEFINE(VCPU_DSISR, offsetof(struct kvm_vcpu, arch.shregs.dsisr));
>  	DEFINE(VCPU_DAR, offsetof(struct kvm_vcpu, arch.shregs.dar));
>  	DEFINE(VCPU_VPA, offsetof(struct kvm_vcpu, arch.vpa.pinned_addr));
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 2280497..1b1dff0 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -859,15 +859,9 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run=
, struct kvm_vcpu *vcpu,
>  		r =3D RESUME_GUEST;
>  		break;
>  	case BOOK3S_INTERRUPT_MACHINE_CHECK:
> -		/*
> -		 * Deliver a machine check interrupt to the guest.
> -		 * We have to do this, even if the host has handled the
> -		 * machine check, because machine checks use SRR0/1 and
> -		 * the interrupt might have trashed guest state in them.
> -		 */
> -		kvmppc_book3s_queue_irqprio(vcpu,
> -					    BOOK3S_INTERRUPT_MACHINE_CHECK);
> -		r =3D RESUME_GUEST;
> +		/* Exit to guest with KVM_EXIT_NMI as exit reason */
> +		run->exit_reason =3D KVM_EXIT_NMI;
> +		r =3D RESUME_HOST;
>  		break;
>  	case BOOK3S_INTERRUPT_PROGRAM:
>  	{
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/b=
ook3s_hv_rmhandlers.S
> index b98889e..f43c124 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -147,7 +147,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>  	addi	r1, r1, 112
>  	ld	r7, HSTATE_HOST_MSR(r13)
>

Seems like the comment a little above this should be updated to
reflect the fact that this path no longer handles machine checks.

Apart from that and the access width bug Thomas spotted, it looks ok
to me,.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5CUMAwwhRxlRszMD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWch7IAAoJEGw4ysog2bOSWEUQAL/3IMP3LAxQlGK/MMDXGohV
vrD2hu/1wTttAVRg9C3aaky6B8hx8SXj99gRsgqb849Q1rmkZzUpo3eImi4eImhX
oSR4y+vTO1mOxHv6HNdM6QMLz/gsdRsRvJnV7SikvbMk+2kjHsfEfmvfIqYHwlnM
GCkiu1Z99CTsIfhTsn3Ln0sD0zxWSLv+vLGQvo0zJ4z/sqeRe11+PKZrTNjKbAmh
cEnTyhki8zuOlWqW9zJ6qxLV8oSwI+kAjM+cdO5zpByn7Hs9r3odSmXP0NwcFNn4
+3pO+bghSNbWdqZU0xhVdA/li/p4WYzukvLQ4luSMGlbtedTXFZ5Cvba0pduTZ2m
ud+1BqLeuUva3BsZQ0Nlb9szPEk/SpRLySVWqLCyHszGEFZ09fayIAd267agkzMV
zfRXKxPqy+tiQTYgZOcn93bk+0cjP+RISn+Kj/uLUDIDtLLXExDIiF41wh4ERkyv
+RlXtgZoDoSpSH4xMtL0tT0aUsOI2OdwRU6JQBiJCAZb78vD9KMjheKKHFpCJulk
iCUTlj1jj1Y0UixwFF6Ai/lTORQSUtZX7SsyHhFpP5V9G69V5R3gegBduhx+m9GJ
KT8BXLilfYKpt6CnoZOhsXuyaKgja2SmeuWK+Yz3hro7RTwxnQoIz6SOQPVvH4h1
/FAIZ3uFSykxEJuNeCjT
=LL/U
-----END PGP SIGNATURE-----

--5CUMAwwhRxlRszMD--
