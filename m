Date: Tue, 22 Jul 2003 09:58:40 +1200
From: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Subject: Re: Problem with starting up 2.4.21 kernel
In-reply-to: <1058776120.17484.24.camel@localhost.localdomain>
To: Sung <mikegas@tm.net.my>
Cc: Robin Gilks <robin.gilks@tait.co.nz>,
	linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
Message-id: <3F1C6210.1080800@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <3F0B9F69.1030801@tait.co.nz>
 <1058776120.17484.24.camel@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>
>Hav you solve this problem?? Can I know what wrong with it because my
>kernel also acting up the same about the samething.
>
Yes, we resolved this problem.
First of all there was problem with ramdisk - it should have a header.
We used this makefile to generate proper ramdisk.

initrd.mk:

STAGING_DIR=.
TARGET_DIR=root

#############################################################
#
# make an initrd image - assumes all the tools are available
#
#############################################################

# this comes from the u-boot project!!
MKIMAGE=/usr/bin/mkimage
MNTPOINT:=$(STAGING_DIR)/mnt

$(MNTPOINT):
    mkdir -p $(MNTPOINT)


#############################################################
#
# Build the ramfs root filesystem image
#
#############################################################



ramdisk.image.gz: $(TARGET_DIR) $(MNTPOINT)
    dd if=/dev/zero of=ramdisk.img bs=1024 count=2048
    /sbin/mkfs.ext2 -N 500 ramdisk.img -F
    sudo mount -o loop ramdisk.img $(MNTPOINT)
    cp -R $(TARGET_DIR)/* $(MNTPOINT)
    sudo umount $(MNTPOINT)
    cat ramdisk.img | gzip -9 -c > ramdisk.image.gz
    rm -f ramdisk.img

initrd:    ramdisk.image.gz
    $(MKIMAGE) -n 'Simple Ramdisk Image' \
     -A ppc -O linux -T ramdisk -C gzip \
     -d ramdisk.image.gz initrd
     rm -f ramdisk.image.gz

Call it "make -f initrd.mk initrd"

You should get a initrd file as output of this makefile - this what you
want. You just need to pick up a mkimage from u-boot project.

Also you should pass clocks in HZ. For this make sure that you have
undefined in u-boot clocks_in_*mhz* environment variable. Use printenv
in u-boot to make sure it is not present.

When you will get to the point when you start a busybox (if you use one)
then it could stuck if /dev has no all nodes required.

Hopefully this helps.

>After "Transferring control to Linux (at address 00000000)" nothing seems happen (see below).
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
