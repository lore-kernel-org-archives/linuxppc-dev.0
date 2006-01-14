Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3E18D68A89
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Jan 2006 15:37:38 +1100 (EST)
Received: from ovro.ovro.caltech.edu
	(IDENT:U2FsdGVkX19ZDLnaDix7z7VOKuSyoOjbAiqOI0EVeOI@ovro.ovro.caltech.edu
	[192.100.16.2])
	by ovro.ovro.caltech.edu (8.13.1/8.13.1) with SMTP id k0E4bZJx017635
	for <linuxppc-embedded@ozlabs.org>; Fri, 13 Jan 2006 20:37:35 -0800
Message-ID: <43C88013.40800@ovro.caltech.edu>
Date: Fri, 13 Jan 2006 20:37:39 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: PPC440EP/Yosemite PCI misbehavior
References: <43C7292B.2060003@ovro.caltech.edu>
In-Reply-To: <43C7292B.2060003@ovro.caltech.edu>
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


Hi all,

Travis Sawyer sent me a snipped of his mmap code, and there
was an important difference relative to mine:

pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE | _PAGE_GUARDED;

With the addition of these two flags, the caching of the
PCI memory space has gone! Yeah!! (The flags aren't defined for
x86 pages, hence I'd never seen them).

Thanks Travis!

Now CPU reads and writes use PCI memory-read and PCI memory-write
commands. The CPU does not appear to use burst-transactions to
the pre-fetchable memory region. This is results in lower
performance, but its consistent with what an x86 does.

I'll go and play with the 440EP DMA controller and see if I can get
that to burst to the PCI bus.

> access to PCI I/O space causes a machine check exception.

I still get this in 2.6.15, but Wolfgang Denx indicated that
they'd tested PCI I/O pretty thoroughly, so I'm inclined to
believe that its my driver that is at fault. I'll do a little
more digging on that one.

Cheers
Dave
