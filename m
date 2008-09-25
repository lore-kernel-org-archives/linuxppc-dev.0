Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id A93EEDE280
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Sep 2008 04:14:10 +1000 (EST)
Message-ID: <48DBD4F2.1060206@ovro.caltech.edu>
Date: Thu, 25 Sep 2008 11:14:10 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Bruce_Leonard@selinc.com
Subject: Re: How do I access nvRAM from user space?
References: <OF871A5E9F.D762FCD5-ON882574CF.005EDA9D-882574CF.005F1AE2@selinc.com>
In-Reply-To: <OF871A5E9F.D762FCD5-ON882574CF.005EDA9D-882574CF.005F1AE2@selinc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded-bounces+brucle=selinc.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Bruce,

> Thanks for the reply.  So if my nvSRAM device is located at 0xb0000000 in 
> physical memory, what would the mmap() call look like?  Also, do I need to 
> have a device tree entry for the kernel to know about the memory?  I can 
> access the device in uboot so I know it works, but I can't figure out the 
> mmap to get it from linux

Its pretty much:

	/* Open /dev/mem and map it */
	printf(" * open /dev/mem\n");
	fd = open("/dev/mem", O_RDWR | O_SYNC);
	if (fd < 0) {
		printf("Open /dev/mem failed - %s\n",
			strerror(errno));
		return -1;
	}
	printf(" * map %d page(s) (%d-bytes) at address 0x%.8X\n",
			mem_pages, mem_size, mem_phys);
	mem_addr = (char *)mmap(
		0,
		mem_size,
		PROT_READ|PROT_WRITE,
		MAP_SHARED,
		fd,
		mem_phys);
	if (mem_addr == (char *)MAP_FAILED) {
		printf("Error: mmap failed\n");
		close(fd);
		return -1;
	}

I'll send you the code I ripped that from, and another
example from the Busybox code.

Cheers,
Dave
