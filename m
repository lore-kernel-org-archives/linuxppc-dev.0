Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay012.isp.belgacom.be (mailrelay012.isp.belgacom.be
	[195.238.6.179]) by ozlabs.org (Postfix) with ESMTP id 8CE51DDE07
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Sep 2007 18:54:09 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: 8270 & Watchdog - early start
Date: Thu, 20 Sep 2007 10:54:04 +0200
References: <AEA1A32F001C6B4F98614B5B80D7647D02D73DEB@esealmw115.eemea.ericsson.se>
In-Reply-To: <AEA1A32F001C6B4F98614B5B80D7647D02D73DEB@esealmw115.eemea.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200709201054.04249.laurentp@cse-semaphore.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Matias,

On Thursday 20 September 2007 10:19, Matias Sundman wrote:
> Hi,
> I have a custom MPC8270 board running Linux and u-boot.
> Now, I enabled the watchdog on the 8270 and need to kick it regularly by
> writing ;
>
> 0x556c
> 0xaa39
>
> To the internal register @ 0x0x1000e.
>
> When I am coming out from head.S to start_kernel I was thinking of
> kicking it a couple times "manually" before a timer interrupt is inserted
> which will take care of it until a "superdaemon" is taking over.
>
> I tried to serve the register as follows;
>
> *((volatile unsigned int*)(0xf001000e))=3D0x556c;
> *((volatile unsigned int*)(0xf001000e))=3D0xaa39;
>
> But it does not take effect. I thought that since u-boot had set up the
> IMMR to 0xf000'0000 I could directly write to the register as above.
>
> Any clues why this does not work?

The Software Service Register (SWSR) is 16-bit wide. Unsigned int on the 82=
70=20
is 32-bit wide.

You must not reference physical addresses directly after the MMU has been=20
turned on. Use ioremap/iounmap to map/unmaap the CPM registers. If you're=20
using ARCH=3Dppc, you can also use the global CPM mapping cpm2_immr.

Use the out_* macros/functions to write to I/O space.

out_be16(&cpm2_immr->im_siu_conf.siu_82xx.sc_swsr, 0x556c);
out_be16(&cpm2_immr->im_siu_conf.siu_82xx.sc_swsr, 0xaa39);

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=C3=A9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75
