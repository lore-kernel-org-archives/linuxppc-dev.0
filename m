Return-Path: <alan@akb.net>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.237])
	by ozlabs.org (Postfix) with ESMTP id 0BB67DDDFA
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 06:05:48 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so1529784nzh
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 11:05:47 -0800 (PST)
Message-ID: <bfa0697f0711291105y2b13c4bcq27e504311c8eee4f@mail.gmail.com>
Date: Thu, 29 Nov 2007 12:05:45 -0700
From: "Alan Bennett" <embedded@akb.net>
Sender: alan@akb.net
To: "Vitaly Bordug" <vitb@kernel.crashing.org>
Subject: Re: Timers on mpc8248 etc...
In-Reply-To: <bfa0697f0711290550v57b28002s9f241094cdedeea6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <bfa0697f0711281541l31225d59ne78c8fe40286052e@mail.gmail.com>
	<474DFD15.603@freescale.com>
	<bfa0697f0711282006o235c987eg80732114e489befd@mail.gmail.com>
	<20071129143159.2538786d@kernel.crashing.org>
	<bfa0697f0711290550v57b28002s9f241094cdedeea6@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Though I'd like to move to a uboot fdt, I can't afford to port it yet,
maybe in January.  But until then ...

It appears that a simple change in U-boot constant,
   #define CONFIG_8260_CLKIN	66000000	/* in Hz */
   to
   #define CONFIG_8260_CLKIN	100000000	/* in Hz */

has fixed the speed mismatch, and I've verified that
schedule_timeout(HZ/10) produces a 100 millisecond delay.  However, my
serial ports (brgs) are hosed.

-Alan


On 11/29/07, Alan Bennett <embedded@akb.net> wrote:
> My uboot is new-ish, but I don't have the fdt commands?  U-Boot 1.3.0
> g992742a5-dirty
>
> u-boot:clock configuration
> ===========================
> MPC8248 Clock Configuration
>  - Bus-to-Core Mult 3.5x, VCO Div 2, 60x Bus Freq  30-85 , Core Freq 100-300
>  - dfbrg 1, corecnf 0x1e, busdf 3, cpmdf 1, plldf 0, pllmf 5, pcidf 5
>  - vco_out  396000000, scc_clk   99000000, brg_clk   24750000
>  - cpu_clk  231000000, cpm_clk  198000000, bus_clk   66000000
>
> Boot Wrapper Reporting
> ===========================
> Memory <- <0x0 0x8000000> (128MB)
> CPU clock-frequency <- 0xdc4c7c0 (231MHz)
> CPU timebase-frequency <- 0xfbc520 (17MHz)
> CPU bus-frequency <- 0x3ef1480 (66MHz)
>
> Kernel reporting
> ===========================
> clocksource: timebase mult[f26c9b2] shift[22] registered
>
> device tree in kernel (hex= `od -x`:
> ===========================
> /proc/device-tree/cpus/PowerPC,8248@0/name
>     PowerPC,8248
> /proc/device-tree/cpus/PowerPC,8248@0/bus-frequency
>     0000000 03ef 1480
> /proc/device-tree/cpus/PowerPC,8248@0/clock-frequency
>     0000000 0dc4 c7c0
> /proc/device-tree/cpus/PowerPC,8248@0/timebase-frequency
>     0000000 00fb c520
> /proc/device-tree/cpus/PowerPC,8248@0/i-cache-size
>     0000000 0000 4000
>
>
>
> On 11/29/07, Vitaly Bordug <vitb@kernel.crashing.org> wrote:
> > On Wed, 28 Nov 2007 21:06:36 -0700
> > Alan Bennett wrote:
> >
> > > It comes from uboot.  Can you point me in the right direction to make
> > > sure its right?
> > >                PowerPC,8248@0 {
> > >                        device_type = "cpu";
> > >                        reg = <0>;
> > >                        d-cache-line-size = <d#32>;
> > >                        i-cache-line-size = <d#32>;
> > >                        d-cache-size = <d#16384>;
> > >                        i-cache-size = <d#16384>;
> > >                        timebase-frequency = <0>;
> > >                        clock-frequency = <0>;
> > >                };
> > >
> > if your u-boot is up to  date, it will have fdt command, and by
> > fdt boardsetup
> > fdt print /
> >
> > inspect what u-boot did. Of course you should have dtb preloaded to memory and
> > fdt addr <offset> should be said to let u-boot know where dtb resides.
> >
> >
> > >
> > > On 11/28/07, Scott Wood <scottwood@freescale.com> wrote:
> > > > Alan Bennett wrote:
> > > > > I've got a routine that needs to delay for X microseconds, this
> > > > > is a must.  The command after schedule_timeout must has to wait
> > > > > for the HW to complete a task that takes X microseconds.
> > > > >
> > > > > I would think that one way to do this is with a simple
> > > > > schedule_timeout.  But in the example below, the time that passes
> > > > > from run1() to dontrun() is far less than 3.2 msecs.  Infact,
> > > > > sometimes its ~ 800 micros according the a analyzer looking at
> > > > > points triggered in run1() and donrun().  Could this be a
> > > > > configuration problem with the timer/interrupt that generates the
> > > > > jiffies?
> > > >
> > > > Are you sure the timebase frequency is set correctly in the device
> > > > tree?
> > > >
> > > > -Scott
> > > >
> > > _______________________________________________
> > > Linuxppc-dev mailing list
> > > Linuxppc-dev@ozlabs.org
> > > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >
> >
> > --
> > Sincerely, Vitaly
> >
>
