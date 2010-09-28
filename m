Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
	[213.199.154.208]) by ozlabs.org (Postfix) with ESMTP id D6CA2B7123
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Sep 2010 04:47:25 +1000 (EST)
Received: from mail76-am1 (localhost.localdomain [127.0.0.1])	by
	mail76-am1-R.bigfish.com (Postfix) with ESMTP id 800B850577	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 28 Sep 2010 18:47:17 +0000 (UTC)
Received: from am1ehsmhs006.bigfish.com (unknown [10.3.201.242])	by
	mail76-am1.bigfish.com (Postfix) with ESMTP id 99A531C40143	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 28 Sep 2010 18:46:03 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8SIjvXM011196	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 28 Sep 2010 11:45:57 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o8SJ0aTO025393	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 14:00:37 -0500 (CDT)
Date: Tue, 28 Sep 2010 13:45:54 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: Parsing a bus fault message?
Message-ID: <20100928134554.323667e5@udp111988uds.am.freescale.net>
In-Reply-To: <20100928153153.GA22485@ovro.caltech.edu>
References: <2bef2051c143a8d6e619519b222016f9.squirrel@localhost>
	<20100928153153.GA22485@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: david.hagood@gmail.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 28 Sep 2010 08:31:54 -0700
"Ira W. Snyder" <iws@ovro.caltech.edu> wrote:

> On Tue, Sep 28, 2010 at 09:26:51AM -0500, david.hagood@gmail.com wrote:
> > Alternatively, can somebody see a hint in the message that I don't know
> > enough to pick out? At this point, my code is trying to memcpy() from the
> > PCIe bus (mapped via the outbound ATMU) to local memory, so the fault is
> > either a) the ATMU is not accessible b) the ATMU is accessible but not
> > mapped (which I would have thought the ioremap call I made would have
> > handled) or c) the chip is not able to bus master on the PCI bus.

Check the LAWs, the outbound ATMU, and the PCI device's BAR.  Make sure
the address goes where you're expecting at each level.

> > Machine check in kernel mode.
> > Caused by (from SRR1=149030): Transfer error ack signal
> 
> ^^^ this is the line that contains some critical info
> 
> In the 86xx CPU manual, you should be able to find information about the
> SRR1 register. Decoding the hex SRR1=0x149030 may help.
> 
> The kernel is telling you this is a TEA (transfer error acknowledge)
> error. I've only seen this when I get an unhandled timeout on the local
> bus. For example, a FPGA that has died in the middle of a request.

I've seen it when you access a physical address that has no device
backing it up.

> On the PCI bus, I haven't seen this error. The 83xx PCI controller is
> smart enough to return 0xffffffff when reading a non-existent device.

I believe that behavior is configurable.

-Scott
