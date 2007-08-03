Return-Path: <SRS0=wAAa=NA=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 331F6DDDFF
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 16:47:32 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/6] PowerPC 440EPx: Sequoia board support
Date: Fri, 3 Aug 2007 08:44:13 +0200
References: <20070730151628.GA5100@ru.mvista.com>
	<20070802153451.5a92947b@weaponx.rchland.ibm.com>
In-Reply-To: <20070802153451.5a92947b@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708030844.13895.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 02 August 2007, Josh Boyer wrote:
> On Mon, 30 Jul 2007 19:16:28 +0400
> > +0400 +++ linux/arch/powerpc/kernel/cputable.c	2007-07-27
> > 20:44:26.000000000 +0400 @@ -1132,6 +1132,42 @@
> >  		.dcache_bsize		= 32,
> >  		.platform		= "ppc440",
> >  	},
> > +	{ /* 440EPX  - with Security/Kasumi  */
> > +		.pvr_mask		= 0xf0000fff,
> > +		.pvr_value		= 0x200008D0,
> > +		.cpu_name		= "440EPX - with Security/Kasumi",
> > +		.cpu_features		= CPU_FTRS_44X,
> > +		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU, /*
> > 440EPX has an FPU */ +		.icache_bsize		= 32,
> > +		.dcache_bsize		= 32,
> > +	},
> > +	{ /* 440EPX  - without Security/Kasumi  */
> > +		.pvr_mask		= 0xf0000fff,
> > +		.pvr_value		= 0x200008D4,
> > +		.cpu_name		= "440EPX - no Security/Kasumi",
> > +		.cpu_features		= CPU_FTRS_44X,
> > +		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU, /*
> > 440EPX has an FPU */ +		.icache_bsize		= 32,
> > +		.dcache_bsize		= 32,
> > +	},
> > +	{ /* 440GRX  - with Security/Kasumi  */
> > +		.pvr_mask		= 0xf0000fff,
> > +		.pvr_value		= 0x200008D8,
> > +		.cpu_name		= "440GRX - with Security/Kasumi",
> > +		.cpu_features		= CPU_FTRS_44X,
> > +		.cpu_user_features	= COMMON_USER_BOOKE, /* 440GRX has no FPU */
> > +		.icache_bsize		= 32,
> > +		.dcache_bsize		= 32,
> > +	},
> > +	{ /* 440GRX  - without Security/Kasumi  */
> > +		.pvr_mask		= 0xf0000fff,
> > +		.pvr_value		= 0x200008DC,
> > +		.cpu_name		= "440GRX - no Security/Kasumi",
> > +		.cpu_features		= CPU_FTRS_44X,
> > +		.cpu_user_features	= COMMON_USER_BOOKE, /* 440GRX has no FPU */
> > +		.icache_bsize		= 32,
> > +		.dcache_bsize		= 32,
> > +	},
>
> Should the 440GRX PVR additions be done in a separate patch?  Or is the
> PVR and cpu features truly the only difference between 440EPx and
> 440GRx?

I think it makes sense to add the 440GRx with this patchset too. The 440GRx is 
a subset of the 440EPx, missing some stuff like USB, FPU. And the AMCC 
Rainier 440GRx eval board is a subset of the Sequoia eval board. So no new 
board specific sources should be necessary to support the Rainier, just a 
different defconfig file.

Best regards,
Stefan
