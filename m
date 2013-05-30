Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 558C42C007A
 for <linuxppc-dev@ozlabs.org>; Thu, 30 May 2013 10:07:18 +1000 (EST)
Date: Wed, 29 May 2013 19:07:13 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] KVM: PPC: Book3S: Add support for H_IPOLL and H_XIRR_X
 in XICS emulation
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1369870703.18630.49@snotra> <1369871852.3928.79.camel@pasglop>
In-Reply-To: <1369871852.3928.79.camel@pasglop> (from
 benh@kernel.crashing.org on Wed May 29 18:57:32 2013)
Message-ID: <1369872433.18630.50@snotra>
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

On 05/29/2013 06:57:32 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2013-05-29 at 18:38 -0500, Scott Wood wrote:
>=20
> > > Yes. I'd like to have them in. Their implementation is actually =20
> fairly
> > > trivial and they cannot be emulated by qemu if the rest of the =20
> XICS is
> > > in the kernel, so it's a problem.
> >
> > OK.  Does it make more sense for you to take it as Paul suggested, =20
> or
> > for Gleb or Marcelo to pick it up directly?
>=20
> I'll take it.

Acked-by: Scott Wood <scottwood@freescale.com>

> > Then rm_action should always be 0 for these hcalls, right?  So =20
> there's
> > no correctness reason to keep the hcalls in separate switch
> > statements.  You shave off a few cycles checking rm_action, at the =20
> cost
> > of needing to change kvmppc_xics_hcall() if a real-mode version of
> > these hcalls is ever done.
>=20
> No, because rm_action will also be 0 if the hcall was fully done in =20
> real
> mode (which can happen, that's our fast path), in which case we do =20
> *NOT*
> want to to be re-done in virtual mode.
>=20
> That's why we always return whether rm_action is 0 or not when =20
> real-mode
> is enabled.

Oh, I misread the code and thought the decision to return was based on =20
the return value of kvmppc_xics_rm_complete.  Sorry about that. :-(

-Scott=
