Return-Path: <B02008@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F8902C008E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2013 01:56:58 +1100 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [PATCH 1/5] KVM: PPC: e500: Move VCPU's MMUCFG register
 initialization earlier
Date: Thu, 31 Jan 2013 14:56:44 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF2F7733@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1359552584-17861-1-git-send-email-mihai.caraman@freescale.com>
 <1359552584-17861-2-git-send-email-mihai.caraman@freescale.com>
 <FE5499BE-EC13-47EA-806C-345F7135B677@suse.de>
In-Reply-To: <FE5499BE-EC13-47EA-806C-345F7135B677@suse.de>
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
> Sent: Thursday, January 31, 2013 3:21 PM
> To: Caraman Mihai Claudiu-B02008
> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [PATCH 1/5] KVM: PPC: e500: Move VCPU's MMUCFG register
> initialization earlier
>=20
>=20
> On 30.01.2013, at 14:29, Mihai Caraman wrote:
>=20
> > VCPU's MMUCFG register initialization should not depend on
> KVM_CAP_SW_TLB
> > ioctl call. Move it earlier into tlb initalization phase.
>=20
> Quite the contrary. The fact that there is an mfspr() in e500_mmu.c
> already tells us that the code is broken. The TLB guest code should only
> depend on input from the SW_TLB configuration. It's completely orthogonal
> to the host capabilities.

Then we have the same issue for TLBnCFG registers which need to be configur=
ed
via SW_TLB ioctl. What is the purpose of guest tlb initalization in e500_mm=
u.c
if we rely on SW_TLB?

-Mike
