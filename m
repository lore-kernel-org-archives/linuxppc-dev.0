Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx011.isp.belgacom.be (outmx011.isp.belgacom.be
	[195.238.5.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5A59E679E7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 May 2006 22:32:39 +1000 (EST)
Received: from outmx011.isp.belgacom.be (localhost [127.0.0.1])
	by outmx011.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k4UCWYe8005884
	for <linuxppc-embedded@ozlabs.org>; Tue, 30 May 2006 14:32:34 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Subject: fs_enet turns promiscous mode off in restart()
Date: Tue, 30 May 2006 14:34:03 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200605301434.03915.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everybody,

I'm having an issue with promiscuous mode in the fs_enet driver. The restart() 
function in drivers/net/fs_enet/mac-fcc.c writes to the FPSMR register:

W32(fccp, fcc_fpsmr, FCC_PSMR_ENCRC);

This disable promiscuous mode. Shouldn't set_multicast_list() be called at the 
end of restart() to restore promiscuous (and multicast) settings ?

A similar issue exists for the FEC and SCC backends.

Laurent Pinchart
