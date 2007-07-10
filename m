Return-Path: <mikpe@user.it.uu.se>
Received: from aun.it.uu.se (aun.it.uu.se [130.238.12.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C04CDDDDFB
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 09:15:12 +1000 (EST)
Date: Wed, 11 Jul 2007 01:14:32 +0200 (MEST)
Message-Id: <200707102314.l6ANEWq2029195@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: albertl@mail.com, mikpe@it.uu.se
Subject: Re: [PATCH 1/1] libata: pata_pdc2027x PLL input clock fix
Cc: dwm@enoyolf.org, jeff@garzik.org, linux-ide@vger.kernel.org,
	bahadir.balban@gmail.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 10 Jul 2007 11:52:59 +0800, Albert Lee wrote:
> >>Recently the PLL input clock of pata_pdc2027x is sometimes detected
> >>higer than expected (e.g. 20.027 MHz compared to 16.714 MHz).
> >>It seems sometimes the mdelay() function is not as precise as it
> >>used to be. Per Alan's advice, HT or power management might affect
> >>the precision of mdelay().
> >>
> >>This patch calls gettimeofday() to mesure the time elapsed and
> >>calculate the PLL input clock accordingly.
> > 
> > 
> > Unfortunately this breaks pata_pdc2027x on my PowerMac G3:
> > 
> <snip>
> > 
> > In fairness, this is a slightly non-standard PowerMac G3, in that it
> > has a G4 upgrade processor. The firmware doesn't recognise the CPU
> > and gives some CPU core frequency-related properties too low values.
> > However, the bus frequency property _is_ correct, which is what
> > most or all timing stuff should be based on.
> > 
> > Looks like a platform bug.
> > 
> 
> According to the document, do_gettimeofday() has microsecond
> resolution. Since the driver calls mdelay(100) (100000 microseconds), 
> it won't affect the PLL input clock calculation much if somehow
> do_gettimeofday() drifts several (say 100) microseconds.
> 
> Could you please apply the attached debug patch and collect more info
> on the PowerMac G3. Hopefully we can have more clue. Thanks.
> --
> albert
> 
> (BTW, maybe opening a bug in bugzilla.kernel.org would help the
> debugging.)
> 
> --- 00_libata-dev/drivers/ata/pata_pdc2027x.c	2007-07-07 09:58:55.000000000 +0800
> +++ 01_debug/drivers/ata/pata_pdc2027x.c	2007-07-10 11:18:38.000000000 +0800
> @@ -722,6 +722,15 @@ static long pdc_detect_pll_input_clock(s
>  	pll_clock = (start_count - end_count) / 100 *
>  		(100000000 / usec_elapsed);
>  
> +	do_gettimeofday(&start_time);
> +	mdelay(37);
> +	do_gettimeofday(&end_time);
> +	usec_elapsed = (end_time.tv_sec - start_time.tv_sec) * 1000000 +
> +		(end_time.tv_usec - start_time.tv_usec);
> +	printk(KERN_ERR "usec_elapsed for mdelay(37) [%ld]\n", usec_elapsed);
> +	printk(KERN_ERR "start time: [%ld]s [%ld]us \n", start_time.tv_sec, start_time.tv_usec);
> +	printk(KERN_ERR "end   time: [%ld]s [%ld]us \n", end_time.tv_sec, end_time.tv_usec);
> +
>  	PDPRINTK("start[%ld] end[%ld] \n", start_count, end_count);
>  	PDPRINTK("PLL input clock[%ld]Hz\n", pll_clock);

2.6.22 + this prints the following on my G3:

pata_pdc2027x 0000:00:0e.0: version 0.9
usec_elapsed for mdelay(37) [35431]
start time: [1184112028]s [775333]us 
end   time: [1184112028]s [810764]us 
pata_pdc2027x 0000:00:0e.0: PLL input clock 1691741 kHz
pata_pdc2027x: Invalid PLL input clock 1691741kHz, give up!

/Mikael
