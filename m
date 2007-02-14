Return-Path: <dgibson@ozlabs.org>
Date: Thu, 15 Feb 2007 10:37:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS
	files
Message-ID: <20070214233703.GI16279@localhost.localdomain>
References: <1171409687840-git-send-email-timur@freescale.com>
	<1171411075.20192.116.camel@localhost.localdomain>
	<45D29AE5.7090004@freescale.com>
	<1171430877.20192.133.camel@localhost.localdomain>
	<45D29EB1.5060801@freescale.com>
	<1171431334.20192.138.camel@localhost.localdomain>
	<45D316CD.9070901@freescale.com>
	<1171486473.20192.147.camel@localhost.localdomain>
	<45D378F4.3040003@freescale.com>
	<1171487822.20192.163.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1171487822.20192.163.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Timur Tabi <timur@freescale.com>,
	Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 15, 2007 at 08:17:02AM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2007-02-14 at 15:02 -0600, Timur Tabi wrote:
> > Benjamin Herrenschmidt wrote:
> > 
> > >> Obviously, the kernel needs a 'chosen' section, and that's why U-Boot 
> > >> adds one.  And since U-Boot adds one, the DTS itself doesn't need one. 
> > >> Does the 8272 never use U-Boot?
> > > 
> > > I'm not talking specifically about the 8272. I think we should at it
> > > back to all dts's
> > 
> > Ugh.  Considering that U-Boot overrides whatever is in the 'chosen' section, can 
> > you tell me why you think it should be there?  If we put an empty 'chosen' 
> > section in the DTS files, are we actually doing anything meaningful?
> > 
> > In the interest of saving time, I'm going to respin my patch without the 
> > 'chosen' section removed.
> 
> In case somebody wants to use something else than uboot ? I'd like the
> base structure of the mandatory nodes to be there. /chosen is mandatory,
> so it should be there.

More specifically:
	1) Having an (even empty) /chosen makes life easier for other
	bootloaders, which may have quite limited capability to edit
	device tree blobs.

	2) It seems to me the dts files *included with the kernel*
	should be suitable for direct use in zImage wrappers, where
	possible, for use with old uboot and other non device tree
	capable firmwares.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
