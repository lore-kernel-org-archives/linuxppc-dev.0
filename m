Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ABC602C009A
 for <linuxppc-dev@ozlabs.org>; Thu, 30 May 2013 09:38:34 +1000 (EST)
Date: Wed, 29 May 2013 18:38:23 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] KVM: PPC: Book3S: Add support for H_IPOLL and H_XIRR_X
 in XICS emulation
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1369788078.3928.28.camel@pasglop> (from
 benh@kernel.crashing.org on Tue May 28 19:41:18 2013)
Message-ID: <1369870703.18630.49@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/28/2013 07:41:18 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2013-05-28 at 12:41 -0500, Scott Wood wrote:
>=20
> > I believe Alex is staying far away from e-mail on his vacation.  =20
> He's
> > asked me to fill in for him while he's gone.
> >
> > The patch itself seems reasonable (though I don't know much about =20
> XICS,
> > and do have one question...), but I'll leave it up to =20
> Gleb/Marcelo/Ben
> > if it should go in for 3.10 and via which tree.  I understand the
> > desire to not have an incomplete ABI in a released version, but =20
> Linus
> > is already grumbling about how much went into rc3, and you say the
> > hcalls aren't currently used...  Are they likely to be used in any
> > timeframe in which we'd reasonably care about 3.10?
>=20
> Yes. I'd like to have them in. Their implementation is actually fairly
> trivial and they cannot be emulated by qemu if the rest of the XICS is
> in the kernel, so it's a problem.

OK.  Does it make more sense for you to take it as Paul suggested, or =20
for Gleb or Marcelo to pick it up directly?

> > > +	/* These requests don't have real-mode implementations at
> > > present */
> > > +	switch (req) {
> > > +	case H_XIRR_X:
> > > +		res =3D kvmppc_h_xirr(vcpu);
> > > +		kvmppc_set_gpr(vcpu, 4, res);
> > > +		kvmppc_set_gpr(vcpu, 5, get_tb());
> > > +		return rc;
> > > +	case H_IPOLL:
> > > +		rc =3D kvmppc_h_ipoll(vcpu, kvmppc_get_gpr(vcpu, 4));
> > > +		return rc;
> > > +	}
> > > +
> > >  	/* Check for real mode returning too hard */
> > >  	if (xics->real_mode)
> > >  		return kvmppc_xics_rm_complete(vcpu, req);
> >
> > Could you explain what's going on here relative to
> > kvmppc_xics_rm_complete()?  What does "returning too hard" mean, and
> > why must rm_action not be checked for these hcalls?
>=20
> This is related to how we handle some hcalls in real mode as a fast
> path. The real-mode stuff cannot handle cases that require for =20
> example a
> re-emit of the interrupt, a reject, etc... so in some cases, it =20
> returns
> H_TOO_HARD which causes KVM to exit and try to handle the hcall again =20
> in
> kernel virtual mode.
>=20
> When doing so as the result of a XICS hcall, it sets a bit mask of
> "tasks" to handle in virtual mode (because it will have already
> partially done the operation, it cannot just re-play the whole hcall).
>=20
> So when real-mode is supported we must not just call the normal =20
> virtual
> mode version of the hcalls, we instead go to kvmppc_xics_rm_complete()
> to handle those "tasks".
>=20
> However, for those 2 "missing" hcalls, we have no real mode
> implementation at all (we didn't bother, we will do that later if
> needed, it's purely a performance issue). So we need to fully handle
> them in virtual mode, and we know there will be no "tasks" to handle =20
> in
> rm_complete.

Then rm_action should always be 0 for these hcalls, right?  So there's =20
no correctness reason to keep the hcalls in separate switch =20
statements.  You shave off a few cycles checking rm_action, at the cost =20
of needing to change kvmppc_xics_hcall() if a real-mode version of =20
these hcalls is ever done.

-Scott=
