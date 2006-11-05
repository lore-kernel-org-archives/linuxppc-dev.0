Return-Path: <tnt@246tNt.com>
Message-ID: <454DF5E4.8050704@246tNt.com>
Date: Sun, 05 Nov 2006 15:32:04 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC] powerpc: Add MPC5200 Interrupt Controller support.
References: <454902F9.20206@bplan-gmbh.de>	<1162419138.25682.453.camel@localhost.localdomain>	<454A1C37.5050208@bplan-gmbh.de>	<454A5952.6090801@bplan-gmbh.de>	<1162683341.28571.82.camel@localhost.localdomain>	<20061105111753.3e41f6b7.nd@bplan-gmbh.de>	<1162723031.28571.228.camel@localhost.localdomain>	<20061105123101.3cc1696f.nd@bplan-gmbh.de>
	<1162731733.28571.241.camel@localhost.localdomain>
In-Reply-To: <1162731733.28571.241.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org, sl@bplan-gmbh.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>> As said, no option here. I think there is different way to see how works the PIC. However, from a register point of view. There is just critical, main, peripherals, SDMA.
>>
>> Loot at "ICTL Perstat, MainStat, MainStat, CritStat Encoded Register--MBAR + 0x0524"
>>     
>
> You should have your device-tree match your internal numbering. As you
> noticed, the CRIT interrupt and the EXT interrupts are just the same.
> And you properly folded them under the same level 1... now just make
> the device-tree expose the same informations.
>
> I don't care if you have firmwares in production or whatever... As a
> matter of fact, you guys have been working on this board for long enough
> you could have dealt with that issue long ago :-)
>
> So right now, what you should do is figure out a proper encoding for the
> firmware, and then either fix your device-tree, or do a hack in
> prom_init.c that fixes it up.
>   
I think Nicolas's choice makes sense.
The HW provides 4 registers which each contain the "number" of the IRQ that
happenned. And IRQ0 is encoded separatly from IRQ[1-3].

So when IRQ0 happens,  you really have a flag saying that a critical
interrupt
happenned, and when you look at the encoded critical interrupt number,
you get
"00" which is IRQ0.

If IRQ2 happend, the flag say a main interrupt happenned and when looking in
the encoded main interrupt number, we get "000001" which is IRQ2 ...

So the Hardware maps the hw IRQ number like this, so it makes sense to
use that mapping. Sure we could just not use that mapping and put IRQ0 hwirq
number just before IRQ1 but then the hack is just moved in get_irq and
we have
a numbering scheme which is not really what's in hw.


        Sylvain
