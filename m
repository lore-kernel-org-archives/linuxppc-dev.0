To: "Sangmoon Kim" <dogoil@etinsys.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: File System on 64-bit-bus-width Flash memory 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 14 May 2002 20:05:53 +0900."
             <000b01c1fb37$50751cf0$1a11efcb@industrialDiv.hanasys.co.kr>
Date: Tue, 14 May 2002 13:13:31 +0200
Message-Id: <20020514111336.A39B411960@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <000b01c1fb37$50751cf0$1a11efcb@industrialDiv.hanasys.co.kr> you wrote:
>
> Hi,
> I want to make a flash file system on a custom MPC755 board with a 64-bit (bus width) flash memory.
> I set CONFIG_MTD_PHYSMAP_BUSWIDTH = 8 at kernel configure, and when it boots the following message appears.
>
> physmap flash device: 400000 at 7c000000
> genprobe_new_chip called with unsupported buswidth 8

Seems your MTD drivers are missing support for 64 bit buswidth.

> Is it possible to make a flash file system with a flash memory of  64 bit bus width? If possible, what's the method? Please let me know.

We implemented this long ago. See our kernel source tree at
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/

For example:

...
TQM8260 flash bank 0: Using static image partition definition
Creating 4 MTD partitions on "TQM8260 Bank 0":
0x00000000-0x00040000 : "ppcboot"
0x00040000-0x00100000 : "kernel"
0x00100000-0x00400000 : "initrd"
0x00400000-0x00800000 : "jffs"
...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
There are two ways to write error-free programs. Only the  third  one
works.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
