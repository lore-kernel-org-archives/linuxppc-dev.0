Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 44376B6EEC
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Aug 2010 00:47:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 5/9] RapidIO: Add default handler for error_stopped state
Date: Mon, 16 Aug 2010 07:47:18 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552011D5F71@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4C692D4D.1030401@neli.hopto.org>
References: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
	<1281712686-31308-6-git-send-email-alexandre.bounine@idt.com>
	<4C692D4D.1030401@neli.hopto.org>
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
> > +
> > +	if (err_status & RIO_PORT_N_ERR_STS_PW_OUT_ES) {
> > +		pr_debug("RIO_EM: servicing Output Error-Stopped
state\n");
> > +		/*
> > +		 * Send a Link-Request/Input-Status control symbol
> > +		 */
> > +
> > +		/* Read from link maintenance response register
> > +		 * to clear valid bit */
> > +		rio_mport_read_config_32(mport, destid, hopcount,
> > +			rdev->phys_efptr + RIO_PORT_N_MNT_RSP_CSR(pnum),
> > +			&regval);
> > +		udelay(50);
>=20
> Perhaps this whole part of operating the MNT_RSP registers (sending
> link-request symbol is the only useful action IIRC?) can be put in a
> separate function for readability.
>=20
I was on the fence with this one. Now I have an extra vote in favor of a
separate function ;)
Will do.
=20
