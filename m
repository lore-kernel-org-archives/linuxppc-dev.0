Message-ID: <35913.216.110.51.8.1078505136.squirrel@www.orkun.us>
In-Reply-To: <00a101c40291$c31a7120$0400a8c0@portatile>
References: <20040304110742.949A1C0655@atlas.denx.de>
    <00a101c40291$c31a7120$0400a8c0@portatile>
Date: Fri, 5 Mar 2004 10:45:36 -0600 (CST)
Subject: Re: "mkimage" not found
From: "listmember@orkun.us" <listmember@orkun.us>
To: "Ing.Gianfranco Morandi (LAN)" <gianfranco.morandi@euro-studio.it>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


AFAIK, uImage target does not exist for all linuxppc sources. I got my
kernel sources from PenguinPPC bitkeeper so it does not have it. I just
build vmlinux target and use the following steps to generate uImage (which
is documented in U-Boot documentation)

(taken from my shell script that automates this stuff)

${CROSS_COMPILE}objcopy -O binary -R .note -R .comment -S vmlinux vmlinux.bin
gzip -9 vmlinux.bin
$MKIMAGE -n "Linux Image" -A ppc -O linux -T kernel -C gzip -a 0 -e 0 \
        -d vmlinux.bin.gz" uImage


>
> Dear Wolfgang
>
>> Maybe your PATH ist not correct?
>
> You are perfectly right! I didn't add the line "export
> PATH=$PATH:/opt/eldk/usr/bin"  to .bashrc.
> Many thanks
>
>> > With the previous ELDK2.0 I would have generated the image with the
> "make
>> > pImage" command while now I suppose the command "make uImage" must be
> used.
>> > Is this correct?
>>
>> This is correct, but "make pImage" will still work, too.
>
> unfortunately I had the following messages:
>
> [gianfranco@home001 linux]$ make pImage
> make: *** No rule to make target `pImage'.  Stop.
> [gianfranco@home001 linux]$ grep -r pImage *
> arch/ppc/boot/Makefile:pImage: $(MKIMAGE) images/vmlinux.gz
> [gianfranco@home001 linux]$ grep -r uImage *
> arch/ppc/boot/Makefile:uImage  \
> arch/ppc/boot/Makefile: ln -sf vmlinux.UBoot images/uImage
> arch/ppc/Makefile:BOOT_TARGETS = zImage zImage.initrd znetboot
> znetboot.initrd uImage
> CHANGELOG:Add support for U-Boot boot image "uImage"
> [gianfranco@home001 linux]$
>
>
> Should I modify BOOT_TARGET into arch/ppc/Makefile?
>
> Best regards
> Gianfranco
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
