From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Uwe Steinmann <steinm@majestix.fernuni-hagen.de>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Again PCMCIA problems
Date: Wed, 12 Dec 2001 15:44:14 +0100
Message-Id: <20011212144414.7330@smtp.adsl.oleane.com>
In-Reply-To: <20011212140119.A12086@gehtnix.fernuni-hagen.de>
References: <20011212140119.A12086@gehtnix.fernuni-hagen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>include memory 0x90000000-0x90ffffff
>include port 0x0fff-0x1fff

Some cards wants ports below 0xfff, and make sure the
memory range you provide is actually available
(do a cat /proc/iomem to check that). If the memory
is allocated to cardbus (which happens on some machines
which pre-configure the cardbus bridge from OF), it will
not be userable by pcmcia

I'd also suggest you update your kernel as some pcmcia
fixes were lost around 2.4.16 and recovered later during
2.4.17-pre cycle, yours may still lack them.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
