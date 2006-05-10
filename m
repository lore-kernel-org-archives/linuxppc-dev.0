Return-Path: <geoffrey.levand@am.sony.com>
Received: from mail8.fw-sd.sony.com (mail8.fw-sd.sony.com [160.33.66.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A851A679FB
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 11:28:05 +1000 (EST)
Message-ID: <446141A2.9030000@am.sony.com>
Date: Tue, 09 May 2006 18:28:02 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: pci_resource_end problem revisited
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

I still have this problem of OF reporting the serial port bar
size as 16 instead of 8 on my G5.  Where would be a proper
place to fix this?  BTW, I verified that it is OF that reports
the size as 16.

-Geoff

-------- Original Message --------
Subject: Re: pci_resource_end() changed problem with 2.6.14
Date: Fri, 04 Nov 2005 10:36:58 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc64-dev@ozlabs.org
References: <436ADBA7.7030706@am.sony.com> <1131087370.4680.238.camel@gaston>

Benjamin Herrenschmidt wrote:
> On Thu, 2005-11-03 at 19:55 -0800, Geoff Levand wrote:
> 
>>I found that the serial port probe code in drivers/serial/8250_pci.c 
>>no longer works properly for ppc64 in 2.6.14.  It seems the value 
>>returned by pci_resource_len() on ppc64 changed from 8 to 16 since 
>>2.6.13.  I tested on a PC and pci_resource_len() returns 8 as 
>>expected.
>>
> Interesting... What does an lspci -vv shows for the BARs of the PCI
> card ? Also, what do you have in /proc/device-tree  ? What is the
> machine precisely ?
> 
> 2.6.14 now uses the OF device-tree to generate the linux PCI tree
> instead of going directly to PCI probing. It's possible that this is
> causing your problem if for some reason, the BAR sizing done by OF ends
> up being different than what the kernel does ...
> 

Sorry, I should have mentioned it, this is on my PowerMac G5 with a
generic 8250 serial PCI card (StarTech PCI4S550N).  Here's what lspci
gives me:

0001:05:03.0 Serial controller: NetMos Technology PCI 9845 Multi-I/O Controller (rev 01) (prog-if 02 [16550])
        Subsystem: LSI Logic / Symbios Logic 0P4S (4 port 16550A serial card)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 53
        Region 0: I/O ports at f4000050 [size=16]
        Region 1: I/O ports at f4000040 [size=16]
        Region 2: I/O ports at f4000030 [size=16]
        Region 3: I/O ports at f4000020 [size=16]
        Region 4: I/O ports at f4000010 [size=16]
        Region 5: I/O ports at f4000000 [size=16]

It could be the change to using the OF device-tree.  What's an easy way to
see the size OF has used?

-Geoff
