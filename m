Subject: Re: mv6360 support in mv64x60.c (was Re: GT64260_eth (Ethernet)
	Driver)
From: David Woodhouse <dwmw2@infradead.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linux-emb <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <40E1E94B.9060204@mvista.com>
References: <40E1E94B.9060204@mvista.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1088691201.14216.2977.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Thu, 01 Jul 2004 15:13:21 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


More progress... the IRQ code works a bit better if it's ic_bh->v_addr
is at offset zero in the chip instead of the 0xc18 which is correct only
for the GT64260. The host bridge itself appears on the bus as device #3,
which is why we couldn't autodetect it by looking at vendor/device of
device #0.

∃ an Ethernet driver for the MV64340 (the MIPS version of the chip). It
doesn't use OCP though -- there's no OCP on MIPS. Can someone explain
why OCP is used instead of the generic platform_device functionality
provided by the kernel? Should we convert MIPS to OCP?

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
