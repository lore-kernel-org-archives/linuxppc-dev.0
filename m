Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ynNzV0sx5zDr4p
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 15:03:02 +1100 (AEDT)
Date: Thu, 30 Nov 2017 14:51:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Serhii Popovych <spopovyc@redhat.com>
Cc: linux-kernel@vger.kernel.org, michael@ellerman.id.au, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 3/4] KVM: PPC: Book3S HV: Fix use after free in case of
 multiple resize requests
Message-ID: <20171130035112.GQ3023@umbus.fritz.box>
References: <1511973506-65683-1-git-send-email-spopovyc@redhat.com>
 <1511973506-65683-4-git-send-email-spopovyc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="s3R87C3fwYeCSZ0b"
In-Reply-To: <1511973506-65683-4-git-send-email-spopovyc@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--s3R87C3fwYeCSZ0b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 11:38:25AM -0500, Serhii Popovych wrote:
> When serving multiple resize requests following could happen:
>=20
>     CPU0                                    CPU1
>     ----                                    ----
>     kvm_vm_ioctl_resize_hpt_prepare(1);
>       -> schedule_work()
>                                             /* system_rq might be busy: d=
elay */
>     kvm_vm_ioctl_resize_hpt_prepare(2);
>       mutex_lock();
>       if (resize) {
>          ...
>          release_hpt_resize();
>       }
>       ...                                   resize_hpt_prepare_work()
>       -> schedule_work()                    {
>       mutex_unlock()                           /* resize->kvm could be wr=
ong */
>                                                struct kvm *kvm =3D resize=
->kvm;
>=20
>                                                mutex_lock(&kvm->lock);   =
<<<< UAF
>                                                ...
>                                             }
>=20
> Since scheduled work could be delayed (e.g. when system is busy) we
> another resize request with different order could be promoted by
> kvm_vm_ioctl_resize_hpt_prepare() and previous request could be
> freed right before resize_hpt_prepare_work() begins execution or
> right under mutex_lock() when it is executed in parallel with ioctl.
>=20
> In both cases we get use after free in point marked with UAF on the
> diagram above.
>=20
> To prevent this from happening we must not release previous request
> immediately in ioctl instead postponing this to resize_hpt_prepare_work().
>=20
> Make resize_hpt_release() generic: we use it in more cases.
>=20
> This fixes following or similar host kernel crash message:
>=20
> [  635.277361] Unable to handle kernel paging request for data at address=
 0x00000000
