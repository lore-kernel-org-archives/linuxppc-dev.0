Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 32F4DDDEC0
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 10:14:01 +1100 (EST)
Date: Fri, 12 Jan 2007 15:13:17 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/7] Powerpc MSI implementation
Message-ID: <20070112231317.GC665@kroah.com>
References: <1168514716.63474.857278133999.qpush@cradle>
	<20070111112503.0CC1BDDF13@ozlabs.org>
	<20070111194427.GA20450@kroah.com>
	<1168550403.22458.414.camel@localhost.localdomain>
	<1168552498.22458.428.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1168552498.22458.428.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Olof Johannsson <olof@lixom.net>, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 12, 2007 at 08:54:57AM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2007-01-12 at 08:20 +1100, Benjamin Herrenschmidt wrote:
> > > So, no, I don't agree with this implementation and don't want to see it
> > > go through anyone's tree into mainline just yet.
> > 
> > So why, when we posted it earlier, you said the exact opposite ? That
> > you actually liked it and wanted to see it as a replacement of the
> > current cruft ?
> > 
> > That's been the logic from day one. We implement a generic MSI support
> > that supports multiple backends, we do it as a powerpc version at first
> > since that's what we can actively test and provide backends for, then as
> > a second step, we work with the intel folks to port their stuff over to
> > our implementation and replace the current crappy generic one.
> 
> /me calms down a bit ... :-)
> 
> Ok, so what about we do:
> 
>  - Move that new implementation to drivers/pci
>  - Have a CONFIG_NEW_MSI or something like that to select between
> the old and the new implementation
>  - Have the change to pci_dev be based on that config option

No, what's wrong with just fixing everything up to work properly all at
once?  The Altix code should have been a step forward in making this
"abstracted" into something that other arches could use.  If that's not
true, then please work everything so that it all works nicely together.

In short, I don't want to see two different implementations in the tree
at the same time, that's not acceptable, sorry.

thanks,

greg k-h
