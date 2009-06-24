Return-Path: <cbouatmailru@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BD52DB709A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Jun 2009 07:51:52 +1000 (EST)
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by ozlabs.org (Postfix) with ESMTP id E938EDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 07:51:51 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id e21so3799fga.16
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 14:51:49 -0700 (PDT)
Date: Thu, 25 Jun 2009 01:50:41 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] gianfar: Fix half-duplex operation for non-MII/RMII
	interfaces
Message-ID: <20090624215041.GA8416@oksana.dev.rtsoft.ru>
References: <20090624182734.GA14306@oksana.dev.rtsoft.ru>
	<ED58F994-6BDC-4496-8445-EA1D984F1379@freescale.com>
	<20090624211038.GA29555@oksana.dev.rtsoft.ru>
	<FFCBF074-5F39-4D0C-A0C3-F488A619C821@freescale.com>
	<20090624213945.GB4163@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090624213945.GB4163@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Li Yang <leoli@freescale.com>, David Miller <davem@davemloft.net>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 25, 2009 at 01:39:45AM +0400, Anton Vorontsov wrote:
> On Wed, Jun 24, 2009 at 04:25:06PM -0500, Andy Fleming wrote:
> [...]
> >>> My concern is that you will be detecting the GMII interface, and
> >>> disallowing half-duplex, despite the fact that the interface is  
> >>> actually
> >>> running at 10 or 100 Mbit.
> >>
> >> Very interesting, though I'm not sure I'm completely following. :-)
> >>
> >> Are you saying that I should do this instead:
> >>
> >> 	if (!phydev->duplex &&
> >> 			(phyi == PHY_INTERFACE_MODE_MII ||
> >> 			 phyi == PHY_INTERFACE_MODE_RMII ||
> >> 			 (phyi == PHY_INTERFACE_MODE_GMII &&
> >> 			  phydev->speed < 1000)))
> >> 		tempval &= ~MACCFG2_FULL_DUPLEX;
> >> 	else
> >> 		tempval |= MACCFG2_FULL_DUPLEX;
> >>
> >> i.e. we detected GMII interface initially, but it downgraded
> >> to MII since speed is < 1000, thus we can set half-duplex in MAC?
> >
> > Yeah, I think that works out more correctly.
> 
> Cool, thanks.
> 
> Do you happen to know how gianfar iface auto-detection works in HW?
> I mean, if we connect 100 Mbs link to the GMII PHY, then
> gfar_get_interface() would return MII, correct?

Stupid me. HW has nothing to do with this. GMII, just as you said,
is just a marker, comes from FSL_GIANFAR_DEV_HAS_GIGABIT flag.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
