Message-ID: <000e01c29a17$46cfbd20$faffa8c0@VISHWANATH>
From: "Vishwanath" <vishwanath@mistralsoftware.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: <akuster@mvista.com>
Subject: Device Accessing Problem in 440GP
Date: Mon, 2 Dec 2002 20:57:08 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I am working on IBM 440GP based proprietry board using MVL 2.1 linux. I have
a device siiting on the EBC at 0x100100000 and I want to access it from the
user space. I use mmap call of my driver to do that. I have not initialized
the device. I have set the access parameters and controller registers of EBC
appropriately to access the device.

But when I make ioremap() call using,

 ioremap64(0x100100000, 0x2000),

the function returns a  valid pointer. But when I do a sample write and
read, I am not getting correct values. While I was debigging, I couldn't
find the TLB entry for the real address.

When I try to access the returned mmap() pointer, kernel says ,
do_wp_page: bogus page at address xxxx (page yyyy)

VM: killing process xxx

Does anyone know what could be the reason?

1. Do I  have to initialize the device in setup_arch function ?
2. Do I have to explicitly create a TLB entry for the device ?

Hoping to get a response. I am stuck in the middle.

Thanks and regards,
Vishwa

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
