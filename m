Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0F5BDB6F11
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Aug 2010 04:02:41 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 7/9] RapidIO: Add handling for PW message from a lost
	device
Date: Mon, 16 Aug 2010 11:02:21 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552011D6040@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4C692F31.2020705@neli.hopto.org>
References: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
	<1281712686-31308-8-git-send-email-alexandre.bounine@idt.com>
	<4C692F31.2020705@neli.hopto.org>
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
> > Add check if PW message source device is accessible and change PW
message
> > handler to recover if PW message source device is not available
anymore (power
> > down or link disconnect).
>=20
> I am not quite sure what the point is of this patch. What do you need
to
> recover from?

>From failed maintenance read. In the previous version PW handler had
troubles if maintenance
read request fails. Now I am trying to detect lost or remover devices as
soon as I see broken link.

>=20
> > To avoid possible loss of notification, the PW message handler scans
the route
> > back from the source device to identify end of the broken link.
>=20
> Do you mean if port-writes are dropped? Then they did not reach you in
> the first place. If a link in between is broken, the associated switch
> will 'complain' and send port-writes, no?

Situation that I am trying to resolve is mostly applicable to larger
systems that have multiple complex boards (or chassis/domains) connected
together. Power down sequence on the board (chassis) combined with
switch hierarchy may allow switch to send PW message to the host before
its power is off. This will create an orphaned PW message.=20
At the same time there is no guarantee that PW message from the
associated switch will reach the host.
That "real" PW message may be dropped by the controller (85xx is good
example). Everything depends on number of PW messages directed to the
host/controller. I am trying to use the first available notification to
service device removal. If the "real" PW message is received it should
be processed without any further action.=20

Alex.
