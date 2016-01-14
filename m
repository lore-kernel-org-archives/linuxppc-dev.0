Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 64FF31A08F5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 11:02:15 +1100 (AEDT)
Date: Thu, 14 Jan 2016 11:02:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: gleb@kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 paulus@ozlabs.org, linuxppc-dev@ozlabs.org, pbonzini@redhat.com,
 mahesh@linux.vnet.ibm.com, kvm@vger.kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCH v3 1/2] KVM: PPC: New capability to control MCE behaviour
Message-ID: <20160114000239.GB22925@voom.redhat.com>
References: <20160113070759.20248.86252.stgit@aravindap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="iluUylAmeNVF81ZM"
In-Reply-To: <20160113070759.20248.86252.stgit@aravindap>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--iluUylAmeNVF81ZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 13, 2016 at 12:37:59PM +0530, Aravinda Prasad wrote:
> This patch introduces a new KVM capability to control
> how KVM behaves on machine check exception (MCE).
> Without this capability, KVM redirects machine check
> exceptions to guest's 0x200 vector if the address in
> error belongs to the guest. With this capability KVM
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
> QEMU part can be found at:
> http://lists.nongnu.org/archive/html/qemu-ppc/2015-12/msg00199.html
>=20
> Change Log v3:
>   - Split the patch into 2. First patch introduces the
>     new capability while the second one enhances KVM to
>     redirect MCE.
>   - Fix access width bug
>   - Rebased to v4.4-rc7
>=20
> Change Log v2:
>   - Added KVM capability
>=20
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/kvm_host.h |    1 +
>  arch/powerpc/kernel/asm-offsets.c   |    1 +
>  arch/powerpc/kvm/powerpc.c          |    7 +++++++
>  include/uapi/linux/kvm.h            |    1 +
>  4 files changed, 10 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/a=
sm/kvm_host.h
> index cfa758c..9ac2b84 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -243,6 +243,7 @@ struct kvm_arch {
>  	int hpt_cma_alloc;
>  	struct dentry *debugfs_dir;
>  	struct dentry *htab_dentry;
> +	u8 fwnmi_enabled;

Um.. I don't see anything in this patch or 2/2 which actually tests
this flag...

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
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 6fd2405..a8399b5 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -570,6 +570,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
>  		r =3D 1;
>  		break;
>  #endif
> +	case KVM_CAP_PPC_FWNMI:
> +		r =3D 1;
> +		break;
>  	default:
>  		r =3D 0;
>  		break;
> @@ -1132,6 +1135,10 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vc=
pu *vcpu,
>  		break;
>  	}
>  #endif /* CONFIG_KVM_XICS */
> +	case KVM_CAP_PPC_FWNMI:
> +		r =3D 0;
> +		vcpu->kvm->arch.fwnmi_enabled =3D true;
> +		break;
>  	default:
>  		r =3D -EINVAL;
>  		break;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 03f3618..d8a07b5 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -831,6 +831,7 @@ struct kvm_ppc_smmu_info {
>  #define KVM_CAP_GUEST_DEBUG_HW_WPS 120
>  #define KVM_CAP_SPLIT_IRQCHIP 121
>  #define KVM_CAP_IOEVENTFD_ANY_LENGTH 122
> +#define KVM_CAP_PPC_FWNMI 123
> =20
>  #ifdef KVM_CAP_IRQ_ROUTING
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iluUylAmeNVF81ZM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWluWfAAoJEGw4ysog2bOSHzAQAIhAWk7f+omZp5HVK8HKm8NW
MnxgiaNdZ8O2zMJ75Z5GmX7+n8Q/wnG/q9wi09EcfnV7WK25OsCuF+7svWTOKY3e
LgYk5pFxDAUVn/EXXXc+NuuXNZGgjZkn7Ckavq9Nq1I07NcGoApox7j3nJrslwVS
MBFY8UWNqamESdZm1Y051Nq0NgVTeqyJNqjVvlxOimswBswb8tZmzs3kUgiPNhjZ
YN/ugF/nLULApImhLYYVB8cNGXjNsS/JEywryOF7RBOtEjGy+XSLlFhIJ4u1vqS0
hEJgt7gbJGdD+c/04ANk7rbaNS98pEaONFTQeG1VVuby3T731KXVuQeZlsepbgKL
GzgA+FLk+/oSALSu/AUn3eZi3gDoYHs9AF+zoLz5x02w8kOtyynMoLNu4BDIEaOz
FCkACkjX7DWvRxH9wvUFVyECffL38lI1cBx5JX0IloCdao/eygM9HTycLsgV568G
2NNGzshx64hvs1ReDY505+cS4GKNOgW7y8NZhZPwB6TTifWEqb2H3rbTIo1Qi8XE
oDGJgIQXnFabLKbC4cJPNIq0AAtw96k9InVOFQy/rG2ajZtWgjDgT4n0DSEM+73M
E9gVfCrbph1Hye3TxDM+FoYBvO1+y82yzauGRyyEVyv43qtsWwz5ljNTF0tZ9gB9
uen0QV/N0gYlH3HGtuui
=yLgD
-----END PGP SIGNATURE-----

--iluUylAmeNVF81ZM--
