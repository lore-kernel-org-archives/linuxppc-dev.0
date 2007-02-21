Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 104A8DDD0D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Feb 2007 02:21:35 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: understanding an IO question
Date: Wed, 21 Feb 2007 07:21:33 -0800
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A166@MERCURY.inside.istor.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
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


You have to use ioremap() to get TLB and page mappings for any IO.  =20
We setup some initial kernel mappings to allow access to system =20
memory but thats it.  Everything else should go through some mapping =20
function.

> 2. "Are Outbound Address Translation windows reset by the arch/ppc/...
> Linux initialization and if so, where. If they are reset, where is the
> best place to put them back to the state I had set them up in uboot.

Nope, currently the address translation windows at the system level =20
are not touched by arch/ppc (unless done in your own code).

Have you tried plain old ioremap() [not _nocached] ?

Dear Kumar:

I hope all is well with you and I appreciate your taking time to have a
mini-dialog with me today.

Here's the deal. First of all, we are using the linux-2.6.17.11 code
base from kernel.org, which was the latest one when this project
started. We have validated that our driver, with no modifications, works
fine on our existing production 8241 board with this kernel. This driver
does use ioremap_nocache(), request_region() and other common
driver-type calls, so I suspect the issue is the kernel is not setup
quite right for the driver, not that the driver needs modification for
the kernel.

Starting from that premise, I know that we depend on outbound address
translation windows and any necessary TLB setup to get access to the CPU
address region around 0x8400_0000.=20

The reason for the outbound address translation windows has to do with
the fact that we use a DAC (Dual Address Cycle) to a 64bit PCI address
at 0x1_0000_0000 or 0x3_0000_0000 depending on whether we are
writing/reading to the window at 0x8800_0000 or 0x8400_0000.

One thing that puzzles me is that a 'cat /proc/iomem' shows a PCI window
is setup in Linux, like this

>> cat /proc/iomem
>> 80000000-9fffffff : PCI1 host bridge

I don't see anywhere in the Linux-2.6.17.11 code base where this window
is setup. Perhaps you could point me towards the section of code where
this is done.

On the ioremap()/ioremap_nocache() issue. I did look at the source in
the kernel for ioremp_nocache() and it is #defined to be ioremap(), so I
think it is safe to assume they are the same.

Charles
