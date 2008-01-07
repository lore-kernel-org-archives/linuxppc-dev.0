Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 09C39DDEC2
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 06:05:18 +1100 (EST)
Received: from pd3mr2so.prod.shaw.ca
	(pd3mr2so-qfe3.prod.shaw.ca [10.0.141.178]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JUA0012XFNRX2E0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 07 Jan 2008 12:04:39 -0700 (MST)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
	by pd3mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JUA00KBYFLYV400@pd3mr2so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 07 Jan 2008 12:03:37 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JUA00DLIFLXXV00@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 07 Jan 2008 12:03:33 -0700 (MST)
Date: Mon, 07 Jan 2008 12:03:30 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC 0/2] mpc5200: eliminate direct manipulation of shared registers
	from SPI driver
To: dragos.carp@toptica.com, linuxppc-dev@ozlabs.org
Message-id: <20080107185849.13535.38262.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The mpc5200 PSC SPI driver driver directly manipulates the port_config
and the CDM registers on the mpc5200 which it should not do.  port_config
should only be manipulated from within the board specific platform code
and the CDM registers are shared between multiple devices.

This patch eliminates the port_config manipulations and adds a common
routine for adjusting CDM settings.  Boards using the SPI driver will
need to add the required port_config changes to either the boot firmware
or the platform code.

If there are no objections, I plan to ask Paulus to merge these in the
next couple of days.

Cheers,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
