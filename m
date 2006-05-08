Return-Path: <walt.wimer@timesys.com>
Received: from postfix.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id A1CB3679E0
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 May 2006 03:55:31 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by postfix.timesys.com (Postfix) with ESMTP id 4947580697A7
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  8 May 2006 13:23:13 -0400 (EDT)
Received: from postfix.timesys.com ([127.0.0.1])
	by localhost (postfix.timesys.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 12240-07 for <linuxppc-embedded@ozlabs.org>;
	Mon,  8 May 2006 13:23:11 -0400 (EDT)
Received: from exchange.timesys.com (exchange.timesys.com [192.168.2.250])
	by postfix.timesys.com (Postfix) with ESMTP id 04E8F806978E
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  8 May 2006 13:23:11 -0400 (EDT)
Subject: IMAP_ADDR on PPC 8xx
From: "Walter L. Wimer III" <walt.wimer@timesys.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Mon, 08 May 2006 13:23:03 -0400
Message-Id: <1147108983.27101.63.camel@excalibur.timesys.com>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Everyone,

I'm looking for wisdom/understanding about IMAP_ADDR on PPC 8xx
platforms.

In particular, I have an MPC885ADS board running "U-Boot 1.1.3 (Apr 19
2005 - 13:39:58)".  It will boot neither 2.6.15 nor 2.6.16.11.  After
U-Boot decompresses the kernel, I get no kernel output at all; it just
hangs.

After some debugging, I think things go awry when the code starts
dereferencing IMAP_ADDR as a direct pointer.  IMAP_ADDR is defined to be
0xFF000000, but the MPC885ADS documentation says that the internal
memory map is supposed to at 0x22000000.  In addition, when I look at
the bd_t pointer from U-Boot, it's saying that 0x22000000 is the correct
address.

We have a 2.6.11.7 kernel that successfully boots on this board.  The
port was done by another engineer who has moved on to another job.  His
port includes a patch that replaces all references to IMAP_ADDR with a
global pointer that is initialized using io_remap() of the internal map
value from the U-Boot bd_t structure.

Why is this a problem for us and apparently not for anyone else on this
list?  Is no one else using U-Boot?  Or does everyone else's U-Boot use
0xFF000000 instead of 0x22000000?  Or do I have a different problem
entirely?  :-)

While reading through the archives, I see that using IMAP_ADDR the way
it is currently used is somewhat frowned upon anyway.  Is this one of
those things that we (the PPC Linux community) should fix the "right
way" once and for all?  I'm happy to submit a patch once I understand
what the "right way" is...  :-)



Thanks!!!

Walt Wimer
TimeSys Corporation
