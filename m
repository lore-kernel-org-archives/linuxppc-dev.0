Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx009.isp.belgacom.be (outmx009.isp.belgacom.be
	[195.238.5.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A8F47689F3
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Feb 2006 01:34:10 +1100 (EST)
Received: from outmx009.isp.belgacom.be (localhost [127.0.0.1])
	by outmx009.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k17EXtH5016643
	for <linuxppc-embedded@ozlabs.org>; Tue, 7 Feb 2006 15:33:56 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: Mike Rapoport <mike@compulab.co.il>
Subject: Re: CPM2 USB driver & MPC8248
Date: Tue, 7 Feb 2006 15:33:58 +0100
References: <200602031210.12603.laurent.pinchart@tbox.biz>
	<200602071414.28551.laurent.pinchart@tbox.biz>
	<43E8ACB3.6030401@compulab.co.il>
In-Reply-To: <43E8ACB3.6030401@compulab.co.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200602071533.58965.laurent.pinchart@tbox.biz>
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

> The driver development is stalled and I don't know when I'll be able to
> continue working on it.

Bad news, but I do understand. Please inform me when you will resume working 
on the driver, so that I can inform you of the progress I will have made (if 
any).

> >What are the major performance issues ?
>
> One of the issues in this driver is redunduncy between qe end ep
> structures and as a consequence a lot of uneeded code that make cross
> updates.
> I didn't run profiling, so I can't tell better.

Ok.

> >I noticed that the driver uses the MPC82xx packet level interface.
> >Why don't you use the transaction level interface ?
>
> The original driver I've started with used packet level. I thought on
> switching to transaction level, but I hadn't time for it because of
> other projects pressure.

Do you think it would be worth it, or are there any issue which you are aware 
of that would make it difficult/impractical/impossible/useless ?

> >That might explain why some devices don't even respond to the first
> > request. I noticed that, on my EP8248 board, the controller only sends
> > 990 SOF packets per second (or rather 990 SOF interrupts are generated).
> > I might have a time base problem somewhere, as I computed the number of
> > interrupts per second with a simple
> >
> >cat /proc/driver/m8xxhci_privateh > sof.1 && sleep 300 &&
> >cat /proc/driver/m8xxhci_privateh > sof.2
>
> I'm not sure such measurements are correct, since you sleep not exatly
> 300 seconds. I haven't measured how many SOF interrupts I get, but I
> think you maybe right.
> It may happen that during transmit or recieve the interrupts are off and
> SOF packets are not sent.

My bad, this was caused by the boot loader passing 66000000Hz instead of 
66666666Hz to Linux as the bus frequency. This is fixed now, and I get 1000 
SOF interrupts per second.

> >Do you have the same problem ? I'll see if I can get my hands on a USB
> >protocol analyzer.
>
> Good luck, I'll try to help but unfotunately I'm very much busy with
> other projects now.

Thanks for your help already.

Laurent Pinchart
