Date: Fri, 15 Feb 2002 21:40:44 -0500
Subject: Weird bug problems with timing of NIC driver loading?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v480)
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
In-Reply-To: <416D9C76-201E-11D6-BE69-0003938E434C@ivey.uwo.ca>
Message-Id: <9382917A-2286-11D6-9EE3-0003938E434C@ivey.uwo.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have a weird bug report I need some help tracking down:

With both the G3 using either tulip or  bmac NICs and the new G4 using
Sungmem I can reliably and repeatedly show funky net behavior when those
drivers are compiled in or loaded early in the boot process as modules.

This behavior is funny in that ifconfig shows no errors and that packets
are being sent and received (and the lights on the cards seem to support
that) but none of the received info ever seems to make it back upstream
from the card (a receive buffer alignment issue?)

This is repeatable with both machines and with BMAC, TULIP, and SUNGEM
when compiled in or loaded as a module during the normal eth0
initialization during bootup

If I simply compile them as modules and wait until the machine is up and
simply do an insmod and configure the network, they ALL work absolutely
perfectly.

So whatever the issue is, it seems to be related to when in the boot
process the NIC code is invoked.

Is this due to some change in memory mapping?
Is this due to some  change in IRQ assignment?
Is this due to some alignment issue with DMA buffers and memory / caches?

So what is different when a module is loaded by modprobe during the eth0
initialization during bootup versus waiting until the end and then
running insmod to load the module and configure the network.

Just to check I made sure there were no firewall modules loaded at all
and that the network routing tables and things were set properly
(identical to the hand done case at the end of boot-up).

This problem seems to exist in every 2.4.X kernel I have tried.

This problem does not exist in 2.2.X kernels.

Ideas anyone?

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
