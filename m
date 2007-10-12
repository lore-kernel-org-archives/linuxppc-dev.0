Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 994B7DDDF8
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 Oct 2007 06:43:42 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Override timer interrupt
Date: Fri, 12 Oct 2007 15:43:39 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B037D4BA9@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
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

Is there an easy way to use something other than the decrementer for the
timer interrupt?

Reason i'm asking is tha t on our board, the decrementer cannot be
divided to 1khz evenly, so we have rounding errors for time, but we do
have a 1KHz timer interrupt from an FPGA that is source of a T1 clock.

Right now I let the decrementer interrupt do nothing, and made my own
timer interrupt handler that calls the stuff the timer_interrupt usually
does.=20

This works, but there are some instability (ie unexplained hangs) that
showed up when I did this.
