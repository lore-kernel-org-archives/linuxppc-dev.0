Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 333E9B7BC6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Dec 2009 15:52:41 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: PCI interrupt question
Date: Fri, 4 Dec 2009 05:52:34 +0100
References: <1259821316.12651.26.camel@qu102.quarc.com>
	<4B17F14A.1060001@ovro.caltech.edu>
	<1259869140.18190.52.camel@qu102.quarc.com>
In-Reply-To: <1259869140.18190.52.camel@qu102.quarc.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200912040552.34178.sr@denx.de>
Cc: Jeff Hane <jeff.hane@maxim-ic.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 03 December 2009 20:39:00 Jeff Hane wrote:
> > Can you clarify:
> >
> > 1. 460EX is your PCI host CPU?
> 
> yes.  We are using a canyonlands board with 460ex.

PCI works on Canyonlands without any problems. I just tested latest Linux 
release (2.6.32) with an PCI USB card:

-bash-3.2# uname -a
Linux canyonlands 2.6.32 #1 Fri Dec 4 05:42:35 CET 2009 ppc ppc ppc GNU/Linux
-bash-3.2# cat /proc/cpuinfo
processor       : 0
cpu             : 460EX
clock           : 800.000010MHz
revision        : 24.162 (pvr 1302 18a2)
bogomips        : 1600.00
timebase        : 800000010
platform        : PowerPC 44x Platform
model           : amcc,canyonlands
Memory          : 512 MB
-bash-3.2# cat /proc/interrupts
           CPU0
 18:          0   UIC   Edge      L2C
 19:         22   UIC   Level     ohci_hcd:usb2, ohci_hcd:usb3
 20:      15220   UIC   Level     serial
 23:       8038   UIC   Level     MAL TX EOB
 24:      15510   UIC   Level     MAL RX EOB
 25:          0   UIC   Level     MAL SERR
 26:          0   UIC   Level     MAL TX DE
 27:          0   UIC   Level     MAL RX DE
 28:          0   UIC   Level     EMAC
 34:          1   UIC   Level     ohci_hcd:usb1
 35:       2926   UIC   Level     IBM IIC
 38:          0   UIC   Level     IBM IIC
BAD:          0
-bash-3.2#

I can't see any problems with PCI interrupts here.

Cheers,
Stefan
