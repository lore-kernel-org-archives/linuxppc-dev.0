Date: Thu, 1 Feb 2001 20:55:29 -0500
From: "TWG - pat, mark & steve" <twg@world.std.com>
To: jlhagen@collins.rockwell.com
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: trouble creating ramdisk over 8MB - could someone explain this
 to me
In-Reply-To: <OFCB2243A7.F8689577-ON862569E6.00792F78@collins.rockwell.com>
Message-ID: <Pine.SGI.4.21.0102012050110.16709-100000@world.std.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Linux sets the max size of a single ramdisk when it boots.  You can
override this  using the ramdisk_size=10240 argument when you
boot; however you must do this both on your development platform (so you
can make the initial ramdisk) as well as your target (so you can use it).
In any case, you will have to do this for your target; however the
BOOTDISK-HOWTO describes a method using the loop device and a file
(instead of a ramdisk) on your development system so you don't have to
change your devel sys's ramdisk size.
(on your target system you can also modify rd.c to change the default
size. -- Sorry, don't have the exact path handy)
Linux spits out a message when booting like "creating 16 ramdisks of
size xxx", so you can check whether you were successful.

Mark Phillips

On Thu, 1 Feb 2001 jlhagen@collins.rockwell.com wrote:

>
> Hello,
>
> I'm trying to set up a 10MB ramdisk for our VME boards. I'm running in to
> this
>
> dd if=/dev/zero of=/dev/ram bs=1k count=10240
> dd: /dev/ram: No space left on device
> 8193+0 records in
> 8192+0 records out
>
> and
>
> mke2fs -vm0 /dev/ramdisk 10240
> mke2fs 1.18, 11-Nov-1999 for EXXT2 FS 0.5b, 95/08/09
> mke2fs: Filesystem larget than apparent filesystem size.
> Proceed anyway? (y,n)
>
> For 8MB dd and mke2fs don't give me problems and changing
> drivers/block/rd.c rd_size to 8192 works as expected but I can't
> figure out why larger than 8 gives me problems.
>
> I would appreciate the help.
> John
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
