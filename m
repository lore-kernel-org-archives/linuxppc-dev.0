Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7CF97DDED0
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 06:24:29 +1000 (EST)
Message-ID: <46E06259.5010305@ovro.caltech.edu>
Date: Thu, 06 Sep 2007 13:26:01 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Leonid <Leonid@a-k-a.net>
Subject: Re: PCI target implementation on AMCC PPC CPUs
References: <556445368AFA1C438794ABDA8901891C06460054@USA0300MS03.na.xerox.net>	<20070906184308.GA22380@ld0162-tx32.am.freescale.net>
	<406A31B117F2734987636D6CCC93EE3C022417D2@ehost011-3.exch011.intermedia.net>
In-Reply-To: <406A31B117F2734987636D6CCC93EE3C022417D2@ehost011-3.exch011.intermedia.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Leonid,

In case they are not in the document:

There are several fundamental problems with the AMCC 440EP
acting as a PCI target/slave;

1. As a PCI target, there is only one way to generate
    an interrupt to a host; you basically toggle the
    interrupt pin. This makes it tricky to develop a
    host-to-slave communications protocol, eg. its
    hard to use the single interrupt to indicate various
    interrupt states, eg. target-to-host buffer has
    data versus host-to-target buffer has been emptied.
    Ideally AMCC should have implemented mailboxes and/or
    doorbell registers like any other sane PCI target
    device (eg. some the Freescale processors, or any of
    the PLX technologies chips).

2. Look in the data sheet and see if you can figure out
    how the host processor can generate an interrupt to
    the PowerPC core ... oops, you can't. That kind of
    makes it difficult to work with doesn't it.

    A work around would be to have the host write to the
    GPIO register and wire a GPIO pin back to an external
    interrupt pin. Then you would not be able to use any
    other GPIO pin in that GPIO register since there is
    no way to arbitrate host access versus PowerPC core
    access.

This was the other reason I ditched the AMCC part in
favor of the Freescale part.

If you are looking at other parts, make sure you look
in the PCI configuration space of the processor reference
manual. Many processors have the interrupt pin register
hardwired to zero, i.e., they can not be used as target
devices, only hosts. In that case you'd have to add an
intel 21555 non-transparent bridge to make the device
a target.

Cheers,
Dave
