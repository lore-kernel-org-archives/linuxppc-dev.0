Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8EFD82C0084
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 03:13:51 +1000 (EST)
Date: Tue, 9 Jul 2013 12:13:38 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Get vcpu's last instruction for
 emulation
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <3079C0F5-E13B-4572-8C9D-BCE558AF64D8@suse.de> (from
 agraf@suse.de on Mon Jul  8 08:39:05 2013)
Message-ID: <1373390018.8183.194@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/08/2013 08:39:05 AM, Alexander Graf wrote:
>=20
> On 28.06.2013, at 11:20, Mihai Caraman wrote:
>=20
> > lwepx faults needs to be handled by KVM and this implies additional =20
> code
> > in DO_KVM macro to identify the source of the exception originated =20
> from
> > host context. This requires to check the Exception Syndrome Register
> > (ESR[EPID]) and External PID Load Context Register (EPLC[EGS]) for =20
> DTB_MISS,
> > DSI and LRAT exceptions which is too intrusive for the host.
> >
> > Get rid of lwepx and acquire last instuction in =20
> kvmppc_handle_exit() by
> > searching for the physical address and kmap it. This fixes an =20
> infinite loop
>=20
> What's the difference in speed for this?
>=20
> Also, could we call lwepx later in host code, when =20
> kvmppc_get_last_inst() gets invoked?

Any use of lwepx is problematic unless we want to add overhead to the =20
main Linux TLB miss handler.

> > +		return;
> > +	}
> > +
> > +	mas3 =3D mfspr(SPRN_MAS3);
> > +	pr =3D vcpu->arch.shared->msr & MSR_PR;
> > +	if ((pr && (!(mas3 & MAS3_UX))) || ((!pr) && (!(mas3 & =20
> MAS3_SX)))) {
> > +	 	/*
> > +		 * Another thread may rewrite the TLB entry in =20
> parallel, don't
> > +		 * execute from the address if the execute permission =20
> is not set
>=20
> Isn't this racy?

Yes, that's the point.  We want to access permissions atomically with =20
the address.  If the guest races here, the unpredictable behavior is =20
its own fault, but we don't want to make it worse by assuming that the =20
new TLB entry is executable just because the old TLB entry was.

There's still a potential problem if the instruction at the new TLB =20
entry is valid but not something that KVM emulates (because it wouldn't =20
have trapped).  Given that the guest is already engaging in =20
unpredictable behavior, though, and that it's no longer a security =20
issue (it'll just cause the guest to exit), I don't think we need to =20
worry too much about it.

> > +		 */
> > +		vcpu->arch.fault_esr =3D 0;
> > +		*exit_nr =3D BOOKE_INTERRUPT_INST_STORAGE;
> > +		return;
> > +	}
> > +
> > +	/* Get page size */
> > +	if (MAS0_GET_TLBSEL(mfspr(SPRN_MAS0)) =3D=3D 0)
> > +		psize_shift =3D PAGE_SHIFT;
> > +	else
> > +		psize_shift =3D MAS1_GET_TSIZE(mas1) + 10;
> > +
> > +	mas7_mas3 =3D (((u64) mfspr(SPRN_MAS7)) << 32) |
> > +		    mfspr(SPRN_MAS3);
>=20
> You're non-atomically reading MAS3/MAS7 after you've checked for =20
> permissions on MAS3. I'm surprised there's no handler that allows =20
> MAS3/7 access through the new, combined SPR for 64bit systems.

There is, but then we'd need to special-case 64-bit systems.  Why does =20
atomicity matter here?  The MAS registers were filled in when we did =20
the tlbsx.  They are thread-local.  They don't magically change just =20
because the other thread rewrites the TLB entry that was used to fill =20
them.

> > +	addr =3D (mas7_mas3 & (~0ULL << psize_shift)) |
> > +	       (geaddr & ((1ULL << psize_shift) - 1ULL));
> > +
> > +	/* Map a page and get guest's instruction */
> > +	page =3D pfn_to_page(addr >> PAGE_SHIFT);
>=20
> So it seems to me like you're jumping through a lot of hoops to make =20
> sure this works for LRAT and non-LRAT at the same time. Can't we just =20
> treat them as the different things they are?
>=20
> What if we have different MMU backends for LRAT and non-LRAT? The =20
> non-LRAT case could then try lwepx, if that fails, fall back to read =20
> the shadow TLB. For the LRAT case, we'd do lwepx, if that fails fall =20
> back to this logic.

This isn't about LRAT; it's about hardware threads.  It also fixes the =20
handling of execute-only pages on current chips.

-Scott=
