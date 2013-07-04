Return-Path: <B02008@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 99F132C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 16:34:58 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 1/2] powerpc/booke64: Add LRAT error exception handler
Date: Thu, 4 Jul 2013 06:34:48 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF0A2A4A4F@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1372870566-11299-1-git-send-email-mihai.caraman@freescale.com>
 <1372882692.8183.150@snotra>
In-Reply-To: <1372882692.8183.150@snotra>
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
> From: Wood Scott-B07421
> Sent: Wednesday, July 03, 2013 11:18 PM
> To: Caraman Mihai Claudiu-B02008
> Cc: linuxppc-dev@lists.ozlabs.org; kvm-ppc@vger.kernel.org;
> kvm@vger.kernel.org; Caraman Mihai Claudiu-B02008
> Subject: Re: [PATCH 1/2] powerpc/booke64: Add LRAT error exception
> handler
>=20
> On 07/03/2013 11:56:05 AM, Mihai Caraman wrote:
> > @@ -1410,6 +1423,7 @@ _GLOBAL(setup_doorbell_ivors)
> >  _GLOBAL(setup_ehv_ivors)
> >  	SET_IVOR(40, 0x300) /* Embedded Hypervisor System Call */
> >  	SET_IVOR(41, 0x320) /* Embedded Hypervisor Privilege */
> > +	SET_IVOR(42, 0x340) /* LRAT Error */
>=20
> What happens if we write to IVOR42 on e5500?  If the answer is no-op,
> is that behavior guaranteed on any CPU with E.HV but not LRAT?

Oops. I would rather do it __setup_cpu_e6500 in the same way we deal with A=
ltiVec.

-Mike
