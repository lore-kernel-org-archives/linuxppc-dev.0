Date: Wed, 13 Aug 2003 09:51:08 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: linuxppc-2.5 CONFIG_BOOT_LOAD undefined
Message-ID: <20030813075108.GA25714@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


/usr/bin/time make oldconfig zImage modules modules_install INSTALL_MOD_PATH=`pwd` &>log

olaf@mango:~/linux-2.6.0-test3-lxppc25> tail log
        --set-section-flags=.image=contents,alloc,load,readonly,data \
        arch/ppc/boot/simple/dummy.o arch/ppc/boot/simple/image.o
ld -T arch/ppc/boot/ld.script -Ttext  -Bstatic -o arch/ppc/boot/simple/zvmlinux arch/ppc/boot/simple/head.o arch/ppc/boot/simple/relocate.o arch/ppc/boot/simple/misc.o arch/ppc/boot/simple/image.o arch/ppc/boot/common/lib.a arch/ppc/boot/lib/lib.a
ld: invalid hex number `-Bstatic'
make[2]: *** [arch/ppc/boot/simple/zvmlinux] Error 1
make[1]: *** [simple] Error 2
make: *** [zImage] Error 2
Command exited with non-zero status 2
1375.30user 103.63system 24:56.21elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1591311major+1490305minor)pagefaults 0swaps
olaf@mango:~/linux-2.6.0-test3-lxppc25> grep -wr CONFIG_BOOT_LOAD .config
CONFIG_BOOT_LOAD=0x00800000


-Ttext wants an address, arch/ppc/boot/simple/Makefile does not include
the .config for some reasons.


--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
