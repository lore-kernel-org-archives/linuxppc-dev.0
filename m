Return-Path: <orutsch@sympatec.com>
Received: from sympatec.com (mail.sympatec.net [217.5.250.35])
	(using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 77F18DDEBC
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Mar 2007 00:45:36 +1100 (EST)
Received: from [172.20.3.12] (account rutsch [172.20.3.12] verified)
	by sympatec.com (CommuniGate Pro SMTP 5.1.4)
	with ESMTPSA id 1307604 for linuxppc-embedded@ozlabs.org;
	Thu, 01 Mar 2007 13:45:21 +0100
Message-ID: <45E6CAC8.8090007@sympatec.com>
Date: Thu, 01 Mar 2007 13:44:56 +0100
From: Oliver Rutsch <orutsch@sympatec.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: MPC5200, PLX9054 PCI Card - stalled DMA transfers
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

we're using a TQM5200S-Module (MPC5200) on a STK52xx-board with a 
PLX9054-based PCI card. The 2.4.25-kernel on the 3.1.1 ELDK had big 
problems to map the PCI resources of this card, so I tried the latest 
2.6.19.2-kernel of the 4.1 ELDK. This kernel mapped successfully the PCI 
resources on this card.
After building the latest PLX driver on the 2.6.19-kernel (I had to make 
some changes for the .19 kernel and for some litte/big endian issues) I 
was able to transfer data with programmed I/O. But as this is too slow I 
like to use the DMA functions of this device and here is the problem:
PLX provides an example program for scatter/gather DMA. This program 
works with their latetst driver on a linux PC. But on the TQM5200 the 
'Channel 0 done' flag of the DMASR0 register is never set after starting 
the DMA transfer. What can be the reason for this? The debug output of 
the driver looks O.K., but waiting for the DMA done interrupt gives a 
timeout, because the flag is not set. I wrote some test patterns in my 
DMA buffer before the DMA transfer and no byte of the buffer was 
altered, so the DMA engine seems not to be able to write a single byte.
Has anybody this or a similar card running on a ppc environment? Any 
ideas what I can do?

Thanks in advance and bye,
-- 
Dipl. Ing. Oliver Rutsch
EMail: orutsch@sympatec.com
