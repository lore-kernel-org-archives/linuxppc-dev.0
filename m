Return-Path: <david.hagood@gmail.com>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 6539BB70DE
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Sep 2010 01:55:43 +1000 (EST)
Received: by gwb19 with SMTP id 19so374236gwb.15
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Sep 2010 08:55:41 -0700 (PDT)
Received: from localhost (Deathwish [127.0.0.1])
	by Deathwish.hagood.sktc.net (Postfix) with ESMTP id 49CE9C7B8042
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Sep 2010 10:55:38 -0500 (CDT)
Message-ID: <08f8439b89ad5771221aaba1cee86fc4.squirrel@localhost>
Date: Wed, 22 Sep 2010 10:55:38 -0500
Subject: MPC8641D PEX: programming OWBAR in Endpoint mode?
From: david.hagood@gmail.com
To: linuxppc-dev@ozlabs.org
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

I am trying to get the PCIe interfaces of a Freescale MPC8641D working in
endpoint mode (i.e. as a PCI device rather than a PCI root complex host).

I can get the device to show up on the host's PCI bus, I can program the
inbound ATMUs such that the BARS are updated when the host (re-)scans
them, but I cannot for the life of me get the PPC's Outbound ATMUS to
work.

When I attempt to program them, I can program ALL the registers EXCEPT the
OWBAR - which steadfastly remains 0 no matter what I write to it.

As a result, when I attempt to bus master out from the PPC to the PCIe
address spaces via the outbound ATMUs, I get a bus fault on the PPC as
there is no device at the address I am accessing.

I've double-checked the LAWs to make sure the PEX is mapped into local
space, I've put the OWBAR in that address space, I've tried different
outbound ATMUs, and NOTHING works. Not ATMU0, not ATMU1, etc.

I've been trying to work with our Freescale rep, but I am getting nowhere
on that front.

Does anybody have any suggestions on what I might be doing wrong? I mean,
it looks like it should be a simple out_be32(addr_of_OWBAR,value), just
like all the other accesses to the ATMU registers that seem to be working
(as in, I read back what I wrote).
