Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 6B9B6B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 10 Nov 2009 23:47:41 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 671A5C5053
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 10 Nov 2009 13:47:34 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: MPC5200B FEC_IEVENT_RFIFO_ERROR leading to Link is Down
MIME-Version: 1.0
Message-ID: <200911101347.33837.roman.fietze@telemotive.de>
Date: Tue, 10 Nov 2009 13:47:33 +0100
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

When having high traffic on the MPC5200B ATA (MWDMA2), FEC (100MBit)
and LPC (MTD FLASH read) I will get the typical
=46EC_IEVENT_RFIFO_ERROR's.

Without the FLASH reads, that we use to stress the probably existing
LPC arbiter or MPC5200B silicon bug when running UDMA2+LPC, and which
should not happen using MWDMA2+LPC, I could not yet reproduce the
=46EC_IEVENT_RFIFO_ERROR.

Now comes the problem: since the PHY driver rework followed by John
Bonesio's fix (rev 37ccd92f55c6c6) to avoid accessing the DIO bus at
interrupt context, this now sometimes causes an irrecoverable link
down (PHY: f0003000:00 - Link is Down). This patch is of course
necessary to avoid a panic.

I can reproduce that on the current DENX/master using an own board
very close to the Lite5200B. This board runs fine under the old
2.4.25, of course also sometimes showing the FEC FIFO error.

Any ideas?


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
