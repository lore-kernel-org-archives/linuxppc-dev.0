Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5qdM4KDwzDqhh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 17:59:03 +1100 (AEDT)
Date: Tue, 3 Oct 2017 17:58:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 nikunj@linux.vnet.ibm.com
Subject: Re: [PATCH 0/2] powerpc/xive: fix CPU hot unplug
Message-ID: <20171003065858.GL3260@umbus.fritz.box>
References: <20170923082656.27219-1-clg@kaod.org>
 <378a1945-6263-dca7-3912-b4a2c61794b8@kaod.org>
 <20171003033615.GA3260@umbus.fritz.box>
 <7f2081f1-415a-85ca-29ed-3ab1467220a7@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GeDkoc8jIzHasOdk"
In-Reply-To: <7f2081f1-415a-85ca-29ed-3ab1467220a7@kaod.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--GeDkoc8jIzHasOdk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2017 at 08:24:07AM +0200, C=E9dric Le Goater wrote:
> On 10/03/2017 05:36 AM, David Gibson wrote:
> > On Mon, Oct 02, 2017 at 06:27:20PM +0200, C=E9dric Le Goater wrote:
> >> On 09/23/2017 10:26 AM, C=E9dric Le Goater wrote:
> >>> Hi,
> >>>
> >>> Here are a couple of small fixes to support CPU hot unplug. There are
> >>> still some issues to be investigated as, in some occasions, after a
> >>> couple of plug and unplug, the cpu which was removed receives a 'lost'
> >>> interrupt. This showed to be the decrementer under QEMU.
> >>
> >> So this seems to be a QEMU issue only which can be solved by=20
> >> removing the DEE bit from the LPCR on P9 processor when the CPU=20
> >> is stopped in rtas. PECE3 bit on P8 processors.=20
> >>
> >> I think these patches are valuable fixes for 4.14. The first=20
> >> is trivial and the second touches the common xive part but it
> >> is only called on the pseries platform. =20
> >>
> >> Could you please take a look ?
> >=20
> > Sorry, I think I've missed something here.
> >=20
> > Is there a qemu bug involved in this?  Has there been a patch sent
> > that I didn't spot?
>=20
>=20
> No, not yet, but I will today probably. something like below to stop
> the decrementer when a CPU is stopped:
>=20
> 	--- qemu.git.orig/hw/ppc/spapr_rtas.c
> 	+++ qemu.git/hw/ppc/spapr_rtas.c
> 	@@ -174,6 +174,15 @@ static void rtas_start_cpu(PowerPCCPU *c
> 	         kvm_cpu_synchronize_state(cs);
> 	=20
> 	         env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
> 	+
> 	+        /* Enable DECR interrupt */
> 	+        if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
> 	+            env->spr[SPR_LPCR] |=3D LPCR_DEE;
> 	+        } else {
> 	+            /* P7 and P8 both have same bit for DECR */
> 	+            env->spr[SPR_LPCR] |=3D LPCR_P8_PECE3;
> 	+        }
> 	+
> 	         env->nip =3D start;
> 	         env->gpr[3] =3D r3;
> 	         cs->halted =3D 0;
> 	@@ -210,6 +219,13 @@ static void rtas_stop_self(PowerPCCPU *c
> 	      * no need to bother with specific bits, we just clear it.
> 	      */
> 	     env->msr =3D 0;
> 	+
> 	+    if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
> 	+        env->spr[SPR_LPCR] &=3D ~LPCR_DEE;
> 	+    } else {
> 	+        /* P7 and P8 both have same bit for DECR */
> 	+        env->spr[SPR_LPCR] &=3D ~LPCR_P8_PECE3;
> 	+    }
> 	 }
> 	=20
> 	 static inline int sysparm_st(target_ulong addr, target_ulong len,
> =09
> I haven't yet because I fail to understand why the decrementer is not=20
> interrupting the dying CPU under xics as it is the case under XIVE.

Oh.. ok.  This sounds very similar to the problem Nikunj hit under TCG
with decrementer interrupts waking up a supposedly dead CPU.  He had a
couple of proposed fixes, but we got bogged down trying to work out
why  (with TCG at least) it only seemed to bite after a system_reset,
and not on initial boot up.

> Also I am not sure this hack is of any use :
>=20
>     /*
>      * While stopping a CPU, the guest calls H_CPPR which
>      * effectively disables interrupts on XICS level.
>      * However decrementer interrupts in TCG can still
>      * wake the CPU up so here we disable interrupts in MSR
>      * as well.
>      * As rtas_start_cpu() resets the whole MSR anyway, there is
>      * no need to bother with specific bits, we just clear it.
>      */
>     env->msr =3D 0;

Ok.. why do you think this isn't of use?  I'm pretty sure this is
necessary for the TCG case, since MSR is checked in cpu_has_work(),
which could otherwise wake up the "dead" cpu.

> and the different CPU states are confusing. Nikunj already to a look
> at this when trying to fix the TCG reboot. Anyway, the QEMU patch=20
> should (re)start a thread. This is not the place to discuss.
>=20
> Thanks,
>=20
> C. =20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GeDkoc8jIzHasOdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnTNTIACgkQbDjKyiDZ
s5Ju7BAA3uv93UaXIOzHo8eIWE1YLEKYAt9yU9URYqOHEBZ02roZSwyVuGfc4RVf
aH+eOwc1mA6H9aitJEyqIi+dmNbneD/+xYhMIYa/X9JItlZSQZc9ujJTZp2E+PL7
jN/FYaadlEXN6c5daVmVMHheCgHHWXx5qgv9+v0wrCnEOOnAHWffl6ABs+XCr9/h
aG2HTSC7Rb8gLlyQqn1hk0Y4ise0LT+eCmrHWg718wk/d32C8mG0K1UkbNUVgl1g
Wc0BYzOnlidBH5Qp9I0Em3upWfbrdVu1rrtcTtKHO24bojmMH4heJBLrHHZwsFqI
44X+FHPGGT+oFEcmuJTrQ6k+qPSiw4FqDMJIfTU9PeIGZZQNg15c6b/lbu+0gk6m
uOqNzGSALYGQvZFGnU/zKcsOvYDCD5ZCPMRwldt7hwizsvh5XUQm7BlchO/bi2/M
j0FA4cG1TgxVvwqSKCiwFM2tRlIVRyLTrGyIMft9Orkl9FACjeunfzhL44BwNMAf
jceJ7FenJnhxPGS+hp7oRzERT8Q2Z2G6xBzfBqkKJc7060orTUoOtpRrezDZifG+
TZa6uOZMbyWANKlmGVFdAIrseWZcZWs11xY6TNEaOnWpcyc0Z0uj8tWX/+fhXW1F
JX+Uyf0CH9x/TYBhx1UKTLbkC3G29cAb3QzVlM1cloqZ223bsK0=
=thqZ
-----END PGP SIGNATURE-----

--GeDkoc8jIzHasOdk--
