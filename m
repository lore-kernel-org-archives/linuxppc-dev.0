Message-ID: <41235193.4020906@246tNt.com>
Date: Wed, 18 Aug 2004 14:54:43 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: Stefano Gaiotto <Stefano.Gaiotto@marconi.com>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCI scanning and devices initialization
References: <OF8D823500.2A30CF0C-ONC1256EF4.0040DDB4@uk.marconicomms.com>
In-Reply-To: <OF8D823500.2A30CF0C-ONC1256EF4.0040DDB4@uk.marconicomms.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stefano Gaiotto wrote:

>Dear colleagues,
>
>I'm trying to use a device connected to a PCI bus, more exactly a
>PCI/PCMCIA bridge
>with u-boot-1.1.1 and Linux (2.4.24 and 2.6.8) in a board with MPC8270.
>
>Both u-boot and Linux, during scanning procedure show me only the PCI
>bridge [1057/18c0] but I can't see the devices connected to the bus.
>
>I'm a novice with PCI bus and I'm not sure the board is good (is the first
>prototype) and so I'd like to know if scanning procedure should tell me the
>devices
>connected or I have to do some device initialization before I can see them
>during scanning.
>
>I suppose I should see them during scanning and then initialise them via
>PCI bus.
>
>If my assumption is true, shall I suppose my hardware is not good? Or
>anything else?
>
>
Hi

Yes, there may be something wrong with your hardware. I'm not familiar
with the MPC8270 PCI code but your devices should show up during scan.

At the PCI init, PCI devices don't yet have an address, so the host
detects them using configuration cycles. Theses uses a different
addressing scheme, using each address line as a kind of "chip select".
So the devices know the host is "talking" to it just by looking at it's
IDSEL line going asserted. If on your board the IDSEL isn't wired
properly then it won't work. Hopefully if that's the case, you can just
wire it by hand, it's not a high speed signal.

Also, I've come accross some simple FPGA implementation of PCI devices
that just didn't respond to config ...


Sylvain


PS: I'm not a PCI expert and that's just my understanding. There is
probably a lot of things that can go wrong.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
