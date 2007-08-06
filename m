Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D2924DDE9E
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 09:00:18 +1000 (EST)
Message-ID: <46B7A7E9.5080606@s5r6.in-berlin.de>
Date: Tue, 07 Aug 2007 00:59:53 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH 2.6.22.y] ieee1394: revert "sbp2:
	enforce	32bit	DMA	mapping"
References: <fa.Qn3Snqoik3hhnxcA6HqjGV0Yzck@ifi.uio.no>
	<46B4B3DC.7020609@shaw.ca> <46B4B7C6.1040107@s5r6.in-berlin.de>
	<1186272926.938.8.camel@localhost.localdomain>
	<46B5824B.1000103@s5r6.in-berlin.de>
	<1186351473.938.21.camel@localhost.localdomain>
	<20070806135124.GA2900@suse.de>
	<1186436848.938.75.camel@localhost.localdomain>
	<46B79F25.50205@s5r6.in-berlin.de> <46B79FD7.9020801@shaw.ca>
	<1186439529.938.95.camel@localhost.localdomain>
	<46B7A22D.4030909@shaw.ca>
In-Reply-To: <46B7A22D.4030909@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, stable@kernel.org, linux-kernel@vger.kernel.org,
	Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Robert Hancock wrote:
> I would agree, though, that sbp2 isn't really the place for setting
> this, since the DMA mask is presently a property of the device, not of
> the user..

The mask that sbp2 set was because sbp2 has (in theory, not yet in
practice) a _narrower requirement on address ranges than the chip_ ---
hence it has (in theory) a narrower requirement on DMA mappings than the
ohci1394 driver has.

That's because sbp2 uses the controller in a special mode, as a bus
bridge.  It is the only user of that feature among the higher-level IEEE
1394 drivers.  No other IEEE 1394 application-layer software has this
requirement.

(Well, debugging and forensic tools rely on that mode too, notably
BenH's firescope, but this software runs remote, hence it's a different
beast from sbp2.)
-- 
Stefan Richter
-=====-=-=== =--- --===
http://arcgraph.de/sr/
