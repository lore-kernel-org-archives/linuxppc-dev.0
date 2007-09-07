Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2C931DDE9D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 12:32:51 +1000 (EST)
Message-ID: <46E0B8A3.3010305@ovro.caltech.edu>
Date: Thu, 06 Sep 2007 19:34:11 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Leonid <Leonid@a-k-a.net>
Subject: Re: PCI target implementation on AMCC PPC CPUs
References: <46E0B178.00C522.05513@m5-81.163.com>
	<406A31B117F2734987636D6CCC93EE3C022418FF@ehost011-3.exch011.intermedia.net>
In-Reply-To: <406A31B117F2734987636D6CCC93EE3C022418FF@ehost011-3.exch011.intermedia.net>
Content-Type: text/plain; charset=GB2312
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi guys,

> You want to say  PPC440GP cannot be PCI slave without
> this non-transparent bridge because as David said
> its "interrupt pin register hardwired to zero" or
> there other reasons?  I'm trying to use
> PPC440ep(or epx) and from its datasheet I don't
> see anything about this zero hardwiring.
> Does it mean "vanilla" PPC440ep will work?

Look in the user manual p562

https://www.amcc.com/MyAMCC/retrieveDocument/PowerPC/440GP/PPC440GP_UM2002_v1_11.pdf

The processor can generate INTA#.

> I have been finished an application using AMCC
> PPC440GP as PCI target(slave) in the last 2 month.
> I use a non-transparent bridge(AMCC PCI6466) to
> make the device a target(slave) like david has said.

However in this case, the bridge was not required
to make the processor target-capable. Most likely
the board required a local PCI bus, and so the
non-transparent bridge is used to hide the board
PCI devices from the other PCI host.

In this type of design the processor is acting
a *host* on the target board. When a host wants
to interrupt the target, it asserts an interrupt
in the bridge, and that interrupt asserts an
interrupt input on the processor.

When the target processor wants to interrupt the
host it writes to a register in the bridge and
the bridge interrupt the host using its INTA#.

In both cases the bridge is the target and the
processors are both hosts.

:)

Dave
