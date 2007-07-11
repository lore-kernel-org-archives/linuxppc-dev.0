Return-Path: <mikpe@user.it.uu.se>
Received: from aun.it.uu.se (aun.it.uu.se [130.238.12.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 073E3DDDFE
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 20:26:31 +1000 (EST)
Date: Wed, 11 Jul 2007 12:26:05 +0200 (MEST)
Message-Id: <200707111026.l6BAQ5kh003472@harpo.it.uu.se>
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

On Wed, 11 Jul 2007 10:45:35 +0800, Albert Lee wrote:
> Mikael Pettersson wrote:
> > 
> > 
> > 2.6.22 + this prints the following on my G3:
> > 
> > pata_pdc2027x 0000:00:0e.0: version 0.9
> > usec_elapsed for mdelay(37) [35431]
> > start time: [1184112028]s [775333]us 
> > end   time: [1184112028]s [810764]us 
> > pata_pdc2027x 0000:00:0e.0: PLL input clock 1691741 kHz
> > pata_pdc2027x: Invalid PLL input clock 1691741kHz, give up!
> > 
> 
> My x86 box got this:
> Jul 11 10:02:17 p4ht-s kernel: [  260.746980] ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNK1] -> GSI 10 (level, low) -> IRQ 10
> Jul 11 10:02:17 p4ht-s kernel: [  260.882905] usec_elapsed for mdelay(37) [36734]
> Jul 11 10:02:17 p4ht-s kernel: [  260.882911] start time: [1184119336]s [999802]us 
> Jul 11 10:02:17 p4ht-s kernel: [  260.882914] end   time: [1184119337]s [36536]us 
> Jul 11 10:02:17 p4ht-s kernel: [  260.882917] pata_pdc2027x 0000:02:05.0: PLL input clock 16829 kHz
> 
> So, it seems both mdelay(37) and do_gettimeofday() are working properly on PowerMac G3.
> Maybe the calculated wrong PLL input is due to wrong reading of the counter register?
> Could you please try the attached debug patch for more clue, thanks.

This, supposedly debug-only, patch gives me much better PLL calibration:

pata_pdc2027x 0000:00:0e.0: version 0.9
bccrh [0] bccrl [0]
bccrhv[0] bccrlv[0]
bccrh [7FCF] bccrl [15ED]
bccrhv[7FCF] bccrlv[15D4]
start[0] end[1072141805] 
usec_elapsed for mdelay(100) [105500]
start time: [1184152411]s [689475]us 
end   time: [1184152411]s [794975]us 
PLL input clock[-1563248254]Hz
usec_elapsed for mdelay(37) [35432]
start time: [1184152411]s [818033]us 
end   time: [1184152411]s [853465]us 
bccrh [7FC9] bccrl [1A4B]
bccrhv[7FC9] bccrlv[1A4B]
bccrh [7F98] bccrl [3038]
bccrhv[7F98] bccrlv[301F]
start[1071946315] end[1070346296] 
usec_elapsed for mdelay(100) [103571]
start time: [1184152411]s [874717]us 
end   time: [1184152411]s [978288]us 
PLL input clock[15440000]Hz
usec_elapsed for mdelay(37) [35431]
start time: [1184152411]s [997039]us 
end   time: [1184152412]s [32470]us 
pata_pdc2027x 0000:00:0e.0: PLL input clock 15440 kHz

and from then on things are fine.

Weird. I'll try with an older gcc later (been using gcc-4.2.0 so far).

/Mikael
