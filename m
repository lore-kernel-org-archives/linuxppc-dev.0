Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B663A679E6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 May 2006 01:36:25 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k4SFaLIH025774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-embedded@ozlabs.org>; Sun, 28 May 2006 11:36:21 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k4SFaLWf075548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Sun, 28 May 2006 09:36:21 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k4SFaKdT027336
	for <linuxppc-embedded@ozlabs.org>; Sun, 28 May 2006 09:36:21 -0600
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Howto allocate non-cacheable memory
Date: Sun, 28 May 2006 17:36:14 +0200
References: <012301731C23DE4DBFE035647C68F1CC0331C84F@sindhu.ctd.hcltech.com>
In-Reply-To: <012301731C23DE4DBFE035647C68F1CC0331C84F@sindhu.ctd.hcltech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605281736.14905.arnd.bergmann@de.ibm.com>
Cc: "Muneeswaran P - TLS, Chennai" <muneeswaranp@hcl.in>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Saturday 27 May 2006 07:38, Muneeswaran P - TLS, Chennai wrote:
> =A0=A0=A0=A0=A0=A0=A0=A0Pls clarify the following doubts:
> =A0=A0=A0=A0=A0=A0=A0=A01. DPRAM is memory mapped to PCI-X card.
> =A0=A0=A0=A0=A0=A0=A0=A02. I have to transfer data from main memory to DP=
RAM using bus
> master concept and vice-versa.
> =A0=A0=A0=A0=A0=A0=A0=A03. How to make this memory area as non-cacheable =
one ?=20
> =A0=A0=A0=A0=A0=A0=A0=A04. Whether DMA mapping (pci_map_single() call ) s=
hould be done for
> both DPRAM and main memory ?
> =A0=A0=A0=A0=A0=A0=A0=A0 =A0 4.a) I will get the physical address of DPRA=
M memory (memory
> mapped to PCI-X card) from BAR-0 register. Can i use this physical addres
> directly for data transer using bus master (without pci_map_single() call=
=2E)
> ?
> =A0=A0=A0=A0=A0=A0=A0=A0 =A0 4.b) =A0How to make main memory area as non-=
cacheable one ?

You need pci_map_single() for all bus-master accesses from the PCI-X card
and ioremap() to map the card's registers and/or memory into your kernel
address space as cache-inhibited.

Depending on what your adapter does, you might want to map memory areas
on the card with __ioremap(addr, size, _PAGE_NO_CACHE) instead of
ioremap(addr, size) in order to get a non-guarded mapping.

	Arnd <><
