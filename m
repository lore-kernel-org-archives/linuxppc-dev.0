Subject: Re: USB, 2.6-test11 and hot flaming death
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: tom_gall@mac.com
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1B4D801D-21D6-11D8-970C-0003939E069A@mac.com>
References: <1B4D801D-21D6-11D8-970C-0003939E069A@mac.com>
Content-Type: text/plain
Message-Id: <1070080961.683.26.camel@gaston>
Mime-Version: 1.0
Date: Sat, 29 Nov 2003 15:43:19 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2003-11-29 at 06:07, tom_gall@mac.com wrote:
> Greets,
>
> I've seen this now with both test11 and test10 on Dual G5 hardware with
> the 32 bit kernel direct from the benh bk tree. I have seen this on
> more than one G5 so I at least know it's not my hardware.
>
> Current pull of test11 and test10 will at boot up give the following
> error messages :
>
> hid: probe of 4-1.1:1.1 failed with error -5
> hub 4-1:1.0: hub_port_status failed (err = -108)
> hub 4-1:1.0: hub_port_status failed (err = -108)
> hub 4-1:1.0: hub_hub_status failed (err = -108)
> hub 4-1:1.0: get_hub_status failed
> hub 4-1:1.0: hub_port_status failed (err = -108)
> hub 4-1:1.0: hub_port_status failed (err = -108)
> hub 4-1:1.0: hub_port_status failed (err = -108)
> hub 4-1:1.0: hub_hub_status failed (err = -108)
> hub 4-1:1.0: get_hub_status failed
> usb 4-1: USB disconnect, address 2
> usb 4-1.1: USB disconnect, address 3

This is new to test11 ? Can you find a specific patch that broke
it or it's just a timing condition ? -108 is -ESHUTDOWN. Looking
back in the log, the error actually comes from:

It's 100% reproduceable ?

ohci_hcd 0001:02:0b.0: OHCI Unrecoverable Error, disabled
drivers/usb/input/hid-core.c: ctrl urb status -2 received
ohci_hcd 0001:02:0b.0: HC died; cleaning up
drivers/usb/input/hid-core.c: timeout initializing reports

Hrm... We should try to reset the chip when that happens at least,
dunno why it happened in the first place though. Maybe some PCI
problem... What is the cache line size as shown by lspci for the
OHCIs and the EHCI ?

It's weird, it seems to indicate the chip just decided to die...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
