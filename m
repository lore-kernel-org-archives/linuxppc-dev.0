From: Jan.Rovins@radisys.com
To: "Chuck Partridge" <Chuck_Partridge@amx.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: AMD Flash Interface for updating boot flash
MIME-Version: 1.0
Message-ID: <OF680CB3D8.0536364E-ON85256BE4.007B3668@radisys.com>
Date: Wed, 26 Jun 2002 19:00:09 -0400
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Chuck,

The newer MTD versions may have more/different config options than  the
documented examples floating around.
but here is some tips off the top of my head:

You should set :
CONFIG_MTD_CFI
CONFIG_MTD_AMDSTD
and choose the geometry support for the buswidth/interleave of your flash
bank.

set CONFIG_MTD_CHAR for raw access,
CONFIF_MTD_BLOCK if you want to mount a flash file system

and specify a Mapping.
Basically, if your board is from a well known vendor, there may be a
"Mapping Driver" already written for it,
so you should go with that.

if you have a custom board, you may be able to go without a mapping driver
if you specify the correct physical mapping
CONFIG_MTD_PHYSMAP and fill in the details of your hardware

If you just need to store a single image, you wont need partitions, if you
want a boot image and a flash file system, or backup
copies of the previous boot image, then partitions are the way to go.

If you need to have partitions, you will have to write your own mapping
driver, because the partition sizes are specified there,
just pick a pre-existing mapping driver that is close to your board/flash
then cut & paste & hack away.
(There may be newer versions of MTD that let you specify partitions from
the .config file, I am not sure of this)


After you try the above, and MTD still cant find your flash, the folks on
the MTD list can take it from there.

one last warning:
certain versions of the 2.4 kernel have non stable versions of mtd,  you
may be guided to download a stable
snapshot from their website.

Jan




"Chuck Partridge" <Chuck_Partridge@amx.com>
Sent by: owner-linuxppc-embedded@lists.linuxppc.org
06/26/2002 04:23 PM


        To:     <Michael@KSWaves.com>, <Jan.Rovins@radisys.com>
        cc:     <linuxppc-embedded@lists.linuxppc.org>
        Subject:        Re: AMD Flash Interface for updating boot flash



Where do you set this up? If I want to use partitions, where do I put the
info on how it is partitioned?

I modified the kernel .config and it gives me the following startup
messages:

physmap flash device: 80000 at fff00000
CFI: Found no Physically mapped flash device at location zero

I'll check out the MTD list.

Chuck
>>> <Jan.Rovins@radisys.com> 06/26/02 02:49PM >>>
I agree that MTD is the way to go, but with one small change to Michael's
instructions.

configure MTD for  char driver support, and do
dd if=bootloader of=/dev/mtd0

/dev/mtd0 is a raw char device that is best to write a binary boot image
to flash,
/dev/mtdblock0 is a block device that is best for file system images,
which can then be mounted.

You can get expert advice from the MTD list:

http://lists.infradead.org/mailman/listinfo/linux-mtd/

Jan




"Michael Meriin" <Michael@KSWaves.com>
Sent by: owner-linuxppc-embedded@lists.linuxppc.org
06/26/2002 12:17 PM


        To:     "Chuck Partridge" <Chuck_Partridge@amx.com>,
<linuxppc-embedded@lists.linuxppc.org>
        cc:
        Subject:        Re: AMD Flash Interface for updating boot flash



Just define your flash as a MTD device and then, from user space use dd
command to copy your bootloader to flash:

dd if=bootloader of=/dev/mtdblock0

Best Regards,
                     Michael Meriin


----- Original Message -----
From: "Chuck Partridge" <Chuck_Partridge@amx.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, June 26, 2002 17:09
Subject: AMD Flash Interface for updating boot flash


>
> Hello all,
>
> I have been searching the archives and I am a bit confused, so bear with
me if this is too simple a question.
>
> I need to provide a way to update my boot flash from user space.
> Our user application will download an boot flash image and save it (to a
file or a buffer), we must then write the flash.
> I have seen references in the archives to Denx's
drivers/char/amd_flash.c
and to MTD drivers, or I can
> implement my own driver, but I'm not sure of the best (i.e. easiest and
cleanest) way.
>
> I don't need to put a file system on the flash.  All it does is hold the
PPCBoot image.  The flash part is an AMD
> 29LV004B and is setup for 8 bit interface.  I am running a 2.4.17 kernel
on an 8245.
>
> Any suggestions?
>
> Thanks,
>
> Chuck
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
