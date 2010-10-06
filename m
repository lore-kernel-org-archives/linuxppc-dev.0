Return-Path: <david.hagood@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) by ozlabs.org (Postfix) with ESMTP id 1A880B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Oct 2010 03:20:17 +1100 (EST)
Received: by gxk28 with SMTP id 28so2897024gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 06 Oct 2010 09:20:15 -0700 (PDT)
Received: from localhost (Deathwish [127.0.0.1])
	by Deathwish.hagood.sktc.net (Postfix) with ESMTP id B0DEEC7B8043
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Oct 2010 11:20:11 -0500 (CDT)
Message-ID: <56e21593e98493b02bcda171b200241a.squirrel@localhost>
Date: Wed, 6 Oct 2010 11:20:11 -0500
Subject: MPC8641D PCI Endpoint incoming interrupts?
From: david.hagood@gmail.com
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm trying to use an MPC8641D as a PCIe endpoint device, and I'm trying to
work out how the host root complex CPU can interrupt the PPC core. It's
not very clear how to do all of this, and I'd like some help fitting the
pieces together. If there's a good how-to online I've yet to find it.

As I read it, on the host side, I'd do one of:
1) a write to the PPC's BAR0, offset 0x41400 (MSGR0) with some message value
2) a write to BAR0 offset 0x41600 (MSIR0) and set a bit within it.
3) a write to 0x41740 (MSIIR) to set a bit in MSIR0

So question #1 is "which of those should I use?" (or should I use
something else?)

Then, as I read it, I'd have to somehow convert the interrupt vector the
PIC uses into a virtual interrupt number suitable for request_irq. I've
seen mentions of irq_of_parse_and_map(), but I've not found a good
description of how to use it. Does anybody have any (non-null) pointers on
this?

Once I get to request_irq I'm on familiar ground.
