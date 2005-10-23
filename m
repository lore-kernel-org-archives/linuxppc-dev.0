Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 990D868601
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Oct 2005 18:28:12 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <Pine.LNX.4.62.0510231021070.16077@numbat.sonytel.be>
References: <20051022213037.GA6097@suse.de>
	<Pine.LNX.4.62.0510231021070.16077@numbat.sonytel.be>
Content-Type: text/plain
Date: Sun, 23 Oct 2005 18:23:31 +1000
Message-Id: <1130055811.7919.61.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>, Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] hide pmac specific drivers if CONFIG_ADB is not set
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2005-10-23 at 10:23 +0200, Geert Uytterhoeven wrote:
> On Sat, 22 Oct 2005, Olaf Hering wrote:
> > SCSI_MESH exists on old Macs, but the PB Lombard has an external connector
> 
> And on some CHRP.
> 
> > --- linux-2.6.14-rc5.orig/drivers/scsi/Kconfig
> > +++ linux-2.6.14-rc5/drivers/scsi/Kconfig
> > @@ -1529,7 +1529,7 @@ config SCSI_DEBUG
> >  
> >  config SCSI_MESH
> >  	tristate "MESH (Power Mac internal SCSI) support"
> > -	depends on PPC32 && PPC_PMAC && SCSI
> > +	depends on PPC32 && PPC_PMAC && SCSI && (ADB_CUDA || ADB_PMU)
> >  	help
> >  	  Many Power Macintoshes and clones have a MESH (Macintosh Enhanced
> >  	  SCSI Hardware) SCSI bus adaptor (the 7200 doesn't, but all of the
> 
> You can no longer enable MESH when compiling for CHRP or when disabling ADB?
> 
> It's clearly visible my LongTrail died last year... :-(

Come on, Geert, I told you back then I was doing that :) You didn't
complain and we figured out nobody around had any of these in working
conditions anymore :)

Ben.
