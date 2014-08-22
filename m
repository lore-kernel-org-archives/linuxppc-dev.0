Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0207.outbound.protection.outlook.com [207.46.163.207])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D08C1A0455
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Aug 2014 04:36:47 +1000 (EST)
Message-ID: <1408732591.6510.5.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc: fsl_pci: Fix PCI/PCI-X regression
From: Scott Wood <scottwood@freescale.com>
To: Aaron Sierra <asierra@xes-inc.com>
Date: Fri, 22 Aug 2014 13:36:31 -0500
In-Reply-To: <964109192.130707.1408730093575.JavaMail.zimbra@xes-inc.com>
References: <1335064415.96829.1408578704825.JavaMail.zimbra@xes-inc.com>
 <1408655996.2395.7.camel@snotra.buserror.net>
 <529271512.72955.1408658076028.JavaMail.zimbra@xes-inc.com>
 <1408658506.2395.11.camel@snotra.buserror.net>
 <964109192.130707.1408730093575.JavaMail.zimbra@xes-inc.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-08-22 at 12:54 -0500, Aaron Sierra wrote:
> ----- Original Message -----
> > From: "Scott Wood" <scottwood@freescale.com>
> > Sent: Thursday, August 21, 2014 5:01:46 PM
> > 
> > On Thu, 2014-08-21 at 16:54 -0500, Aaron Sierra wrote:
> > > ----- Original Message -----
> > > > From: "Scott Wood" <scottwood@freescale.com>
> > > > Sent: Thursday, August 21, 2014 4:19:56 PM
> > > > 
> > > > Why wouldn't a normal PCI agent be able to bus master?
> > > > 
> > > > -Scott
> > > > 
> > > 
> > > Short answer:
> > > 
> > > Simply because the hardware strapping for Host/Agent determines the
> > > default state of the Bus Master bit in the Command register. Without
> > > that bit being set, an Agent won't be able to send the PCI cycles
> > > necessary to enumerate the bus.
> > 
> > But what if the host has already set that bit before Linux boots?
> 
> That's a very good point. I think that concern can be addressed by looking
> for another telltale sign of enumeration, whether an address has been
> assigned to the bridge's BAR 0 (PCSRBAR).

I don't see how that's any different.  The host may or may not have
assigned an address.

> > I understand why you need to do this -- I just don't think this is a
> > reliable way of detecting that you're in that situation.  How about a
> > kernel command line setting?
> 
> I'd like to avoid requiring a kernel command-line option for this.

It's hardware description, so you could use a device tree property.

-Scott
