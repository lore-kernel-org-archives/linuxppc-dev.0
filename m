Return-Path: <barbalace@igi.cnr.it>
Received: from mail.igi.cnr.it (mail.igi.cnr.it [150.178.3.9])
	by ozlabs.org (Postfix) with ESMTP id 9AF9467BE7
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Dec 2006 07:08:01 +1100 (EST)
Received: from mail.igi.cnr.it (localhost.localdomain [127.0.0.1])
	by localhost.igi.cnr.it (Postfix) with ESMTP id 78036348021
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Dec 2006 20:49:59 +0100 (CET)
Received: from igi.cnr.it (mail1.igi.cnr.it [150.178.3.89])
	by mail.igi.cnr.it (Postfix) with ESMTP id 62520348020
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Dec 2006 20:49:59 +0100 (CET)
Received: from [150.178.3.89] (HELO localhost)
	by igi.cnr.it (CommuniGate Pro SMTP 5.0.12)
	with ESMTP id 1575771 for linuxppc-embedded@ozlabs.org;
	Sun, 17 Dec 2006 20:49:59 +0100
Message-ID: <1166384999.45859f6743e9f@webmail.igi.cnr.it>
Date: Sun, 17 Dec 2006 20:49:59 +0100
From: barbalace@igi.cnr.it
To: linuxppc-embedded@ozlabs.org
Subject: intercept_table
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I want to modify at run-time the linux interrupt handler, I see in
/arch/ppc/kernel/head.S a very interesting array: intercept_table. I don't
understand why there are only few references, in my kernel 2.6.14 there are:

intercept_table:
	.long 0, 0, i0x200, i0x300, i0x400, 0, i0x600, i0x700
	.long i0x800, 0, 0, 0, 0, i0xd00, 0, 0
	.long 0, 0, 0, i0x1300, 0, 0, 0, 0
	.long 0, 0, 0, 0, 0, 0, 0, 0
	.long 0, 0, 0, 0, 0, 0, 0, 0
	.long 0, 0, 0, 0, 0, 0, 0, 0

why 0x500 is missed? Is considered not safe to make user change it? ...so I say
that I want to change some of this pointers at run time but reading head.S I
see that the address of i0x* are in a .text segment, can I write in this
segment? Before I write must I turn off MMU or mask some traps?

Regards,
Antonio Barbalace
