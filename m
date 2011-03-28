Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 5/5] xhci: Remove recursive call to xhci_handle_event
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
In-Reply-To: <20110328223424.GF8065@xanatos>
References: <4D8C47D8.4020901@ozlabs.org> <4D8C8F2B.9090808@ru.mvista.com>
	<4D90142C.4050206@ozlabs.org>  <20110328223424.GF8065@xanatos>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 29 Mar 2011 10:58:54 +1100
Message-ID: <1301356734.2402.657.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
	Sergei Shtylyov <sshtylyov@mvista.com>, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-03-28 at 15:34 -0700, Sarah Sharp wrote:
> 
> What I'd like to do is take out the read of the status register out of
> the interrupt handler (which is killing performance), and make it only
> check the status register when xhci_handle_event() returns a negative
> error status.  If the status register shows the host controller has a
> critical error, the driver should call usb_hcd_died().

Be careful with removing that read...

Without MSIs, that read is what guarantees that all pending DMA writes
by the xHCI have been "flushed" before you start poking at memory.

IE. If the chip writes an event and sends an LSI, without that read, you
might get the interrupt before the writes to memory have completed and
your driver will "miss" the event.

With MSIs (provided they are not broken on your PCI host bridge of
course, this is typically the #1 cause of MSI breakage), you don't need
that as the MSI itself is a DMA store by the device which is ordered
after the stores done to update the event. So by the time you get the
MSI interrupt, you -should- have all the updates visible in memory.

But that means that your PCI host bridge is doing the right thing, by
ensuring whatever queues to the coherency domain it has have been
properly flushed before it signals the interrupts caused by the MSI to
the processors. Hopefully most systems get that right nowadays.

Point is: you need to keep that read if MSIs aren't enabled.

Cheers,
Ben.
