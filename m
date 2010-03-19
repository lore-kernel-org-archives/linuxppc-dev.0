Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8A499B7C8E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Mar 2010 19:15:59 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 2A528B453F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Mar 2010 09:15:48 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: BestComm BD tasks, buffer done flag question
MIME-Version: 1.0
Message-ID: <201003190915.47713.roman.fietze@telemotive.de>
Date: Fri, 19 Mar 2010 09:15:47 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I'm using Grant's platform SCLPC/BestComm driver to transfer data from
an FPGA (to disk). Very often I get a negative result from
bcom_buffer_done because BCOM_BD_READY is not set.

When searching for a solution I found this mail from Rob Broersen
talking about a similar promlem in the MPC5200's FEC interrupt
handler:

http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg16324.html

When I now do something ugly like

	if (!bcom_buffer_done(lpbfifo->bcom_cur_task))
		mdelay(1);

	/* retry */
	if (!bcom_buffer_done(lpbfifo->bcom_cur_task)) {
		ERROR!!!
		return IRQ_HANDLED;
	}

	HANDLE BD

in the ISR I always succeed, even in the cases where the first check
fails and I call the mdelay. Before that I very often ran into the
ERROR!!! case and my transfer "failed".

Is there a better solution? Does the FEC interrupt handler really work
fine as it is right now? I ask, because when I assume that there would
be just one active DB (as it always is with the SCLPC platform driver)
this one would evt. stall if there wasn't a second interrupt causing
the loop to handle it in this second interrupt.


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
