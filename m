From: hollis@austin.ibm.com
Date: Tue, 4 Dec 2001 09:46:00 -0600
To: linuxppc-dev@lists.linuxppc.org
Cc: David Monro <davidm@amberdata.demon.co.uk>,
	Mathias von Essen <matthias.vonessen@metagmbh.de>,
	Sven Dickert <Sven.Dickert@planb.de>
Subject: patch: i8259.c & PCI int ack
Message-ID: <20011204094600.K421@austin.ibm.com>
References: <20011203160923.H421@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011203160923.H421@austin.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Dec 03, 2001 at 04:09:23PM -0600, hollis@austin.ibm.com wrote:
>
> - i8259_irq has been renamed to i8259_poll
> - a new i8259_irq has been added, which uses the PCI int ack address
> - both i8259_irq and i8259_poll are no longer passed the unused 'int cpu'
> - i8259_init now takes a 'long intack_addr', which on PReP is 0xbffffff0.
>   For platforms that only poll, this argument is irrelevant and can be 0x0
> - IO resources 0x20-0x21, 0xA0-0xA1, and 0x4D0-0x4D1 are now reserved
> - ISR selection is done once at initialization rather than on every irq
>
> This patch works on my (PReP) PowerSeries 830 and fixes the interrupt death
> problems I and others have seen.
>
> If this is the right idea, I intend to change all 8259 users:
> - ppc_md.get_irq = i8259_irq       ->   ppc_md.get_irq = i8259_poll
> - i8259_init()                     ->   i8259_init(0x0)
> - i8259_irq(smp_processor_id())    ->   i8259_poll()

Here is the complete patch. I have not compile-tested all N embedded targets.
The only arch actually using i8259_irq (rather than i8259_poll) right now is
PReP. From the last 8259 thread, I think all current boards *could* use it if
they wanted to.

I noticed that quite a few boards have code like this:
	/* Resolves the open_pic.c build without including i8259.c */
	int i8259_irq(int cpu)
	{
		return 0;
	}
That and the #ifndef CONFIG_GEMINI (maybe Gemini should have a dummy function
too to remove #ifdefs) suggests there's something wrong with open_pic.c, but I
guess everyone already knows that.

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
