Return-Path: <petermendham@computing.dundee.ac.uk>
Received: from uncle.computing.dundee.ac.uk (unknown [134.36.36.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1E3F7DDEFC
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 23 Apr 2007 23:56:11 +1000 (EST)
Received: from mailex.computing.dundee.ac.uk (mailex.computing.dundee.ac.uk
	[134.36.36.15])
	by uncle.computing.dundee.ac.uk (8.13.1/8.13.1) with ESMTP id
	l3NClu8D025726
	for <linuxppc-embedded@ozlabs.org>; Mon, 23 Apr 2007 13:47:56 +0100
Message-ID: <462CAB38.8040506@computing.dundee.ac.uk>
Date: Mon, 23 Apr 2007 13:48:56 +0100
From: Peter Mendham <petermendham@computing.dundee.ac.uk>
MIME-Version: 1.0
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Subject: Re: Tri-mode auto-negotiation on ML405
References: <461F65E3.1050004@computing.dundee.ac.uk>
	<461FAF0D.3070803@ru.mvista.com>
	<46278F3A.4070007@computing.dundee.ac.uk>
	<462B6EB2.70109@ru.mvista.com>
In-Reply-To: <462B6EB2.70109@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrei Konovalov wrote:
> Has the ethernet device been registered on the platform bus?
> There should be a call to platform_device_register()
> in arch/ppc/syslib/virtex_devices.c or arch/ppc/platforms/4xx/virtex.c 
> depending
> on the kernel tree used and the patches appiled.
Hi Andrei,

Drat.  I forgot to put that back in when I went to Grant Likely's latest 
patchset.  The errors I am getting now are (when I try and bring the 
network up):
eth0: XTemac Options: 
0xbcf0                                                   
eth0: XTemac could not start 
device.                                           
SIOCSIFFLAGeth0: XTemac Options: 
0xbcf0                                        
eth0: XTemac could not start 
device.                                           
S: Device or resource 
busy                                                     
SIOCSIFFLAGS: Device or resource 
busy                                          
route: SIOC[ADD|DEL]RT: Network is unreachable

During boot it said:
eth%d: XTemac using fifo direct interrupt driven 
mode.                         
mdiobus_reset on 
eth%d                                                         
temac_mii: 
probed                                                              
eth%d: attached PHY driver [Generic PHY] (mii_bus:phy_addr=0:00, 
irq=-1)       
eth0: Xilinx TEMAC #0 at 0x80000000 mapped to 0xC5020000, 
irq=0                
eth0: XTemac id 1.0f, block id 5, type 8

It seems like it's finding the MAC and PHY OK, what else have I done wrong?

Thanks,
-- Peter

-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
MailScanner thanks transtec Computers for their support.
