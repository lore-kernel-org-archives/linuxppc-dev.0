MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: Slow down with recent linux kernel
Date: Thu, 15 Apr 2004 08:54:46 +1200
Message-ID: <4ABDB84E30B89F4E9C942C186F0B9EF605BBC6@4rf-nz-mail.local.4rf.com>
From: "Richard Laing" <Richard.Laing@4rf.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We are developing a new Linux based product on custom hardware (mpc855 CPU). We are currently running the 2.4.22 kernel (straight from kernel.org). This works fine. We would like to move to the latest 2.4.25 kernel but although the kernel compiles and runs it runs much slower than the 2.4.22 kernel. Startup time for our application form power on to running is increased by between 30% and 50%. Has anyone else seen anything like this or has anyone any idea where to start looking for the cause of this slow down.

The serial console works correctly with both kernels with apparent speed change.

We have DRAM, Flash (incuding a JFFS2 file system), I2C and SPI devices.

Also...the latest kernel breaks our SPI driver since alloc_host_memory is used to allocate the host_buffer pointer, this uses consistent_alloc which doesn't appear to return a real physical address which means that memory allocated using m8xx_cpm_hostalloc cannot be used as a buffer pointer for SPI transactions. Is there another way to get real memory? Currently I have reverted some of the commproc.c code to use the host_page_address as in the 2.4.22 kernel. Is this a possible source of the slow down?

Regards
Richard Laing

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
