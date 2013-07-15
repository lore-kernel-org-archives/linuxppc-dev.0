Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 45FA22C02A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2013 02:55:27 +1000 (EST)
Date: Mon, 15 Jul 2013 11:55:11 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/fsl-booke: Work around erratum A-006958
To: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
References: <1373677412-24329-1-git-send-email-scottwood@freescale.com>
 <87mwpojr6d.fsf@linux.vnet.ibm.com>
In-Reply-To: <87mwpojr6d.fsf@linux.vnet.ibm.com> (from
 aneesh.kumar@linux.vnet.ibm.com on Mon Jul 15 01:03:22 2013)
Message-ID: <1373907311.8183.298@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/15/2013 01:03:22 AM, Aneesh Kumar K.V wrote:
> Scott Wood <scottwood@freescale.com> writes:
>=20
>=20
>=20
> > diff --git a/arch/powerpc/platforms/Kconfig.cputype =20
> b/arch/powerpc/platforms/Kconfig.cputype
> > index ae0aaea..7f0e2e5 100644
> > --- a/arch/powerpc/platforms/Kconfig.cputype
> > +++ b/arch/powerpc/platforms/Kconfig.cputype
> > @@ -165,6 +165,17 @@ config PPC_E500MC
> >  	  such as e5500/e6500), and must be disabled for running on
> >  	  e500v1 or e500v2.
> >
> > +config FSL_ERRATUM_A_006958
> > +	bool
> > +	depends on PPC_E500MC && PPC64
> > +	default y
> > +	help
> > +	  Workaround for erratum A-006958, which says that 64-bit
> > +	  timebase reads are not atomic.  The workaround is to fall back
> > +	  to the 32-bit method of reading timebase.  Note that timebase
> > +	  is readable by userspace, so any non-vdso userspace accesses
> > +	  will need to have the workaround applied separately.
> > +
> >  config PPC_FPU
> >  	bool
> >  	default y if PPC64
>=20
>=20
> I am completely new to this area, so ignore if it is silly. But how do
> we expect to select this config ? Should that happen via .config ?

It will automatically be selected if PPC_E500MC and PPC64 are both =20
selected.

-Scott=
