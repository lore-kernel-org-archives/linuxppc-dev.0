From: tom_gall@mac.com
Date: Mon, 1 Dec 2003 08:09:54 -0600
Subject: Re: USB, 2.6-test11 and hot flaming death
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1070080961.683.26.camel@gaston>
Message-Id: <09B6571B-2408-11D8-970C-0003939E069A@mac.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Friday, November 28, 2003, at 10:43 PM, Benjamin Herrenschmidt wrote:

>
> On Sat, 2003-11-29 at 06:07, tom_gall@mac.com wrote:
>> Greets,
>>
>> I've seen this now with both test11 and test10 on Dual G5 hardware
>> with
>> the 32 bit kernel direct from the benh bk tree. I have seen this on
>> more than one G5 so I at least know it's not my hardware.
>>
>> Current pull of test11 and test10 will at boot up give the following
>> error messages :
>>
>> hid: probe of 4-1.1:1.1 failed with error -5
>> hub 4-1:1.0: hub_port_status failed (err = -108)
>> hub 4-1:1.0: hub_port_status failed (err = -108)
>> hub 4-1:1.0: hub_hub_status failed (err = -108)
>> hub 4-1:1.0: get_hub_status failed
>> hub 4-1:1.0: hub_port_status failed (err = -108)
>> hub 4-1:1.0: hub_port_status failed (err = -108)
>> hub 4-1:1.0: hub_port_status failed (err = -108)
>> hub 4-1:1.0: hub_hub_status failed (err = -108)
>> hub 4-1:1.0: get_hub_status failed
>> usb 4-1: USB disconnect, address 2
>> usb 4-1.1: USB disconnect, address 3
>
> This is new to test11 ?

Nope, effects test10 and test-11.

>  Can you find a specific patch that broke
> it or it's just a timing condition ? -108 is -ESHUTDOWN. Looking
> back in the log, the error actually comes from:
>
> It's 100% reproduceable ?

yes. I figured out what is doing it tho. Here's the skinny.

2.4.23 kernel - works fine with the white g5 keyboard
2.4.23 kernel - works fine with the older apple USB keyboard
(blue/blackish keys, silver-ish molding around the keys, translucent
plastic on the outside)

2.6.0-test10 - works fine with white g5 keyboard!
2.6.0-test10 - fails to work with the older apple USB keyboard
mentioned above

2.6.0-test11 - works fine with white g5 keyboard!
2.6.0-test11 - fails to work with the older apple USB keyboard
mentioned above

I'm kinda surprised this is specific to the older keyboard and 2.6 but
that does seem to be the case.

Haven't dived into the code at all, just thought I'd try the keyboard
swap this morning to see if that was it. (bummer, as I kind of like the
older keyboard more than the newer white ones)

Regards,

Tom

>
> ohci_hcd 0001:02:0b.0: OHCI Unrecoverable Error, disabled
> drivers/usb/input/hid-core.c: ctrl urb status -2 received
> ohci_hcd 0001:02:0b.0: HC died; cleaning up
> drivers/usb/input/hid-core.c: timeout initializing reports
>
> Hrm... We should try to reset the chip when that happens at least,
> dunno why it happened in the first place though. Maybe some PCI
> problem... What is the cache line size as shown by lspci for the
> OHCIs and the EHCI ?
>
> It's weird, it seems to indicate the chip just decided to die...
>
> Ben.
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
