Return-Path: <vijay_padiyar@hotmail.com>
Received: from hotmail.com (bay1-dav10.bay1.hotmail.com [65.54.244.114])
	by ozlabs.org (Postfix) with ESMTP id 7E0B467A46
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Feb 2005 01:16:02 +1100 (EST)
Message-ID: <BAY1-DAV107BFA9E5ADCAD5B97A0118B770@phx.gbl>
From: "Vijay Padiyar" <vijay_padiyar@hotmail.com>
To: "Embedded TUX" <etux@embeddedtux.org>,
	"LinuxPPC Support" <linuxppc-embedded@ozlabs.org>
Date: Fri, 11 Feb 2005 19:46:35 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: query regarding access of physical memory from user space
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

I am a bit new to Linux and therefore am unable to appreciate exactly the
use of various techniques used to map physical memory to user or kernel
space. I have come across functions like ioremap(), remap_page_range(), etc.
I am still a _bit_ confused as to exactly what to use for our purpose.

I have an MPC8260 target with 128 MB SDRAM (0x00000000 - 0x07FFFFFF), 32 MB
FLASH (0xFE000000 - 0xFFFFFFFF). In between, I have some CPLDs and FPGAs
mapped at various physical addresses. I wish to access these devices from a
user program or from a device driver inserted into the kernel.

Please tell me how do I go about it?

What I have done right now is to use ioremap() to remap a section of
physical memory to kernel virtual memory and try to use it.

For example, we have a CPLD whose registers we wish to manipulate. These
registers lie in the address range 0x30000000 - 0x300000FF. I map this range
as follows:

unsigned char *cpld_mem;

cpld_mem = (unsigned char *)ioremap(0x30000000, 0x100);

Is this correct? After I do this, can I write to and read from the physical
memory locations 0x30000000-0x300000FF using writeb() and readb()? Or do I
have to use outb() and inb()?

Please do clarify my doubts. Also, what is the *highest memory address* as
well as *maximum memory size* that I can map to kernel or user space using
ioremap()?

In other words, can I map any address in the 32-bit address space to kernel
virtual space using ioremap()? Also, what chunk size of memory can I map in
one go?

Please give me some ideas regarding my doubts. I need to get finished with
the driver soon.

Regards

Vijay Padiyar

http://www.vijaypadiyar.eu.tf
