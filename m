Subject: Re: IRQ Level / Edge
From: Gary Thomas <gary@mlbassoc.com>
To: Sylvain Munaut <tnt@246tnt.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Andy Fleming <afleming@freescale.com>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <40E83EFD.8000309@246tNt.com>
References: <40E5D609.6090201@246tNt.com>
	 <DE336CD5-CC79-11D8-BA44-000393C30512@freescale.com>
	 <20040703164216.GA22998@pegasos>  <40E83EFD.8000309@246tNt.com>
Content-Type: text/plain
Message-Id: <1088963937.6277.405.camel@hermes>
Mime-Version: 1.0
Date: Sun, 04 Jul 2004 11:58:57 -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2004-07-04 at 11:31, Sylvain Munaut wrote:
>  >
>  > Err, i suppose the interesting bit is not how the board designer
>  > will know wheter the interrupt is edge or level, but how the kernel
>  > running on the board is able to detect it ?
>  >
>  > Friendly,
>
>
> Well, the kernel doesn't detect it. You have to tell him !
> That's why I asked, because in the interrupt controller code, you have
> to set it in the irq_desc[i] structure.

Indeed, the kernel *can't* detect this (at least not easily).  You have
to know how the device (chip, etc) works.  If it generates edge
interrupts, then typically it will only generate a small pulse and the
interrupt controller has to be set up to recognize this.  For edge
interrupts, you normally only care about either a "falling" edge (the
transition from logic high to logic low) or "rising" edge (low to high).
It is then up to the device driver to tell the device to generate the
next interrupt as part of the interrupt service.  Most devices will not
generate another edge until the current one has been "cleared" or
"acknowledged."

If it is a level interrupt, then the device will assert its interrupt
signal until told to remove it (by the device driver).  In this case,
it is important for the interrupt controller to be aware that this
signal may persist (it's a level) and only tell the CPU about it
once.  In this case, the driver needs to tell the interrupt controller
when it has serviced the interrupt so that it will recognize when
the device re-asserts its interrupt signal.

n.b. this assumes that the interrupt controller is behaving like an
edge itself, i.e. it only interrupts the CPU once per state change.

--
Gary Thomas <gary@mlbassoc.com>
MLB Associates


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
