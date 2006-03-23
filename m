Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7B0267B16
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 04:19:06 +1100 (EST)
In-Reply-To: <4422D6E3.1010407@ovro.caltech.edu>
References: <B1E46DE837A394458BB1A58F74A66A780596CB@ala-mail02.corp.ad.wrs.com>
	<204E7000-3E88-4497-86C0-5AF786D72F75@kernel.crashing.org>
	<4422D6E3.1010407@ovro.caltech.edu>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CCA437BF-E204-4652-9E6D-25388225EFE8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Memory mapping PCI memory region to user space
Date: Thu, 23 Mar 2006 11:19:58 -0600
To: David Hawkins <dwh@ovro.caltech.edu>
Cc: Chris Wyse <chris.wyse@windriver.com>,
	"Linuxppc-Embedded \(\(E-Mail\)\)" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 23, 2006, at 11:12 AM, David Hawkins wrote:

>
>
>> Why don't use the mmap file exposed by sysfs so you dont have to   
>> write your own code?
>> See Documentation/filesystems/sysfs-pci.txt.  But effectively  
>> down  under /sys/bus/pci/devices/[domain:bus:dev:func]/ you will  
>> get  resource[0..N-1] that corresponds to each BAR on the device.   
>> This is  a mmap file to access that region.
>
> Hi Kumar,
>
> Most likely he didn't know about it, I didn't :)
>
> When I was testing the Yosemite board as the host, I found
> that I could set the endian flag on the mmapped page, which
> then made the PCI device registers read as 32-bit quantities
> read back with the same layout under both x86 and PPC
> hosts.

Hmm, I guess I would handle this like how the reset of the kernel  
handle is with the io routines handling the swapping.  Not sure if  
there is any advantage to using the endian flag.  I guess if you have  
something you are treating as just memory there would be.

> So, if someone planned on using that 'feature', that would
> be a reason for writing your own mmap() implementation.
> I didn't see any option in the sysfs file for setting that
> page flag (but, I didn't look around in other sysfs files).

There isn't a sysfs flag for the endianness page attribute since  
thats a PPC book-e specific feature.  We could possible expand things  
to support it but, I've been trying to actively avoid using the 'E' bit.

> Thanks for the pointer to the sysfs node!

No problem, its what we're here for :)

- kumar
