From: Jan.Rovins@radisys.com
To: "Michael Meriin" <Michael@KSWaves.com>
Cc: "Chuck Partridge" <Chuck_Partridge@amx.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: AMD Flash Interface for updating boot flash
MIME-Version: 1.0
Message-ID: <OF614E27C2.DDB5DF60-ON85256BE4.006C0DFB@radisys.com>
Date: Wed, 26 Jun 2002 15:49:28 -0400
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
