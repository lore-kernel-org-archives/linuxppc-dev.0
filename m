Return-Path: <orutsch@sympatec.com>
Received: from sympatec.com (mail.sympatec.net [217.5.250.35])
	(using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7FA19DDE2B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Aug 2007 18:25:28 +1000 (EST)
Received: from [172.20.3.151] (account rutsch [172.20.3.151] verified)
	by sympatec.com (CommuniGate Pro SMTP 5.1.4)
	with ESMTPSA id 1948531 for linuxppc-embedded@ozlabs.org;
	Thu, 23 Aug 2007 09:27:25 +0200
Message-ID: <46CD3618.70801@sympatec.com>
Date: Thu, 23 Aug 2007 09:24:08 +0200
From: Oliver Rutsch <orutsch@sympatec.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: STK5200 pci_enable_device problem
References: <7B9A8FF57DBB524190E98CABF6E56F078FAE4E@itri.bte.mam.gov.tr>
In-Reply-To: <7B9A8FF57DBB524190E98CABF6E56F078FAE4E@itri.bte.mam.gov.tr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Mustafa,

> Hi all,
> 
[...]
> 
> My pci driver is able to scan pci bus and find succesfully the pci
> device. After this point, pci_enable_device function returns
> following error:
> 
> PCI:  Device 00:18.0 not available because of resource collisions
> 

Which ELDK and kernel do you use? I had the same problem on this board 
with a PLX9054 based PCI card on a 2.4.25 kernel. I switched to the 2.6 
kernel and the 4.1 ELDK and the card was scanned correctly.
But keep in mind that the linux PLX drivers do not work out of the box 
with a big endian platform like the MPC5200. Although there is a 
BIG_ENDIAN flag in the makefiles there are still some places left in the 
driver code which have to be patched (the parts with int64 adresses).
It's not so easy to compile the PLX drivers on the 4.1 ELDK because of 
missing headers in the ppc architecture. I managed to build the drivers 
for the 2.6.19 kernel and I was able to work with the card except the 
DMA routines (still working on this issue).

Hope this helps. Bye,

-- 
Dipl. Ing. Oliver Rutsch
