Return-Path: <olivier.goudard@esrf.fr>
Received: from out.esrf.fr (firewall.ill.fr [193.49.43.1])
	by ozlabs.org (Postfix) with ESMTP id B689967B6C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Nov 2006 03:20:57 +1100 (EST)
Subject: Re: Memec v4fx12lc - problem booting linux on ppc
Message-Id: <7.0.1.0.1.20061124164552.01f06298@esrf.fr>
Date: Fri, 24 Nov 2006 17:05:02 +0100
To: Andrei Konovalov <akonovalov@ru.mvista.com>
From: Olivier GOUDARD <olivier.goudard@esrf.fr>
In-Reply-To: <45632A8E.3010509@ru.mvista.com>
References: <1164022946.8340.6.camel@l-cb312-1.esrf.fr>
	<JG200611211159003.3859000@co-nss.co.jp>
	<1164102298.21858.4.camel@l-cb312-1.esrf.fr>
	<4562E546.9070401@ru.mvista.com>
	<7.0.1.0.1.20061121153812.0430db90@esrf.fr>
	<45632A8E.3010509@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Cc: andy.gotz@esrf.fr, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Andrei,

Thanks to your advices we managed to view characters on the serial line.
(I remind that we are trying to boot linux MontaVista 3.1 on V4FX12LC 
board of Memec.)
It looks like we where using the wrong xparameters_2vpx.h file.

We also applyied your patch in arch/ppc/boot/simple/head.S

After modifications we obtained :
______________________________________________________________________________
loaded at:     00400000 004B61E4
board data at: 004B313C 004B3154
relocated to:  0040564C 00405664
zimage at:     00405C17 004B20B5
avail ram:     004B7000 04000000

Linux/PPC load: console=ttyS0,9600 ip=on 
nfsroot=192.168.219.54:/root/myDesign/rootfs rw
Uncompressing Linux...done.
Now booting the kernel
.
_______________________________________________________________________________

Which is remotivating us a lot !!
I also managed to get a longer boot, but I encounter a kernel panic 
during the serial driver configuration...

We are wondering what to do now ?
Maybe we should try to find in xps why we are not using the right 
xparameterXX.h file and generate a new bit file ?
Or maybe we should concentrate our efforts on Linux configuration ?

Any comments are welcome that might help us in the ppc/linux boot quest !
Thanks again Andrei,
Olivier




At 17:34 21/11/2006, Andrei Konovalov wrote:
>Olivier GOUDARD wrote:
> > Dear Andrei,
> >
> > Thanks for all details provided in your mail. It looks like we have a
> > lot to understand about the boot sequence.
> > To answer your questions :
> >
> > We created our own platform with xps.
>
>I meant a new board entry in the kernel configuration.
>Now I see - you are reusing the one for memec 2VPx.
>
> > We went throught the differents steps of the xps wizard to impelment
> > ppc, UART, EMAC, SDRAM and so on.
> > Then, we generated the Linux Support Package and compiled the Montavista
> > previewkit
> >  with the generated files in linux/arch and linux/drivers  from the
> > Linux Support Package.
> >
> > The montavista previewkit used is :
> > insight_memec-2vp7fg456_rev4-previewkit-ppc_405
> >
> > and this previewkit seems to be based on linux 2.4.20 version.
>
>Pro 3.1 preview kit is rather old, and does not have a workaround
>required for Virtex4. This should not be a problem in your case though,
>as I believe the generated files in linux/arch should have it.
>Something like this hack:
>
>---8<--------------------------------------------------------------
>--- arch/ppc/boot/simple/head.S 4 Jan 2005 06:18:47 -0000       1.1
>+++ arch/ppc/boot/simple/head.S 23 Jun 2005 05:11:42 -0000      1.2
>@@ -46,6 +46,11 @@
>   #endif
>
>   start_:
>+       /* PPC errata 213: only for Virtex-4 */
>+       mfccr0  0
>+       oris    0,0,0x50000000@h
>+       mtccr0  0
>+
>   #if defined(CONFIG_FORCE) || defined(CONFIG_PPMC260)
>          /* We have some really bad firmware.  We must disable the L1
>           * icache/dcache now or the board won't boot.
>---8<--------------------------------------------------------------
>
>There should be #ifdef CONFIG_XILINX_VIRTEX_4_FX here or like that,
>but the kernel tree you are using doesn't have Virtex4 config option
>(unlike e.g. community 2.6 tree or Montavista Pro 4.0)
>
> > I'm not sure that we used propers xparameters<something_else>.h file
> > because I don't understand what you mean. I searched in my kernel
> > sources to find xparam* but I was not successful.
> > Can you enlighten my ignorance ?
>
>arch/ppc/platforms/xilinx_ocp/xparameters_2vpx.h
>
>The memec board uses this one (to find the addresses and the interrupt
>numbers). Make sure the defines there match your bitstream.
>
> > I will check my UART configuration which seems to be very wrong ! :-)
>
>Your UART is 16x50, not UART Lite, correct?

____________________________________________________
Olivier GOUDARD,
European Synchrotron Radiation Facility
Machine Division - Power Supply Group
BP 220, F-38043 Grenoble Cedex, France

Tel : +33 (0)4 76 88 24 69,   Fax : +33 (0)4 76 88 20 54
____________________________________________________  
