To: "PAULO SELEME CORREA PAULO" <paulo.correa@siemens.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ramdisk initrd 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 18 Oct 2001 18:14:53 -0300."
             <sbcf1c29.035@siemens.com.br>
Date: Fri, 19 Oct 2001 00:13:06 +0200
Message-Id: <20011018221311.B465D10CC5@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <sbcf1c29.035@siemens.com.br> you wrote:
>
> I am sorry if I sound a bit repetitive but can anyone tell me what
> are the steps to be followed to load a ramdisk image into the target
> board RAM . What am I supposed to set for initrd to work?

Did you RTFM? Really?

> I was able to create the RAMDISK image with the scripts posted in
> this forum but I got a bit lost about the settings to be made to load
> the correct ramdisk image file into memory. I am using PPcboot1.0.5
> and a RPXClassic board .

The PPCBoot "README" says:

...
Similar you can build PPCBoot images from a 'ramdisk.image.gz' file
when your kernel is intended to use an initial ramdisk:

        -> tools/mkimage -n 'Simple Ramdisk Image' \
        > -A ppc -O linux -T ramdisk -C gzip \
        > -d /LinuxPPC/images/SIMPLE-ramdisk.image.gz examples/simple-initrd
        Image Name:   Simple Ramdisk Image
        Created:      Wed Jan 12 14:01:50 2000
        Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
        Data Size:    566530 Bytes = 553.25 kB = 0.54 MB
        Load Address: 0x00000000
        Entry Point:  0x00000000
...
If you want to boot a Linux kernel with initial ram disk, you pass
the memory addreses of both the kernel and the initrd image (PPBCOOT
format!) to the "bootm" command:
...
        => bootm 40100000 40200000
        ## Booting Linux kernel at 40100000 ...
           Image Name:   2.2.13 for initrd on TQM850L
           Image Type:   PowerPC Linux Kernel Image (gzip compressed)
           Data Size:    335725 Bytes = 327 kB = 0 MB
           Load Address: 00000000
           Entry Point:  0000000c
           Verifying Checksum ... OK
           Uncompressing Kernel Image ... OK
        ## Loading RAMDisk Image at 40200000 ...
           Image Name:   Simple Ramdisk Image
           Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
           Data Size:    566530 Bytes = 553 kB = 0 MB
           Load Address: 00000000
           Entry Point:  00000000
           Verifying Checksum ... OK
           Loading Ramdisk ... OK
        Linux version 2.2.13 (wd@denx.local.net) (gcc version 2.95.2 19991024 (release)) #1 Wed Jul 19 02:32:08 MEST 2000
...




Can you please explain which parts  of  this  description  you  don't
understand?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Nothing is easier than to denounce  the  evildoer;  nothing  is  more
difficult than to understand him.                 - Fyodor Dostoevski

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
