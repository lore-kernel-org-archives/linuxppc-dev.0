Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 80660B7BBF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 18:43:04 +1100 (EST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 05/13] powerpc/5200: LocalPlus driver: fix DMA TX
	interrupt request
References: <200912081339.50722.roman.fietze@telemotive.de>
	<200912220802.50090.roman.fietze@telemotive.de>
	<fa686aa40912212320v27c22752wbf63f1d2d4b61129@mail.gmail.com>
In-Reply-To: <fa686aa40912212320v27c22752wbf63f1d2d4b61129@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <200912220842.58512.roman.fietze@telemotive.de>
Date: Tue, 22 Dec 2009 08:42:58 +0100
Content-Type: Text/Plain;
  charset="iso-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Grant,

On Tuesday 22 December 2009 08:20:16 Grant Likely wrote:

> Is this really what you want? In the TX path, it is the FIFO irq
> that indicates the transfer is complete (ie, the DMA fills the FIFO
> and finishes before the FIFO has drained). If both irqs were
> enabled, then the DMA irq would fire first, followed by the FIFO
> irq. For the use cases I was dealing with, the next transfer cannot
> be kicked off until the FIFO has drained.

I added another patch (PATCH 10/13) that takes care of this problem.
Debugging output (some tiny printk's when I detected the "abnormal"
case) showed, that when receiving data one cannot predict the order of
the the SDMA and SCLPC interrupt, esp. when e.g. the BestComm has
other tasks with higher prio running, in my case ATA+FEC. I hope I
didn't kill the TX side with this change, because, as I said, could
not yet test it.

Two possible solutions came into my mind:

1) let the SDMA interrupts run freely in parallel and just use the
SCLPC interrupt to detect a finished transaction.

2) Always wait for both, the second one defined the end of the
transaction. IMHO some waste of time.

> In the RX path, the DMA irq indicates that the transfer is complete
> (ie, the localbus fills the FIFO and finishes before the DMA drains
> the FIFO.

See above. That's not always true as stress tests showed. I had cases
where the BestComm was second. The SDMA beeing first is almost always
true for non BD tasks (there is one available in the 2.4.25, but not
in the 2.6 yet), and is mostly true even with BD tasks, but not 100%.

> For my use cases, the RX DMA irq was always required, but the TX DMA
> irq was never needed.

Unloading the module caused an oops when I did not request the TX SDMA
IRQ. Have to check that again.


> Does your use case differ?

I'm currently using your modified lpc test driver and I am currently
in the process of porting a 2.4.25 MOST150 FPGA driver to 2.6 using
the platform LPC driver. As soon as I have results using the FPGA
driver (very high load) I will come back with the results or probably
further patches.

One of them might be increasing the number of BDs again, because the
BestComm seems to take some time until it gives them back to the
world, and then sometimes in batches. I had a similar problem on a
high speed SPI link using the BestComm.


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