> [  635.277438] Faulting instruction address: 0xc00000000052f568
> [  635.277446] Oops: Kernel access of bad area, sig: 11 [#1]
> [  635.277451] SMP NR_CPUS=3D2048 NUMA PowerNV
> [  635.277470] Modules linked in: xt_CHECKSUM iptable_mangle ipt_MASQUERA=
DE
> nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4
> nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 tun br=
idge stp llc
> ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter nfsv3 n=
fs_acl nfs
> lockd grace fscache kvm_hv kvm rpcrdma sunrpc ib_isert iscsi_target_mod i=
b_iser libiscsi
> scsi_transport_iscsi ib_srpt target_core_mod ext4 ib_srp scsi_transport_s=
rp
> ib_ipoib mbcache jbd2 rdma_ucm ib_ucm ib_uverbs ib_umad rdma_cm ib_cm iw_=
cm ocrdma(T)
> ib_core ses enclosure scsi_transport_sas sg shpchp leds_powernv ibmpowern=
v i2c_opal
> i2c_core powernv_rng ipmi_powernv ipmi_devintf ipmi_msghandler ip_tables =
xfs
> libcrc32c sr_mod sd_mod cdrom lpfc nvme_fc(T) nvme_fabrics nvme_core ipr =
nvmet_fc(T)
> tg3 nvmet libata be2net crc_t10dif crct10dif_generic scsi_transport_fc pt=
p scsi_tgt
> pps_core crct10dif_common dm_mirror dm_region_hash dm_log dm_mod
> [  635.278687] CPU: 40 PID: 749 Comm: kworker/40:1 Tainted: G
> ------------ T 3.10.0.bz1510771+ #1
> [  635.278782] Workqueue: events resize_hpt_prepare_work [kvm_hv]
> [  635.278851] task: c0000007e6840000 ti: c0000007e9180000 task.ti: c0000=
007e9180000
> [  635.278919] NIP: c00000000052f568 LR: c0000000009ea310 CTR: c000000000=
9ea4f0
> [  635.278988] REGS: c0000007e91837f0 TRAP: 0300   Tainted: G
> ------------ T  (3.10.0.bz1510771+)
> [  635.279077] MSR: 9000000100009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 24002=
022  XER:
> 00000000
> [  635.279248] CFAR: c000000000009368 DAR: 0000000000000000 DSISR: 400000=
00 SOFTE: 1
> GPR00: c0000000009ea310 c0000007e9183a70 c000000001250b00 c0000007e9183b10
> GPR04: 0000000000000000 0000000000000000 c0000007e9183650 0000000000000000
> GPR08: c0000007ffff7b80 00000000ffffffff 0000000080000028 d00000000d2529a0
> GPR12: 0000000000002200 c000000007b56800 c000000000120028 c0000007f135bb40
> GPR16: 0000000000000000 c000000005c1e018 c000000005c1e018 0000000000000000
> GPR20: 0000000000000001 c0000000011bf778 0000000000000001 fffffffffffffef7
> GPR24: 0000000000000000 c000000f1e262e50 0000000000000002 c0000007e9180000
> GPR28: c000000f1e262e4c c000000f1e262e50 0000000000000000 c0000007e9183b10
> [  635.280149] NIP [c00000000052f568] __list_add+0x38/0x110
> [  635.280197] LR [c0000000009ea310] __mutex_lock_slowpath+0xe0/0x2c0
> [  635.280253] Call Trace:
> [  635.280277] [c0000007e9183af0] [c0000000009ea310] __mutex_lock_slowpat=
h+0xe0/0x2c0
> [  635.280356] [c0000007e9183b70] [c0000000009ea554] mutex_lock+0x64/0x70
> [  635.280426] [c0000007e9183ba0] [d00000000d24da04]
> resize_hpt_prepare_work+0xe4/0x1c0 [kvm_hv]
> [  635.280507] [c0000007e9183c40] [c000000000113c0c] process_one_work+0x1=
dc/0x680
> [  635.280587] [c0000007e9183ce0] [c000000000114250] worker_thread+0x1a0/=
0x520
> [  635.280655] [c0000007e9183d80] [c00000000012010c] kthread+0xec/0x100
> [  635.280724] [c0000007e9183e30] [c00000000000a4b8] ret_from_kernel_thre=
ad+0x5c/0xa4
> [  635.280814] Instruction dump:
> [  635.280880] 7c0802a6 fba1ffe8 fbc1fff0 7cbd2b78 fbe1fff8 7c9e2378 7c7f=
1b78
> f8010010
> [  635.281099] f821ff81 e8a50008 7fa52040 40de00b8 <e8be0000> 7fbd2840 40=
de008c
> 7fbff040
> [  635.281324] ---[ end trace b628b73449719b9d ]---
>=20
> Signed-off-by: Serhii Popovych <spopovyc@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kvm/book3s_64_mmu_hv.c | 45 ++++++++++++++++++++++++++-----=
------
>  1 file changed, 32 insertions(+), 13 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3=
s_64_mmu_hv.c
> index 3e9abd9..690f061 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -1417,15 +1417,18 @@ static void resize_hpt_pivot(struct kvm_resize_hp=
t *resize)
> =20
>  static void resize_hpt_release(struct kvm *kvm, struct kvm_resize_hpt *r=
esize)
>  {
> -	BUG_ON(kvm->arch.resize_hpt !=3D resize);
> +	BUG_ON(!mutex_is_locked(&kvm->lock));
> =20
>  	if (!resize)
>  		return;
> =20
> -	kvmppc_free_hpt(&resize->hpt);
> +	if (resize->error !=3D -EBUSY) {
> +		kvmppc_free_hpt(&resize->hpt);
> +		kfree(resize);
> +	}
> =20
> -	kvm->arch.resize_hpt =3D NULL;
> -	kfree(resize);
> +	if (kvm->arch.resize_hpt =3D=3D resize)
> +		kvm->arch.resize_hpt =3D NULL;
>  }
> =20
>  static void resize_hpt_prepare_work(struct work_struct *work)
> @@ -1434,24 +1437,40 @@ static void resize_hpt_prepare_work(struct work_s=
truct *work)
>  						     struct kvm_resize_hpt,
>  						     work);
>  	struct kvm *kvm =3D resize->kvm;
> -	int err;
> +	int err =3D 0;
> =20
>  	BUG_ON(resize->error !=3D -EBUSY);
> =20
> -	resize_hpt_debug(resize, "resize_hpt_prepare_work(): order =3D %d\n",
> -			 resize->order);
> +	mutex_lock(&kvm->lock);
> +
> +	/* Request is still current? */
> +	if (kvm->arch.resize_hpt =3D=3D resize) {
> +		/* We may request large allocations here:
> +		 * do not sleep with kvm->lock held for a while.
> +		 */
> +		mutex_unlock(&kvm->lock);
> =20
> -	err =3D resize_hpt_allocate(resize);
> +		resize_hpt_debug(resize, "resize_hpt_prepare_work(): order =3D %d\n",
> +				 resize->order);
> =20
> -	/* We have strict assumption about -EBUSY
> -	 * when preparing for HPT resize.
> -	 */
> -	BUG_ON(err =3D=3D -EBUSY);
> +		err =3D resize_hpt_allocate(resize);
> =20
> -	mutex_lock(&kvm->lock);
> +		/* We have strict assumption about -EBUSY
> +		 * when preparing for HPT resize.
> +		 */
> +		BUG_ON(err =3D=3D -EBUSY);
> +
> +		mutex_lock(&kvm->lock);
> +		/* It is possible that kvm->arch.resize_hpt !=3D resize
> +		 * after we grab kvm->lock again.
> +		 */
> +	}
> =20
>  	resize->error =3D err;
> =20
> +	if (kvm->arch.resize_hpt !=3D resize)
> +		resize_hpt_release(kvm, resize);
> +
>  	mutex_unlock(&kvm->lock);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--s3R87C3fwYeCSZ0b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlofgDAACgkQbDjKyiDZ
s5KAiQ/+JHmgyQfKH3ullnn4r+QI+3mb6SlQhVrQPzyuxxOfuUOm/e7eZGt3U5Yq
OLEsQfCXJWDpyh1aUQzzYxN1BvToKPBlUbSzeDHE6cS32ggo14QLcGkycwkLUmml
zwDZpka67V1dq8Hbuxb3spVsZpBerPbwYzVpFKX3GbUiZ6sxbXoUdyu1FzRxokzF
gu4Dbzd8Ud0aD6AeqI3bntqPSZudj1I+dCl7NMZYqHgKmqYWwNqQSmYHiObSCcAe
eqhhJoG+XVaalap2/93PT+D59bHUPnbu2X0qR3u1C77QMIl8zh94dJJN614Ffg8W
CXQszRKIt/VRUeJCm5bEFnD0fq2DTNhmvOre48I3Ouhb6uiNHQauuUjGVQ5uvxhS
joAlpE8h8pVs4fjttM6wOoIyzMtcdWl/n5l87YBMSbrmON9VF8JvR8NcnzmKsjxp
IA0t7ugpXuLq8d2M5uKyqwr5EnlTabGse6ZcDTvub67LrixloJ5ivQ8hTY642/EY
XgGMJnm32UnTjtPUromkWILGAMnOxbbMc5mlVI9QmqWL3yBBxiQXJ+omeFL4cfCt
UHU0Wbd3ripeB4/WNdZUN489K4wIIMXt4BS5l1vJNLkItVbtgzWK4iY2tLDjzMSz
EmvF4hqbn3BU5kwrmA/CT7dK9SfFJ518d3c/H6hPxHrKn0Zdq3s=
=/ONj
-----END PGP SIGNATURE-----

--s3R87C3fwYeCSZ0b--
