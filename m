Return-Path: <matt@ozlabs.org>
Message-ID: <4D914136.9030109@ozlabs.org>
Date: Tue, 29 Mar 2011 13:17:26 +1100
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [PATCH 2/5] xhci: Extend debug messages
References: <4D8C47BF.8010701@ozlabs.org> <20110328221931.GC8065@xanatos>
In-Reply-To: <20110328221931.GC8065@xanatos>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 29/03/11 09:19, Sarah Sharp wrote:
> On Fri, Mar 25, 2011 at 06:43:59PM +1100, Matt Evans wrote:
>> Add more debug to print queued transfers, show control intentions and
>> modify an existing message to hexify address output.
> 
> Are these new debug messages really necessary?  I feel like the xHCI
> driver has way too many debugging messages already.  I'd like to switch
> it over to the event tracer infrastructure eventually, and every new
> debug message makes that work harder to do...
> 
> The queue_trb debug message is going to be especially noticeable, since
> it will be triggered on every URB submission (sometimes more than once
> per URB).

My rationale was that when looking out for control transfers, the actual
transfer was the one line of info *not* printed at that point (among about a
trillion of ring/buffer state). :) I didn't know about the event tracer
intentions, so if this'll complicate things I'll drop it from the series, no
worries.

Cheers,


Matt

> 
> Sarah Sharp
> 
>> Signed-off-by: Matt Evans <matt@ozlabs.org>
>> ---
>>  drivers/usb/host/xhci-dbg.c  |    2 +-
>>  drivers/usb/host/xhci-hub.c  |    3 +++
>>  drivers/usb/host/xhci-ring.c |    5 +++++
>>  3 files changed, 9 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/usb/host/xhci-dbg.c b/drivers/usb/host/xhci-dbg.c
>> index 2e04861..905f3bf 100644
>> --- a/drivers/usb/host/xhci-dbg.c
>> +++ b/drivers/usb/host/xhci-dbg.c
>> @@ -278,7 +278,7 @@ void xhci_debug_trb(struct xhci_hcd *xhci, union xhci_trb *trb)
>>  		 * FIXME: look at flags to figure out if it's an address or if
>>  		 * the data is directly in the buffer field.
>>  		 */
>> -		xhci_dbg(xhci, "DMA address or buffer contents= %llu\n", address);
>> +		xhci_dbg(xhci, "DMA address or buffer contents= 0x%llx\n", address);
>>  		break;
>>  	case TRB_TYPE(TRB_COMPLETION):
>>  		address = le64_to_cpu(trb->event_cmd.cmd_trb);
>> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
>> index ae1d24c..768fd6e 100644
>> --- a/drivers/usb/host/xhci-hub.c
>> +++ b/drivers/usb/host/xhci-hub.c
>> @@ -389,6 +389,9 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>>  	}
>>  	bus_state = &xhci->bus_state[hcd_index(hcd)];
>>  
>> +	xhci_dbg(xhci, "%s(%04x, %04x, %04x, %p, %04x);\n", __func__,
>> +		 typeReq, wValue, wIndex, buf, wLength);
>> +
>>  	spin_lock_irqsave(&xhci->lock, flags);
>>  	switch (typeReq) {
>>  	case GetHubStatus:
>> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
>> index 3898f22..45f3b77 100644
>> --- a/drivers/usb/host/xhci-ring.c
>> +++ b/drivers/usb/host/xhci-ring.c
>> @@ -2336,6 +2336,11 @@ static void queue_trb(struct xhci_hcd *xhci, struct xhci_ring *ring,
>>  	trb->field[1] = cpu_to_le32(field2);
>>  	trb->field[2] = cpu_to_le32(field3);
>>  	trb->field[3] = cpu_to_le32(field4);
>> +
>> +	xhci_dbg(xhci, "queue_trb @%llx %08x %08x %08x %08x\n",
>> +		 xhci_trb_virt_to_dma(ring->enq_seg, ring->enqueue),
>> +		 le32_to_cpu(trb->field[0]), le32_to_cpu(trb->field[1]),
>> +		 le32_to_cpu(trb->field[2]), le32_to_cpu(trb->field[3]));
>>  	inc_enq(xhci, ring, consumer, more_trbs_coming);
>>  }
>>  
>> -- 
>> 1.7.0.4
>>
