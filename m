Subject: Re: nearly-working support for cpufreq on 2004 iBook G4 with 7447A
	cpu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Steele Scott <toojays@toojays.net>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Christiaan Welvaart <cjw@daneel.dyndns.org>
In-Reply-To: <200405311807.59356.toojays@toojays.net>
References: <200405302331.35357.toojays@toojays.net>
	 <200405311003.21439.toojays@toojays.net> <1085975390.1930.31.camel@gaston>
	 <200405311807.59356.toojays@toojays.net>
Content-Type: text/plain
Message-Id: <1086046859.9638.70.camel@gaston>
Mime-Version: 1.0
Date: Tue, 01 Jun 2004 09:41:00 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2004-05-31 at 18:37, John Steele Scott wrote:
>
> On Mon, 31 May 2004 01:19 pm, Benjamin Herrenschmidt wrote:
> > Ok, that's weird, I don't see the same kind of clock chip on i2c as
> > the previous model had... Can you check the exact dividers programmed
> > on the CPU and redo the calculation based on the bus frequency ?
>
> Okay.
>
> At boot: HID1=80414c80 => PLL_CFG=10100, i.e. 4:1 core multiplier
>
> After clearing DFS, HID1=80018c80 => PLL_CFG=11000, i.e. 8:1 core multiplier
>
> I decoded the PLL values using the table on page 31 of Moto's MPC7447AEC.pdf.
>
> bash-2.05b$ cat /proc/device-tree/clock-frequency  | xxd
> 0000000: 07ef 4679                                ..Fy
> bash-2.05b$ python -c 'print "%d" % 0x07ef4679'
> 133121657
>
> Looks sensible to me. Does it give you any clues?

Not sure at this point, play with DFS during boot and see what bogomips
you get maybe...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
