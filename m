Return-Path: <Steffen.Rumler@siemens.com>
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
	by ozlabs.org (Postfix) with ESMTP id 4B2172BF16
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jan 2005 20:07:22 +1100 (EST)
Received: from mail1.siemens.de (mail1.siemens.de [139.23.33.14])
	by david.siemens.de (8.12.6/8.12.6) with ESMTP id j0C8cgtr020535
	for <linuxppc-embedded@ozlabs.org>; Wed, 12 Jan 2005 09:38:42 +0100
Message-ID: <41E4E1EB.6080903@siemens.com>
Date: Wed, 12 Jan 2005 09:38:03 +0100
From: Steffen Rumler <Steffen.Rumler@siemens.com>
MIME-Version: 1.0
To: linuxppc <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Kernel boot hangs by parallel flood pings
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm using a 2.4.20 kernel (PPC).

When I run multiple 'ping -f' directed to my board
during the kernel boots, sometimes it hangs with
the following messages:


   Memory BAT mapping: BAT2=64Mb, BAT3=32Mb, residual: 84Mb
   Linux version 2.4.20-rthal5 (ru@styx) (gcc version 2.95.3 20010111 (prerelease/franzo/20010111))
   #9 Tue Jan 11 17:09:22 CET 2005
   On node 0 totalpages: 29859
   zone(0): 29859 pages.
   zone(1): 0 pages.
   zone(2): 0 pages.
   Kernel command line: bootdev=aps0 ip=218.1.36.70:218.1.36.47:218.1.36.254:255.255.255.0::eth0:off
   panic=1 mem=119436k
   Calibrating delay loop... 194.15 BogoMIPS
   ...
   NET4: Linux TCP/IP 1.0 for NET4.0
   IP Protocols: ICMP, UDP, TCP
   IP: routing cache ha
                 ^^^^^^^
                   the kernel boot hangs here


I have checked this with the BDI2000 and found that the
kernel loops anywhere inside ip_route_input().

I think this is because the ethernet driver (fcc_enet.c)
enables the hardware too already inside it's init routine (fec_enet_init()).

In this way, frames may be received and forwarded to the upper
layers with netif_rx(), before the TCP/IP was initialized.

I suggest to delay the lines

   /* Enable transmit/receive */
   fccp->fcc_gfmr |= FCC_GFMR_ENR | FCC_GFMR_ENT;

to the open entry point (fcc_enet_open()), which is
triggered by 'ifconfig up' in the following way:


   if(!((fccp->fcc_gfmr) & FCC_GFMR_ENR))
      fccp->fcc_gfmr |= (FCC_GFMR_ENR | FCC_GFMR_ENT);

By the way, fcc_enet_close() does _NOT_ stop the hardware.
Hopefully, this is not a real problem.


Steffen

-- 


--------------------------------------------------------------

Steffen Rumler
ICN CP D NT SW 3
Siemens AG
Hofmannstr. 51                 Email: Steffen.Rumler@siemens.com
D-81359 Munich                 Phone: +49 89 722-44061
Germany                        Fax  : +49 89 722-36703

--------------------------------------------------------------
