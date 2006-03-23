Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 1C2D267A5A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 04:10:42 +1100 (EST)
Message-ID: <4422D6E3.1010407@ovro.caltech.edu>
Date: Thu, 23 Mar 2006 09:12:03 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Memory mapping PCI memory region to user space
References: <B1E46DE837A394458BB1A58F74A66A780596CB@ala-mail02.corp.ad.wrs.com>
	<204E7000-3E88-4497-86C0-5AF786D72F75@kernel.crashing.org>
In-Reply-To: <204E7000-3E88-4497-86C0-5AF786D72F75@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "Wyse, Chris" <chris.wyse@windriver.com>,
	+linux-embedded <linux-embedded@mail.wrs.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> Why don't use the mmap file exposed by sysfs so you dont have to  
> write your own code?
> 
> See Documentation/filesystems/sysfs-pci.txt.  But effectively down  
> under /sys/bus/pci/devices/[domain:bus:dev:func]/ you will get  
> resource[0..N-1] that corresponds to each BAR on the device.  This is  
> a mmap file to access that region.

Hi Kumar,

Most likely he didn't know about it, I didn't :)

When I was testing the Yosemite board as the host, I found
that I could set the endian flag on the mmapped page, which
then made the PCI device registers read as 32-bit quantities
read back with the same layout under both x86 and PPC
hosts.

So, if someone planned on using that 'feature', that would
be a reason for writing your own mmap() implementation.
I didn't see any option in the sysfs file for setting that
page flag (but, I didn't look around in other sysfs files).

Thanks for the pointer to the sysfs node!

Cheers
Dave
