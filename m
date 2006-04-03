Return-Path: <kpoole@mrv.com>
Received: from mailserver.corp.int.mrv.com (mx2.lb.mrv.com [66.43.110.200])
	by ozlabs.org (Postfix) with ESMTP id 58B0667A63
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Apr 2006 07:20:25 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Can't get serial SMC1 and SMC2 working together
Date: Mon, 3 Apr 2006 17:05:13 -0400
Message-ID: <4D8794260B62C940BBA7150CC5EB3BD42D8E15@bosmail.BOS.int.mrv.com>
From: "Kenneth Poole" <kpoole@mrv.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>I'm using a TQM823L board, ELDK and Linux 2.4.25 (from denx). My
>problem is that i can't use both SMC1 and SMC2 at the same time when I
>disable the console
>(console=3Dnull).

Serial port interactions can result from incorrect mapping of the baud
rate generators (BRGs) to the ports.
I'm looking at source from 2.4.19, and this may have changed, but the
serial driver init function
(rs_8xx_init) calls m8xx_cpm_setbrg() with 'baud_idx' as the argument
that selects which BRG. 'baud_idx' is set in serial_console_setup(). If
you don't configure a console, 'baud_idx' may not be initialized.

In any event, make sure that the BRGs are mapped to the ports as
required for your specific board.

Ken Poole
MRV Communications, INC.
