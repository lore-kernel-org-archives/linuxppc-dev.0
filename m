Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B878BDDF94
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 13:41:30 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l4V3fO9I008076
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 20:41:25 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l4V3fNdQ026853
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 22:41:24 -0500 (CDT)
Subject: Re: [PATCH v2]: Fix e500 v2 core reboot bug
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <976AFF56-7590-46B9-ADCA-4FA6673D4C9B@kernel.crashing.org>
References: <1180406209.8139.13.camel@localhost.localdomain>
	<BA0C2035-FCAD-4B34-A622-F79432079F10@kernel.crashing.org>
	<1180492466.12577.6.camel@localhost.localdomain>
	<A78C881D-26C3-4545-85CA-80C05085C039@kernel.crashing.org>
	<1180503967.12577.20.camel@localhost.localdomain>
	<19325B38-202C-4837-9BE8-0ACA482F2605@kernel.crashing.org>
	<976AFF56-7590-46B9-ADCA-4FA6673D4C9B@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1180582852.16155.18.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 31 May 2007 11:40:52 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-30 at 21:49, Kumar Gala wrote:
> >>>>> I'm not terrible happy with blindly writing to rstcr.
> >>>>>
> >>>> I can understand you.
> >>>> But I jut want to make things simple and workable.
> >>>> Any idea?
> >>>
> >>> one idea would be for us to add a property on the soc node.
> >>> Something like has-rstcr or something similar in a guts node?
> >> I have seen your suggestion before to add a property in device
> tree.
> >> But I still think the current implementation is simple.
> >
> > While it simple you are depending on the fact that a given
> > implementation may or may not have something at the particular
> > offset.  Who knows if 8599 or some future part could put the 'cause
> > my part to smoke and self-destruct' at the same offset in the  
> > future :)
> >
> >> Anyway, I can try your suggestion.
> >
> > I'm thinking have a guts block and putting a property in it makes
> the
> > most sense.
> 
> After some discussion on IRC I think the following is the suggested  
> node we should add in.
> 
> guts@e00000 {
>         compatible = "fsl,mpc8548-guts";
>         reg = <e00000 1000>;
>         fsl,has-rstcr;
> };

Great!
Roy
