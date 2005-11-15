Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id 1DE0E68742
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Nov 2005 22:20:48 +1100 (EST)
Message-ID: <1132056238.4379ceae1564a@webmail.televes.com:443>
Date: Tue, 15 Nov 2005 13:03:58 +0100
From: Alexandre BASTOS <alebas@televes.com>
To: Mike Rapoport <mike@compulab.co.il>
References: <a79669360510062205v629affb9ga687078f018afae@mail.gmail.com>
	<200510120859.12362.sr@denx.de> <434CB71E.5000603@compulab.co.il>
	<200510120927.56692.sr@denx.de>
	<20051012133414.7f7e2faf.ajz@cambridgebroadband.com>
	<4365BD71.9010507@compulab.co.il>
	<1131960060.7748.9.camel@hawk.pwav.net>
	<43798741.5070604@compulab.co.il>
In-Reply-To: <43798741.5070604@compulab.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8555 USB host support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mike,


> I've opened a project on the SourceForge,
> http://cpm2usb.sourceforge.net. The file containing patch against
> 2.6.12.3 can be downloaded at http://sourceforge.net/projects/cpm2usb.
>
> The driver was developed on MPC8272ADS, but should go as well on 8270
> since they have the same USB host controller AFAIK.
> Currently, as far as I tested it works fine with full-speed single
> device attached through hub, but fails is there are transfers from/to
> several devices simultaneously.
> As for the code itself, it's far from being perfect.


I have been testing your cpm2usb driver from sourceforge on my
MPC8272ADS and I couldn't get a usb 2.0 pendrive working.

usbcore tries to identify the device with both schemes, old and
new, but the hcd returns always a timeout. The output from console:

# modprobe usbcore
usbcore: registered new driver usbfs
usbcore: registered new driver hub

# modprobe m82xx-hcd
=> driver mpc82xx-hcd, 2005
mpc82xx-hcd mpc82xx-hcd.3: PQ2 intergrated USB controller v0.1
mpc82xx-hcd mpc82xx-hcd.3: new USB bus registered, assigned bus number 1
usb usb1: Product: PQ2 intergrated USB controller v0.1
usb usb1: Manufacturer: Linux 2.6.12 mpc82xx-hcd
usb usb1: SerialNumber: mpc82xx-hcd.3
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
PQ2USB: debug file creation

[... After pendrive insertion]

usb 1-1: new full speed USB device using mpc82xx-hcd and address 2
usb 1-1: device descriptor read/64, error -110
usb 1-1: device descriptor read/64, error -110
usb 1-1: new full speed USB device using mpc82xx-hcd and address 3
usb 1-1: device descriptor read/64, error -110
usb 1-1: device descriptor read/64, error -110
usb 1-1: new full speed USB device using mpc82xx-hcd and address 4
usb 1-1: device not accepting address 4, error -110
usb 1-1: new full speed USB device using mpc82xx-hcd and address 5
usb 1-1: device not accepting address 5, error -110

To compile the driver as a module, I made only a change in "tx_err"
function from m82xx-hcd.c, which shouldn't be affecting.
I have also commented out the re-definition of BCSR_ADDR, which is
already defined to f4500000 in pq2ads.h

--- m82xx-hcd.c.orig    2005-11-15 12:05:40.547987056 +0100
+++ m82xx-hcd.c 2005-11-14 18:15:13.000000000 +0100
@@ -98,7 +98,7 @@
        hp->usb_clock = USB_CLOCK_PC24_CLK8;

        {
-#define BCSR_ADDR              ((uint)0xf8000000)
+//#define BCSR_ADDR            ((uint)0xf8000000)
        volatile uint* bcsr_usb = (volatile uint*)(BCSR_ADDR +
                                                   BCSR_USB_OFFSET);

@@ -281,7 +281,9 @@
 static void tx_err(struct m8xxhci_private *hp, int ber)
 {
        volatile usbregs_t *usbregs = hp->usbregs;
-       volatile cpm_cpm2_t *cp = cpmp;
+       //volatile cpm_cpm2_t *cp = cpmp;
+       volatile cpm2_map_t *immap = (volatile cpm2_map_t *)CPM_MAP_ADDR;
+       volatile cpm_cpm2_t *cp = &immap->im_cpm;

        if ( hp->active_qe )
                hp->stats.txe[hp->active_qe->qtype]++;

So, any idea which could be happening? I have little knowledge about usb
so I am quite lost.


Thanks.

Alex BASTOS
