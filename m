Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 1B732DDEFB
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 16:57:31 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Grant Erickson <gerickson@nuovations.com>
Subject: Re: PPC4xx ECC Configs, Defines and Source
Date: Tue, 9 Dec 2008 06:57:23 +0100
References: <C562F078.1353A%gerickson@nuovations.com>
In-Reply-To: <C562F078.1353A%gerickson@nuovations.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200812090657.23968.sr@denx.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Grant,

On Tuesday 09 December 2008, Grant Erickson wrote:
> > Just to make sure, are you planning on just implementing a driver to
> > deal with whatever settings the bootloader configured?  E.g., if ECC is
> > enabled deal with correctable/uncorrectable errors and if not, do
> > nothing?  Basically you are looking to implement a scrub driver, yes?
> >
> > I ask because since ECC is memory module specific and memory controller
> > setup is pretty tricky, I think it's best to leave whatever
> > configuration the bootloader set and work with that.  Having to redo
> > memory controller setups in Linux to enable ECC isn't something I'd
> > look forward to.
>
> Precisely. The driver will basically check if ECC is enabled (as was
> set/not set by u-boot) and, if so, will take ECC SEC/DED interrupts, log
> SEC errors to some data structure fetchable by a proc entry or some device
> node. For DED errors, execute on some policy, at its simplest, generating a
> panic.
>
> At no point will the driver/code attempt to change the controller
> configuration beyond reading/clearing ECC event/interrupt status.

Seems that such a driver should be implemented in the Linux EDAC subsystem 
(see drivers/edac and Documentation/edac.txt) to me. Did you take a look at 
this?

Best regards,
Stefan
