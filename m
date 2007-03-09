Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 16317DDEC6
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Mar 2007 04:06:14 +1100 (EST)
Message-ID: <45F1936C.6030008@ovro.caltech.edu>
Date: Fri, 09 Mar 2007 09:03:40 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Oliver Rutsch <orutsch@sympatec.com>
Subject: Re: MPC5200, PLX9054 PCI Card - stalled DMA transfers
References: <45E6CAC8.8090007@sympatec.com> <45E75859.3090508@ovro.caltech.edu>
	<45EFBF91.7080304@sympatec.com>
In-Reply-To: <45EFBF91.7080304@sympatec.com>
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

Hi Oliver,

> The PCI card I'm using works without problems on a X86 PC, so I think 
> the PLX hardware is O.K. I checked every local PLX9054 register on the 
> MPC5200 against the X86 PC. On both computers they have the same values.

Ok, that eliminates a hardware error in reading registers on the board,
i.e., the PCI connection is fine. There could still be errors in
the PCI-9054 local bus connections ...

> Even a simple block DMA does not work, although I checked all registers 
> and addresses. So I think the plx driver software is O.K. 

I'm sure you have checked this, but I'll mention it just in case ...
you are using readl/writel type functions to access the little-endian
PCI registers from the big-endian PowerPC right?

> on the MPC5200 
> and there has to be a hardware reason. Maybe the pci bus is not granted 
> to the bus master controller of the PLX9054 when it requests the bus.
> We'll check this when our hardware guy has time for this ;-)

A PCI bus logic analyzer is pretty nice for this type of issue.
I use an Agilent 1680A, and a FuturePlus PCI or CPCI adapter
board. The analyzer is about $20k, while the adapters are about
$2k. However, they pay for themselves pretty quickly.

>> Anyway, manually setup a DMA transfer and convince yourself that
>> you know which bits to twiddle, then figure out why the driver
>> code isn't doing as its asked.
> 
> I've done so without success. 

Without success on the x86 too?

> The driver seems to make everything correct. A block DMA is fairly
> simple on the 9054, so I think there must be a hardware reason for this.
> Has anybody ever used a PCI card on the MPC5200 which has its own 
> busmaster controller? I think most people use the BestComm DMA 
> controller on the MPC5200, right?

I tested the PCI debug driver I wrote from an x86 with my PLX
boards, and on a Yosemite (440EP) board. I tested DMA using
the PCI-9054 DMA controllers, and the 440EP controllers.

Read p23 to p35 of my 440EP test document, I have some tests
there that you could repeat ...

http://www.ovro.caltech.edu/~dwh/powerpc_440ep.pdf

However, life will be much easier if you can grab the hardware
guy's logic analyzer ... out of his cold dead hands if need be ;)

Dave
