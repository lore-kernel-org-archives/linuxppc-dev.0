Return-Path: <jangiels@speakeasy.net>
Received: from mail2.speakeasy.net (mail2.speakeasy.net [216.254.0.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 62BE42BDA0
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Oct 2004 13:50:59 +1000 (EST)
Received: from dsl017-104-254.spk0.dsl.speakeasy.net (HELO [192.168.0.10])
	(jangiels@[69.17.104.254]) (envelope-sender <jangiels@speakeasy.net>)
	by mail2.speakeasy.net (qmail-ldap-1.03) with SMTP
	for <linuxppc-dev@ozlabs.org>; 21 Oct 2004 03:50:52 -0000
From: Jeff Angielski <jangiels@speakeasy.net>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1098330658.9230.59.camel@nighteyes.localdomain>
Mime-Version: 1.0
Date: Wed, 20 Oct 2004 23:50:58 -0400
Subject: SCC UART stalling/hanging - progress
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


It appears that the SCC UART is stalling when I perform loopback testing
at 230kbps because the bottom half is sometimes not being executed when
the transmit interrupt is received by the ISR.  Because of this, no more
data is being put into the TX buffers and the SCC is sitting there dumb
and happy with nothing to do.  

Using the BDI2000 I have been able to confirm that at the point when the
SCC stalls, the SCC registers, parameter ram, BDs, and buffers all look
good.  There are no pending events, the flags in the BDs are consistent
with an idle condition, and the tx buffers match the rx buffers which
match the data received by the user space application.

Specifically, problem that I see is that when transmit_chars() is called
from rs_8xx_interrupt(), the TX_WAKEUP flag is not set.  This means that
rs_sched_event() is never called and everything stalls.  The bad thing
is that the TX_WAKEUP is only modified in a handful of places and it is
not obvious as to how a race condition could occur.

Does anybody have any ideas or suggestions on what to look at next?

TIA,
Jeff Angielski
