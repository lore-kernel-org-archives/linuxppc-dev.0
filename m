From: Ruedi.Hofer@ascom.ch
Date: Thu, 03 Feb 2000 16:39:30 +0100 (CET)
Subject: initrd
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <0FPD00LDV2DPNM@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_4GUJaszyQMgWB48sXhaxrQ)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



--Boundary_(ID_4GUJaszyQMgWB48sXhaxrQ)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi

Is there something wrong with the mapping???

Boot message in case of failure..

loaded at:     0011C000 001271BC
relocated to:  00100000 0010B1BC
board data at: 00FF0000 00FF001C
relocated to:  00200100 0020011C
zimage at:     00122000 00182FEC
initrd at:     00182FEC 00236655
avail ram:     00237000 01000000


Did you change something in this part of the Makefile (in mbxboot) to get it working?

zvmlinux.initrd: zvmlinux
        $(LD) $(ZLINKFLAGS) -o zvmlinux.initrd.tmp $(OBJECTS)
        $(OBJCOPY) $(OBJCOPY_ARGS) -R .comment \
                --add-section=initrd=ramdisk.image.gz \
                --add-section=image=../coffboot/vmlinux.gz \
                zvmlinux.initrd.tmp zvmlinux.initrd
        $(CC) $(CFLAGS) -DINITRD_OFFSET=`sh offset $(OBJDUMP)
zvmlinux.initrd initrd` \
                -DINITRD_SIZE=`sh size $(OBJDUMP) zvmlinux.initrd
initrd` \
                -DZIMAGE_OFFSET=`sh offset $(OBJDUMP) zvmlinux.initrd
image` \
                -DZIMAGE_SIZE=`sh size $(OBJDUMP) zvmlinux.initrd image`
\
                -c -o misc.o misc.c
        $(LD) $(ZLINKFLAGS) -o zvmlinux.initrd.tmp $(OBJECTS)
        $(OBJCOPY) $(OBJCOPY_ARGS) -R .comment \
                --add-section=initrd=ramdisk.image.gz \
                --add-section=image=../coffboot/vmlinux.gz \
                zvmlinux.initrd.tmp $@
        rm zvmlinux.initrd.tmp



Any ideas?

TIA
\Ruedi








--Boundary_(ID_4GUJaszyQMgWB48sXhaxrQ)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
