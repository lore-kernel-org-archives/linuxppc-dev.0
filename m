Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CA5B4DDF4F
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 05:51:00 +1100 (EST)
Date: Tue, 12 Feb 2008 12:51:06 -0600
From: Scott Wood <scottwood@freescale.com>
To: Arnd Bergmann <arnd@arndb.de>, Timur Tabi <timur@freescale.com>,
	linuxppc-dev@ozlabs.org
Subject: Re: Could the DTS experts look at this?
Message-ID: <20080212185106.GA4042@loki.buserror.net>
References: <47ACE630.8090101@pikatech.com>
	<20080211235409.GB18348@localhost.localdomain>
	<20080211235652.GC18348@localhost.localdomain>
	<200802120121.45349.arnd@arndb.de>
	<20080212003633.GF18348@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20080212003633.GF18348@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 12, 2008 at 11:36:33AM +1100, David Gibson wrote:
> On Tue, Feb 12, 2008 at 01:21:44AM +0100, Arnd Bergmann wrote:
> > On Tuesday 12 February 2008, David Gibson wrote:
> > > Or to expand.  It's relatively easy now to just include multiple nodes
> > > in the tree and either delete or nop some of them out conditionally
> > > using libfdt.  But the conditional logic should be in the manipulating
> > > agent (u-boot or bootwrapper or whatever), there's no way we're going
> > > to require a conditional expression parser to interpret the device
> > > tree blob itself.
> > 
> > How about making the logic to nop out nodes a little more generic
> > without changes to the binary format?
> > E.g. you could have a "linux,conditional-node" property in the device
> > tree whose value is compared to a HW configuration specific string.
> > In Sean's example, you can have linux,conditional-node="Rev.A" in
> > some nodes and linux,conditional-node="Rev.B" in others, then
> > knock out all devices that have a non-matching linux,conditional-node
> > property, and finally remove the properties themselves before starting
> > the kernel.
> 
> Well, that's basically a u-boot issue.  If they want to do their input
> trees that way, and have helper functions that deal with it...

The actual mechanism that we originially discussed, which Timur later
morphed into conditions-on-nodes, was to have a separate hwoptions node,
under which would be described various hwoptions (jumpers and such) whose
state could be either detected by u-boot or set by environment variable. 
Each hwoption setting would contain a device tree fragment to be merged into
the main device tree.

-Scott
