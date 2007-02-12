Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DD26FDDEBF
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 10:19:10 +1100 (EST)
Subject: Re: [PATCH 02/10] powerpc: Add device tree fixups for the EFIKA
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <9B771992-8763-4257-83B8-90F7D5A24EC0@kernel.crashing.org>
References: <11713184081457-git-send-email-tnt@246tNt.com>
	<11713184091057-git-send-email-tnt@246tNt.com>
	<11713184101239-git-send-email-tnt@246tNt.com>
	<9B771992-8763-4257-83B8-90F7D5A24EC0@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 13 Feb 2007 10:18:49 +1100
Message-Id: <1171322329.20192.40.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>, Sylvain Munaut <tnt@246tNt.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-02-12 at 17:06 -0600, Kumar Gala wrote:
> On Feb 12, 2007, at 4:13 PM, Sylvain Munaut wrote:
> 
> > We make the efika device tree compliant with the defined bindings
> > (at least compliant enough). This is mostly done by mangling
> > the device_type and compatible properties, but also adding
> > some missing bits.
> >
> > Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
> > Acked-by: Grant Likely <grant.likely@secretlab.ca>
> > ---
> >  arch/powerpc/kernel/prom_init.c |   81 ++++++++++++++++++++++++++++ 
> > +++++++++++
> >  1 files changed, 81 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/ 
> > prom_init.c
> > index 520ef42..4fb5938 100644
> > --- a/arch/powerpc/kernel/prom_init.c
> > +++ b/arch/powerpc/kernel/prom_init.c
> > @@ -2117,11 +2117,92 @@ #else
> >  #define fixup_device_tree_pmac()
> >  #endif
> >
> > +#ifdef CONFIG_PPC_EFIKA
> >
> 
> can't this EFIKA fixup live in efika board code (platforms/52xx/efika*)

Nah, those fixups belong in prom_init which itself may endup being split
in the boot wrappers on day ...

Ben.
