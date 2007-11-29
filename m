Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F0D00DDE06
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 22:32:26 +1100 (EST)
Date: Thu, 29 Nov 2007 14:31:59 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: "Alan Bennett" <embedded@akb.net>
Subject: Re: Timers on mpc8248 etc...
Message-ID: <20071129143159.2538786d@kernel.crashing.org>
In-Reply-To: <bfa0697f0711282006o235c987eg80732114e489befd@mail.gmail.com>
References: <bfa0697f0711281541l31225d59ne78c8fe40286052e@mail.gmail.com>
	<474DFD15.603@freescale.com>
	<bfa0697f0711282006o235c987eg80732114e489befd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 28 Nov 2007 21:06:36 -0700
Alan Bennett wrote:

> It comes from uboot.  Can you point me in the right direction to make
> sure its right?
>                PowerPC,8248@0 {
>                        device_type = "cpu";
>                        reg = <0>;
>                        d-cache-line-size = <d#32>;
>                        i-cache-line-size = <d#32>;
>                        d-cache-size = <d#16384>;
>                        i-cache-size = <d#16384>;
>                        timebase-frequency = <0>;
>                        clock-frequency = <0>;
>                };
>
if your u-boot is up to  date, it will have fdt command, and by
fdt boardsetup
fdt print /

inspect what u-boot did. Of course you should have dtb preloaded to memory and
fdt addr <offset> should be said to let u-boot know where dtb resides.


> 
> On 11/28/07, Scott Wood <scottwood@freescale.com> wrote:
> > Alan Bennett wrote:
> > > I've got a routine that needs to delay for X microseconds, this
> > > is a must.  The command after schedule_timeout must has to wait
> > > for the HW to complete a task that takes X microseconds.
> > >
> > > I would think that one way to do this is with a simple
> > > schedule_timeout.  But in the example below, the time that passes
> > > from run1() to dontrun() is far less than 3.2 msecs.  Infact,
> > > sometimes its ~ 800 micros according the a analyzer looking at
> > > points triggered in run1() and donrun().  Could this be a
> > > configuration problem with the timer/interrupt that generates the
> > > jiffies?
> >
> > Are you sure the timebase frequency is set correctly in the device
> > tree?
> >
> > -Scott
> >
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


-- 
Sincerely, Vitaly
