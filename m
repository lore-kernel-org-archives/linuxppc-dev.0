Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0207.outbound.protection.outlook.com [207.46.163.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DBA6C1A0405
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jun 2014 00:43:31 +1000 (EST)
From: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>
To: Alexander Graf <agraf@suse.de>, Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH] KVM: PPC: e500mc: Relax tlb invalidation condition on
 vcpu schedule
Date: Fri, 13 Jun 2014 14:43:21 +0000
Message-ID: <306b1e4daa2f4441aaef7c7383b484fc@BY2PR03MB508.namprd03.prod.outlook.com>
References: <1402581610-16585-1-git-send-email-mihai.caraman@freescale.com>
 <5399DDA8.5060404@suse.de>
In-Reply-To: <5399DDA8.5060404@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Alexander Graf [mailto:agraf@suse.de]
> Sent: Thursday, June 12, 2014 8:05 PM
> To: Caraman Mihai Claudiu-B02008
> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; Wood Scott-B07421
> Subject: Re: [PATCH] KVM: PPC: e500mc: Relax tlb invalidation condition
> on vcpu schedule
>=20
> On 06/12/2014 04:00 PM, Mihai Caraman wrote:
> > On vcpu schedule, the condition checked for tlb pollution is too tight.
> > The tlb entries of one vcpu are polluted when a different vcpu from the
> > same partition runs in-between. Relax the current tlb invalidation
> > condition taking into account the lpid.
> >
> > Signed-off-by: Mihai Caraman <mihai.caraman <at> freescale.com>
>=20
> Your mailer is broken? :)
> This really should be an @.
>=20
> I think this should work. Scott, please ack.

Alex, you were right. I screwed up the patch description by inverting relax
and tight terms :) It should have been more like this:

KVM: PPC: e500mc: Enhance tlb invalidation condition on vcpu schedule

On vcpu schedule, the condition checked for tlb pollution is too loose.
The tlb entries of a vcpu are polluted (vs stale) only when a different vcp=
u
within the same logical partition runs in-between. Optimize the tlb invalid=
ation
condition taking into account the lpid.

-Mike
