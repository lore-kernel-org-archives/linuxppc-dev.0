Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0235.outbound.protection.outlook.com [207.46.163.235])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B4A61A0042
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Aug 2014 08:02:03 +1000 (EST)
Message-ID: <1408658506.2395.11.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc: fsl_pci: Fix PCI/PCI-X regression
From: Scott Wood <scottwood@freescale.com>
To: Aaron Sierra <asierra@xes-inc.com>
Date: Thu, 21 Aug 2014 17:01:46 -0500
In-Reply-To: <529271512.72955.1408658076028.JavaMail.zimbra@xes-inc.com>
References: <1335064415.96829.1408578704825.JavaMail.zimbra@xes-inc.com>
 <1408655996.2395.7.camel@snotra.buserror.net>
 <529271512.72955.1408658076028.JavaMail.zimbra@xes-inc.com>
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

On Thu, 2014-08-21 at 16:54 -0500, Aaron Sierra wrote:
> ----- Original Message -----
> > From: "Scott Wood" <scottwood@freescale.com>
> > Sent: Thursday, August 21, 2014 4:19:56 PM
> > 
> > On Wed, 2014-08-20 at 18:51 -0500, Aaron Sierra wrote:
> > > @@ -520,9 +520,22 @@ int fsl_add_bridge(struct platform_device *pdev, int
> > > is_primary)
> > >  			goto no_bridge;
> > >  
> > >  	} else {
> > > -		/* For PCI read PROG to identify controller mode */
> > > -		early_read_config_byte(hose, 0, 0, PCI_CLASS_PROG, &progif);
> > > -		if ((progif & 1) == 1)
> > > +		u16 master;
> > > +
> > > +		/*
> > > +		 * If the controller is PCI-X, then Host mode refers to a
> > > +		 * bridge that drives the PCI-X initialization pattern to
> > > +		 * indicate bus operating mode/frequency to devices on the bus.
> > > +		 * Some hardware (specifically PrPMC modules) are Agents, since
> > > +		 * the mezzanine carrier is responsible for driving the
> > > +		 * pattern, but they still may perform bus enumeration.
> > > +		 *
> > > +		 * Allow the bridge to be used for enumeration, if hardware
> > > +		 * strapping (Host mode) or firmware (Agent mode) has enabled
> > > +		 * bus mastering.
> > > +		 */
> > > +		early_read_config_word(hose, 0, 0, PCI_COMMAND, &master);
> > > +		if (!(master & PCI_COMMAND_MASTER))
> > >  			goto no_bridge;
> > >  	}
> > 
> > Why wouldn't a normal PCI agent be able to bus master?
> > 
> > -Scott
> > 
> 
> Short answer:
> 
> Simply because the hardware strapping for Host/Agent determines the
> default state of the Bus Master bit in the Command register. Without
> that bit being set, an Agent won't be able to send the PCI cycles
> necessary to enumerate the bus.

But what if the host has already set that bit before Linux boots?

> Long answer:
> 
> I think there was an assumption in the patch that introduced the
> regression that Host and Agent in conventional PCI and PCI-X are more
> equivalent to PCIe Root Complex and Endpoint than they really are.
> 
> I think the purpose of Minghuan's patch was to not attempt to enumerate
> the bus with a bridge that simply cannot do it. A PCIe Endpoint cannot
> enumerate the bus and a PCI/PCI-X device that cannot master cycles on the
> bus will not be able to enumerate the bus either.

No, the point is also to not enumerate the bus in cases where we
shouldn't.  We don't want to step on the host's toes.

> The hardware strapping for Host/Agent mode determines the default state
> of the Bus Master bit in the Command register.
> 
> In our more specialized, but still industry standardized, environment our
> firmware must detect whether our board should be the bus's sole enumerator
> and set the Bus Master bit accordingly.
> 
> My comment in the code still mentions Host and Agent mode, simply because
> the code it is replacing based its decision on the mode.

I understand why you need to do this -- I just don't think this is a
reliable way of detecting that you're in that situation.  How about a
kernel command line setting?

-Scott
