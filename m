Return-Path: <vijay_padiyar@hotmail.com>
Received: from hotmail.com (bay1-dav3.bay1.hotmail.com [65.54.244.107])
	by ozlabs.org (Postfix) with ESMTP id 6288D67A46
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Feb 2005 15:38:03 +1100 (EST)
Message-ID: <BAY1-DAV32181D4E594557F8931608B770@phx.gbl>
From: "Vijay Padiyar" <vijay_padiyar@hotmail.com>
To: "Embedded TUX" <etux@embeddedtux.org>,
	"LinuxPPC Support" <linuxppc-embedded@ozlabs.org>
Date: Fri, 11 Feb 2005 10:07:53 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: problem with accessing memory mapped area
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi there

I'm running a Linux 2.6.10 kernel with BusyBox 1.0 on an MPC8260 platform.
My board's memory map is as follows:

SDRAM: 0x00000000 - 0x07FFFFFF (128 MB)
FLASH: 0xFE000000 - 0xFFFFFFFF (32 MB)

In addition, in the address range 0x30000000-0x300000FF, I have a CPLD
mapped.

Now, I wish to access the registers of this CPLD. For this, I create a
module and insert it into the kernel. Now, in my 'init_module' function, I
map the address range 0x30000000-0x300000FF to cpld_mem:

unsigned char *cpld_mem;

int init_module(void)
{
    ...
    ...
    cpld_mem =  (unsigned char *) ioremap (0x30000000, 0x100);
}

Let's say my file operation functions are device_open, device_release,
device_read, device_write and device_ioctl.

Now, I wish to write to the address 0x30000014. In device_write, I do the
following:

ssize_t device_write(...)
{
    ...
    printk(KERN_DEBUG "Writing to CPLD");
    outb(0x00, cpldMem + 0x14);
}

But when I execute this program on the target, it crashes after displaying
"Writing to CPLD". Sometimes it says 'Bus error' and some other times I get
a 'Kernel panic' message and the system reboots.

Where could I be going wrong? I tried with 'writeb()' as well. It gave the
same results. :-( Am I making some obvious silly mistakes?

Regards

Vijay Padiyar

http://www.vijaypadiyar.eu.tf
