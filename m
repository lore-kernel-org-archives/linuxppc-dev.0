Message-ID: <A3E34B558F5CD211B4980008C7A4A99003C5836D@GSO-SPARROW-SRV>
From: "Williams, Kevin M." <kevin.m.williams@marconi.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: CFI flash support for AMD chips
Date: Tue, 14 Aug 2001 08:58:04 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>-----Original Message-----
>From: Amit D Chaudhary [mailto:amitc@brocade.com]
>Sent: Monday, August 13, 2001 10:25 PM
>To: Navin Boppuri
>Cc: Linuxppc-Embedded (E-mail)
>Subject: Re: CFI flash support for AMD chips
>
>
>ls -l /dev/mtd*
>crw-r--r--   1 root     root      90,   0 Jun 11  2001 /dev/mtd0
>crw-r--r--   1 root     root      90,   2 Jun 11  2001 /dev/mtd1
>crw-r--r--   1 root     root      90,  20 Jun 11  2001 /dev/mtd10
>

The char devices are required for the utilities (erase, eraseall, etc.) that
you find in the /util directory.

You also need to have block devices if you want to mount your flash as a
filesystem.

My dev entries:

crw-r--r--   1 0        0         90,   0 Jan  1  1970 mtd0
crw-r--r--   1 0        0         90,   2 Jan  1  1970 mtd1
crw-r--r--   1 0        0         90,   4 Jan  1  1970 mtd2
crw-r--r--   1 0        0         90,   6 Jan  1  1970 mtd3
crw-r--r--   1 0        0         90,   8 Jan  1  1970 mtd4
crw-r--r--   1 0        0         90,  10 Jan  1  1970 mtd5
brw-r--r--   1 0        0         31,   0 Jan  1  1970 mtdblock0
brw-r--r--   1 0        0         31,   1 Jan  1  1970 mtdblock1
brw-r--r--   1 0        0         31,   2 Jan  1  1970 mtdblock2
brw-r--r--   1 0        0         31,   3 Jan  1  1970 mtdblock3
brw-r--r--   1 0        0         31,   4 Jan  1  1970 mtdblock4
brw-r--r--   1 0        0         31,   5 Jan  1  1970 mtdblock5

I believe you will also need to enable:
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLOCK=y

And then just mount the filesystem:

mount -t jffs /dev/mtdblock2 /flash

This should create a jffs filesystem on your flash partition.  You may need
to use the erase utility in the /util directory if the flash is not erased.
There is a HOWTO on the mtd website that explains this in more detail.

Kevin





Matthew Locke wrote:
>
> Navin Boppuri wrote:
>
>> Hello,
>>
>> I am trying to use the CFI flash support for AMD chips. I selected the
>> CFI support in kernel configuration and defined the flash memory map on
>> my board ( CFI Flash device in Physical memory map). I see that CFI is
>> able to find the flash devices on my board correctly. Now, do I need to
>> create a /dev/flash device in the dev directory? What Major, Minor
>> numbers do I use? How do I actually use this driver???
>>
>
> check out the MTD home page. http://www.linux-mtd.infradead.org
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
