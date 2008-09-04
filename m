Return-Path: <dzu@denx.de>
From: Detlev Zundel <dzu@denx.de>
To: s104259@yahoo.it
Subject: Re: Boot 2.6.26 (or similar) on mpc5200 using powerpc
References: <90069.85628.qm@web23105.mail.ird.yahoo.com>
Date: Thu, 04 Sep 2008 16:47:40 +0200
In-Reply-To: <90069.85628.qm@web23105.mail.ird.yahoo.com> (Angelo's message of
	"Thu, 4 Sep 2008 13:08:06 +0000 (GMT)")
Message-ID: <m2tzcwdl2r.fsf@ohwell.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Angelo,

>> > 2 - make cuImage.lite5200b ARCH=powerpc
>> CROSS_COMPILE=powerpc-linux-gnu-
>> 
>> Well, this is debatable.  Here you explicitely request a
>> backward
>> compatability wrapped uImage (for firmwares being FDT
>> ignorant):
>> 
>
> Can i use also $ make uImage ... ?! Or only cuImage!?

Maybe I was unclear - "make uImage" generates a regular kernel image for
an FDT aware U-Boot, whereas "make cuImage" wraps the FDT blob _into_
the cuImage so that even old non-FDT aware U-Boots can boot the kernel.

But this option of course uses a wrapper for the kernel which sometimes
exhibits behaviour different from what one sees when booting a regular
uImage + dtb.  Of course these are bugs and should be fixed.

>> So in 2.6.26 I'd advise you to do a "make
>> uImage" + "make lite5200b.dtb"
>> and use the results in a recent U-Boot.
>
> But lite5200b.dtb doesn't exist. So i'm looking for it and i known
> that i had to generate it using this command:
>
> $ arch/powerpc/boot/dtc -b0 -Idts -Odtb -V16 arch/powerpc/boot/dts/lite5200b.dts > lite5200b.dtb

> I'm wrong?!

Not really, but you could also simply follow my advise - use a current
kernel, trust me, type "make lite5200b.dtb" and rejoice.

> So at this point i've got dtb, but somwhere i saw that it's necessary
> to download lite5200.dtb to the system...
>
> And at this point I try to boot the board:
>
> 1. usb start
> 2. usb scan
> 3. fatload usb 0 0xfc000000 cuImage.lite5200b
> (3. fatload usb 0 0xfc000000 uImage - if i use make uImage)
> 4. fatload usb 0 0xfd000000 rootfs.uimage
> 5. fatload usb 0 0x???????? lite5200b.dtb
> 6. bootm 0xfc000000 0x????????
>
> However my uboot version is 1.2.0. 

Uh right, U-Boot for lite5200 has fdt support since 1.1.6, but I still
advise to use a more recent U-Boot as a lot changed in this area.  If
you have a recent U-Boot, you'll need to use the three parameter version
of bootm - i.e. <kernel addr> <ramdisk addr> <fdt addr>.  A "-" for the
ramdisk is ok if you do not intend to use a ramdisk.

Cheers
  Detlev

-- 
Every generation laughs at the old fashions, but follows religiously
the new.
                                        -- Henry David Thoreau
--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
