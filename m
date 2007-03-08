Return-Path: <orutsch@sympatec.com>
Received: from sympatec.com (mail.sympatec.net [217.5.250.35])
	(using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 20DF4DDEAB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Mar 2007 18:48:10 +1100 (EST)
Message-ID: <45EFBF91.7080304@sympatec.com>
Date: Thu, 08 Mar 2007 08:47:29 +0100
From: Oliver Rutsch <orutsch@sympatec.com>
MIME-Version: 1.0
To: David Hawkins <dwh@ovro.caltech.edu>
Subject: Re: MPC5200, PLX9054 PCI Card - stalled DMA transfers
References: <45E6CAC8.8090007@sympatec.com> <45E75859.3090508@ovro.caltech.edu>
In-Reply-To: <45E75859.3090508@ovro.caltech.edu>
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

Hi David,

> 
> I use the PLX-9054 in my custom boards (TI DSP on-board), and
> Linux x86 host computer. When debugging, I load a simple memmap
> driver, and 'tickle' the board registers directly.
> 
> There's a copy of the PLX driver in here ...
> http://www.ovro.caltech.edu/~dwh/correlator/pdf/cobra_driver.pdf
> http://www.ovro.caltech.edu/~dwh/correlator/software/cobra_driver-2.9.tar.gz 
> 

I read your interesting article. Thanks for this!
The PCI card I'm using works without problems on a X86 PC, so I think 
the PLX hardware is O.K. I checked every local PLX9054 register on the 
MPC5200 against the X86 PC. On both computers they have the same values. 
Even a simple block DMA does not work, although I checked all registers 
and addresses. So I think the plx driver software is O.K. on the MPC5200 
and there has to be a hardware reason. Maybe the pci bus is not granted 
to the bus master controller of the PLX9054 when it requests the bus.
We'll check this when our hardware guy has time for this ;-)


> Anyway, manually setup a DMA transfer and convince yourself that
> you know which bits to twiddle, then figure out why the driver
> code isn't doing as its asked.
> 

I've done so without success. The driver seems to make everything 
correct. A block DMA is fairly simple on the 9054, so I think there must 
be a hardware reason for this.
Has anybody ever used a PCI card on the MPC5200 which has its own 
busmaster controller? I think most people use the BestComm DMA 
controller on the MPC5200, right?

Thanks for your interest and bye,

-- 
Dipl. Ing. Oliver Rutsch
EMail: orutsch@sympatec.com · Tel.:+49 5323 717514
Sympatec GmbH · Am Pulverhaus 1 · 38678 Clausthal-Zellerfeld · Germany
