In-Reply-To: <v04220800b4e5212c2027@[10.0.0.42]>
Date: Fri, 3 Mar 2000 12:09:00 +0100
To: "Timothy A. Seufert" <tas@mindspring.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Need reports about PCI I/O conflicts
Message-Id: <20000303120900.024672@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 3, 2000, Timothy A. Seufert <tas@mindspring.com> wrote:

No need for more lspci from you now, or eventually just send me what you
already sent, but without running Michel Lanners patch this time.

>>It does this by writing 0 in the io space register, but
>>doesn't disable IO accesses to the card in the PCI config header (or
>>maybe they get re-enabled by the kernel fixup code).
>
>I think the fixup code is re-enabling it if it can:
>
>   PCI: setting IRQ 24 on device 01:18.
>   PCI: Correcting IOaddress 0 on device 01:18, now fe000001.
>   PCI: Enabling I/O for device 01:18
>   PCI: setting IRQ 25 on device 01:20.
>   PCI: Correcting IOaddress 0 on device 01:20, now fe000001.
>   PCI: Correcting IOaddress 0 on device 01:21, now fe000001.
>
>01:18 is the 2940UW, 01:20 and 01:21 the two channels of the 39160.
>
>I remember looking at the code which enables I/O for a device, but it
>wasn't clear to me at that time how it decided whether to enable I/O.

My understanding for now is that the fixup code thinks the cards are
assigned IO address 0, not that they are disabled. So it does the fixup
of the pointer, but doesn't looks for a free io range. Could you check
if, before entering the fixup code, bit 0 of the IO base register is
actually 0 or 1 ? (If the register contains really 0x00000000 or
0x00000001). The first case would mean a disabled and non-assigned BAR,
the second would mean a valid BAR assigned to address 0.

Also, if you have it, please send me Michel patches as I didn't find them
on his page.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
