From: Ruedi.Hofer@ascom.ch
Date: Tue, 01 Feb 2000 07:55:27 +0100 (CET)
Subject: Re: RomFS
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <0FP80082SOL8BN@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_Jcmn68Sw9ge1vRIJ3u6yDg)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



--Boundary_(ID_Jcmn68Sw9ge1vRIJ3u6yDg)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi

That sounds good and it works. snip

But how can I mount this rom/ramdisk from the kernel as its root disk?

What do I have to supply as boot parameter?

I would like to store the entire application in the flash (kernel + application)

\Ruedi




damm@kieraypc01.p.y.ki.era.ericsson.se on 31.01.2000 16:23:22
An: Ruedi.Hofer@ascom.ch @ MailGate
Kopie:
Thema: Re: RomFS


> Hi,

Hi!

> My ADS board is happily running with a NFS mounted linux box.

Great!

> Now I have to put all the code into the flash memory to get a standalone
> solution.
>
> I'm using the 8xxrom Bootloader. In a file called config.h I can configure
> CONFIG_DISK_ROM.  As far as I can see, the bootloader assumes
> then that a complete FAT filesystem is stored from the position
> 0xFE020000 in flash.
>
> My question:
> - Is my assumption right?

Well, there is a file in the disk directory called rom.c.
It is a simple read-only block driver for 8xxrom.
It does not know anything about filesystems, so you can use any filesystem you want
as long it is supported by 8xxrom.

In rom.h can you find a define called ROM_DISKSTART which is the start address
of the filesystem.

> - How can I produce a FAT filesystem in a file, which I can download
>   with MPC8BUG into the onboard flash?

You have to look somewhere on the net.
I usually create a ramdisk and make a filesystem and copy my things to it.
Then I umount it and use dd to copy the data to a file which I burn to
a flash.

> - Does it have anything in common with the romfs driver which is supported
>   by the kernel? (I think not)

Nope.
But it would sure be great if we could read one romfs image from the 8xxrom.

Good luck /

magnus





--Boundary_(ID_Jcmn68Sw9ge1vRIJ3u6yDg)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
