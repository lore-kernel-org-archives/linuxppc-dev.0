Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5A0F4B6F16
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Dec 2009 01:29:22 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 88935B6463
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 15:29:14 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: MPC5200B XLB Configuration Issues, FEC RFIFO Events, ATA Crashes
MIME-Version: 1.0
Message-ID: <200912091529.13913.roman.fietze@telemotive.de>
Date: Wed, 9 Dec 2009 15:29:13 +0100
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

Hallo,

I had a discussion with some Freescale support people about the
constant RFIFO Event errors or PATA hard disk crashes when stressing a
board with (very) high loads, in my case even with some additional
traffic from an FPGA (or just the FLASH) via the SCLPC FIFO using the
BestComm.

The latest recommendation from Freescale was to set BSDIS and PLDIS
and to clear SE, resulting in a XLB config register value of
0x80012006, at least for my MPC5200B PVR/SVR of
0x80822014/0x80110022. If I am correct, the current XLB config setting
using the current U-Boot and kernel is 0x0000a006.

In order to get cache coherency I had to set
CONFIG_NOT_COHERENT_CACHE=3Dy for the MPC5200B boards. Please correct me
if I am wrong with this assumption.

With this setup, XLB config and kernel config, I do no longer have any
PATA crashes, I do no longer have any FEC RFIFO errors, and my SCLPC
driver runs w/o problems, too.

I would be interested in your opinion, maybe Wolfgang could make some
comments, because he is involved in the U-Boot a lot as well.


Here is the original text from the Freescale support person:

=2D- snippety snip --

Dear Roman Fietze,=20

In reply to your message regarding Service Request SR 1-597437219:

Disable pipelining also. Test your software using the following
setting of the XLB arbiter: 0x80012006.

We have request from a customer with similar problem. Problem
disappeared if XLB pipelining and BestComm snooping were disabled.

Should you need to contact us with regard to this message, please see
the notes below.

Best Regards,=20

Pavel=20
Technical Support
=46reescale Semiconductor

=2D- snappety snap --


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
