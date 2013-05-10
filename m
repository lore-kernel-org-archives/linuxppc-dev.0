Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C2ACB2C00CF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 May 2013 04:17:25 +1000 (EST)
Date: Fri, 10 May 2013 13:17:08 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [v2][KVM][PATCH 1/1] kvm:ppc: enable doorbell exception with
 CONFIG_PPC_DOORBELL
To: Alexander Graf <agraf@suse.de>
References: <1367922232-22455-1-git-send-email-tiejun.chen@windriver.com>
 <39FBAAD3-4B13-4CA3-9E80-B73A266C1D3A@suse.de>
In-Reply-To: <39FBAAD3-4B13-4CA3-9E80-B73A266C1D3A@suse.de> (from
 agraf@suse.de on Fri May 10 13:14:27 2013)
Message-ID: <1368209828.19683.5@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Tiejun Chen <tiejun.chen@windriver.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/10/2013 01:14:27 PM, Alexander Graf wrote:
>=20
> On 07.05.2013, at 12:23, Tiejun Chen wrote:
>=20
> > CONFIG_PPC_DOORBELL is enough to cover all variants.
> >
> > Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> > ---
> > arch/powerpc/kvm/booke.c |    2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> > index 1020119..62d4ece 100644
> > --- a/arch/powerpc/kvm/booke.c
> > +++ b/arch/powerpc/kvm/booke.c
> > @@ -795,7 +795,7 @@ static void kvmppc_restart_interrupt(struct =20
> kvm_vcpu *vcpu,
> > 		kvmppc_fill_pt_regs(&regs);
> > 		timer_interrupt(&regs);
> > 		break;
> > -#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_BOOK3E_64)
> > +#if defined(CONFIG_PPC_DOORBELL)
>=20
> The same question still holds. How is this an improvement over the =20
> previous code? Does this fix any issues for you? Is this just a =20
> coding style cleanup?

This is an improvement because CONFIG_PPC_DOORBELL is what controls =20
whether the function that is called inside the ifdef exists.

-Scott=
