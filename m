Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id BA88A67A45
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 04:03:31 +1100 (EST)
Message-ID: <4422D537.2020507@ovro.caltech.edu>
Date: Thu, 23 Mar 2006 09:04:55 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: "Wyse, Chris" <chris.wyse@windriver.com>
Subject: Re: Memory mapping PCI memory region to user space
References: <B1E46DE837A394458BB1A58F74A66A780596CB@ala-mail02.corp.ad.wrs.com>
In-Reply-To: <B1E46DE837A394458BB1A58F74A66A780596CB@ala-mail02.corp.ad.wrs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: +linux-embedded <linux-embedded@mail.wrs.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> I'm trying to map a PCI memory region 1 into user space from my driver 
> (PPC440GX, Linux 2.6.10).  Here's the mmap routine of the driver that 
> I'm using:

Hi Chris,

I wrote a generic PCI IO driver when testing the
Yosemite 440EP, take a look at the code, its fairly
well commented. You probably just need to add the
PCI vendor ID for your target board:
(or you can echo the deviceID:vendorID to the
sysfs node for the driver)

http://www.ovro.caltech.edu/~dwh/pci_io.tar.gz

There's some comments in here on it:
http://www.ovro.caltech.edu/~dwh/correlator/pdf/LNX-723-Hawkins.pdf

For example, on an x86 system, I was looking for
a PLX PCI9054 10b5:9054, and then on the yosemite
board I was looking for the same hardware.

In your case, its not clear from your email whether you
are on a 440GX looking for another device, or on a host
looking for a 440GX. Either way, the driver should work.

Cheers
Dave
