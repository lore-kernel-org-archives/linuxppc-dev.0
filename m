Return-Path: <Matteo.Fortini@mta.it>
Received: from cluster-a.mailcontrol.com (cluster-a.mailcontrol.com
	[85.115.52.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.mailcontrol.com",
	Issuer "DigiCert Global CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C8BE9B7B69
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 12 Oct 2009 23:00:00 +1100 (EST)
Received: from rly07a.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly07a.srv.mailcontrol.com (MailControl) with ESMTP id
	n9CBE60d022588
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2009 12:14:22 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly07a.srv.mailcontrol.com (MailControl) id n9CBE0ia021605
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2009 12:14:00 +0100
Message-ID: <4AD30DF0.1000901@mta.it>
Date: Mon, 12 Oct 2009 13:07:28 +0200
From: Fortini Matteo <matteo.fortini@mta.it>
MIME-Version: 1.0
To: u-boot@lists.denx.de
Subject: Linux seamless booting
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,
we've been working on a PPC512x board booting with u-boot + linux 
2.6.24.6, and one major issue for our application is boot time.

Right now, we went down to less than 6s boot time (i.e. time from power 
off to launch of the user app), even with some drivers installed, i.e.:

    * CAN bus
    * GPU on PCI bus
    * USB host
    * UBI

with r/o squashfs root and r/w ubifs configuration filesystem mounted 
from a NOR flash memory.

This time could be enough for the high-level application (we're showing 
a splash screen in about 2-3s so it's ok if the main app takes a little 
longer to come up), but the whole system is connected to others via CAN 
and we can't afford the "black out" period between u-boot and linux.

Some other operating systems (e.g. QNX) have this "seamless booting" 
function, in which drivers are started in stages, so that a (minimal) 
functionality can be given in milliseconds, and more functionalities 
come up as time goes by.

Is there a way to support something similar with the u-boot -> linux 
solution?

Thank you,
Matteo
