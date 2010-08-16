Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 20596B6EDF
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Aug 2010 00:02:24 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 4/9] RapidIO: Add relation links between RIO device
	structures
Date: Mon, 16 Aug 2010 07:00:37 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552011D5F1F@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4C692C9D.6040100@neli.hopto.org>
References: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
	<1281712686-31308-5-git-send-email-alexandre.bounine@idt.com>
	<4C692C9D.6040100@neli.hopto.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Micha Nelissen" <micha@neli.hopto.org>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, "Bounine,
	Alexandre" <Alexandre.Bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Micha Nelissen wrote:
>=20
> Alexandre Bounine wrote:
> > Create back and forward links between RIO devices. These links are
intended for
> > use by error management and hot-plug extensions.
>=20
> As RapidIO is a switched network, the concept of 'previous' and 'next'
> devices is invalid. Perhaps it's just the way they were
> discovered/enumerated, but that does not matter any more at runtime.
Or
> at least, should not matter.
>

Yes, the "previous" and "next" have to be considered in context of
enumeration/discovery.
At runtime, it does not matter for data traffic, but is valuable
information for error recovery
And hot-swap. This provides snapshot of device connections. For example,
when servicing
error-stopped state of link between two switches you need to know
ingress port of far switch on
the link. It may be a problem to read it directly from the device.
Searching through the device list
becomes time consuming as a system size grows.     =20
=20
> > @@ -237,6 +241,7 @@ struct rio_switch {
> >  	u16 hopcount;
> >  	u16 destid;
> >  	u8  inport;
> > +	u8  nports;
> >  	u8 *route_table;
> >  	u32 port_ok;
>=20
> This can be extracted from the swpinfo field (which you removed in
> another patch)?
>=20
Agreed in response for patch #3
