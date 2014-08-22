Return-Path: <asierra@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 28E391A000E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Aug 2014 05:02:27 +1000 (EST)
Date: Fri, 22 Aug 2014 14:00:21 -0500 (CDT)
From: Aaron Sierra <asierra@xes-inc.com>
To: Scott Wood <scottwood@freescale.com>
Message-ID: <1876951015.136131.1408734021445.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <1408732591.6510.5.camel@snotra.buserror.net>
References: <1335064415.96829.1408578704825.JavaMail.zimbra@xes-inc.com>
 <1408655996.2395.7.camel@snotra.buserror.net>
 <529271512.72955.1408658076028.JavaMail.zimbra@xes-inc.com>
 <1408658506.2395.11.camel@snotra.buserror.net>
 <964109192.130707.1408730093575.JavaMail.zimbra@xes-inc.com>
 <1408732591.6510.5.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc: fsl_pci: Fix PCI/PCI-X regression
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


----- Original Message -----
> From: "Scott Wood" <scottwood@freescale.com>
> To: "Aaron Sierra" <asierra@xes-inc.com>
> Cc: linuxppc-dev@lists.ozlabs.org, "Minghuan Lian" <Minghuan.Lian@freescale.com>
> Sent: Friday, August 22, 2014 1:36:31 PM
> Subject: Re: [PATCH] powerpc: fsl_pci: Fix PCI/PCI-X regression
> 
> On Fri, 2014-08-22 at 12:54 -0500, Aaron Sierra wrote:
> > ----- Original Message -----
> > > From: "Scott Wood" <scottwood@freescale.com>
> > > Sent: Thursday, August 21, 2014 5:01:46 PM
> > > 
> > > On Thu, 2014-08-21 at 16:54 -0500, Aaron Sierra wrote:
> > > > ----- Original Message -----
> > > > > From: "Scott Wood" <scottwood@freescale.com>
> > > > > Sent: Thursday, August 21, 2014 4:19:56 PM
> > > > > 
> > > > > Why wouldn't a normal PCI agent be able to bus master?
> > > > > 
> > > > > -Scott
> > > > > 
> > > > 
> > > > Short answer:
> > > > 
> > > > Simply because the hardware strapping for Host/Agent determines the
> > > > default state of the Bus Master bit in the Command register. Without
> > > > that bit being set, an Agent won't be able to send the PCI cycles
> > > > necessary to enumerate the bus.
> > > 
> > > But what if the host has already set that bit before Linux boots?
> > 
> > That's a very good point. I think that concern can be addressed by looking
> > for another telltale sign of enumeration, whether an address has been
> > assigned to the bridge's BAR 0 (PCSRBAR).
> 
> I don't see how that's any different.  The host may or may not have
> assigned an address.

I don't agree with that. If the host has enabled bus mastering for the
device, then it also surely would also have assigned an address to the
always on PCSRBAR during enumeration.

In what sort of environment would a host have enabled bus mastering for
a peripheral device _before_ assigning addresses to its BARs?

> > > I understand why you need to do this -- I just don't think this is a
> > > reliable way of detecting that you're in that situation.  How about a
> > > kernel command line setting?
> > 
> > I'd like to avoid requiring a kernel command-line option for this.
> 
> It's hardware description, so you could use a device tree property.
> 

I like this better than a command-line option, but what are you
suggesting? Would you want a device-tree property to gate the logic that
I've proposed?

-Aaron
