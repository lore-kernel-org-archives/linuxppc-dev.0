Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BB17FDDDCF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Feb 2007 17:33:05 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HHDhK-0001SW-4i
	for linuxppc-embedded@ozlabs.org; Wed, 14 Feb 2007 07:32:58 +0100
Received: from dsl-202-45-109-210-static.VIC.netspace.net.au ([202.45.109.210])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 14 Feb 2007 07:32:58 +0100
Received: from daniel_ng11 by dsl-202-45-109-210-static.VIC.netspace.net.au
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 14 Feb 2007 07:32:58 +0100
To: linuxppc-embedded@ozlabs.org
From: Daniel Ng <daniel_ng11@lycos.com>
Subject: 'make' behaviour in BuildRoot
Date: Wed, 14 Feb 2007 06:32:46 +0000 (UTC)
Message-ID: <loom.20070214T072955-792@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Currently I have a working build system using BuildRoot, but it needs to be 
more efficient.

In particular, when I run the BuildRoot 'make', I end up with the final cramfs 
image which is great!

However, if I want to add a new file to the Root FS (eg. if I want to add the 
file 'test23' to '/usr') it seems that I have to do a 'make clean' first, and 
then run 'make' ie. a full rebuild.

This is because if I add the 'test23' file 
to 'target/generic/target_skeleton/usr' and then just run 'make' I get the 
output at the bottom of this post [1].

-in other words it seems that the old 'build_powerpc/root' directory is used to 
rebuild the cramfs image. The file 'test23' was never added 
to 'build_powerpc/root'.

-if I remove 'build_powerpc/root' and then run 'make', I get a script error 
that seems completely unrelated to my change. However the 'test23' file does 
appear in 'uild_powerpc/root'. Here is the tail of the output-


# Use fakeroot so mkcramfs believes the previous fakery
/home/dng/linuxppc/gcc-4.0.2_uclibc/usr/bin/fakeroot \
        -i /home/dng/linuxppc/gcc-4.0.2_uclibc/fakeroot.env \
        -s /home/dng/linuxppc/gcc-4.0.2_uclibc/fakeroot.env -- \
        /home/ppcroot/swdev/buildroot-dng/build_powerpc/cramfs-1.1/mkcramfs -q -
b \
        /home/ppcroot/swdev/buildroot-
dng/build_powerpc/root /home/ppcroot/swdev/buildroot-dng/rootfs.powerpc.cramfs
Swapping filesystem endian-ness
mkcramfs: /home/ppcroot/swdev/buildroot-dng/build_powerpc/cramfs-
1.1/mkcramfs:/home/ppcroot/swdev/buildroot-
dng/build_powerpc/root/bin/fw_printenv: Invalid argument
mkcramfs: /home/ppcroot/swdev/buildroot-dng/build_powerpc/cramfs-
1.1/mkcramfs:/home/ppcroot/swdev/buildroot-dng/build_powerpc/root/bin/pppd: 
Invalid argument
mkcramfs: scandir failed: /home/ppcroot/swdev/buildroot-
dng/build_powerpc/root/bin/sethdlc
make: *** [cramfsroot] Error 8


Surely I shouldn't have to do a full BuildRoot rebuild (although it does work) 
just to add a new file to the Root FS?? 

Is there a way in BuildRoot to avoid having to do a full rebuild just for 
adding a single new file to the Root FS? (Maybe deleting 'build_powerpc/root' 
is the wrong thing to do, hence the above errors)



Here is the output as descibed in [1] above-


`/home/ppcroot/swdev/buildroot-dng/build_powerpc/ppp-2.4.1/.unpacked'
package/pppd/pppd.mk:20: warning: ignoring old commands for target 
`/home/ppcroot/swdev/buildroot-dng/build_powerpc/ppp-2.4.1/.configured'
package/pppd/pppd.mk:31: warning: ignoring old commands for target 
`/home/ppcroot/swdev/buildroot-dng/build_powerpc/ppp-2.4.1/.configured'
package/pppd/pppd.mk:52: warning: ignoring old commands for target 
`/home/ppcroot/swdev/buildroot-dng/build_powerpc/ppp-2.4.1/pppd/pppd'
package/pppd/pppd.mk:55: warning: ignoring old commands for target 
`/home/ppcroot/swdev/buildroot-dng/build_powerpc/root/usr/sbin/pppd'
package/pppd/pppd.mk:62: warning: ignoring old commands for target `pppd-clean'
package/pppd/pppd.mk:69: warning: ignoring old commands for target `pppd-
dirclean'
#-@find /home/ppcroot/swdev/buildroot-dng/build_powerpc/root/lib -type f -name 
\*.so\* | xargs /home/dng/linuxppc/gcc-4.0.2_uclibc/bin/powerpc-linux-uclibc-
strip --remove-section=.comment --remove-section=.note --strip-unneeded 
2>/dev/null || true;
/sbin/ldconfig -r /home/ppcroot/swdev/buildroot-dng/build_powerpc/root 
2>/dev/null
# Use fakeroot to pretend all target binaries are owned by root
/home/dng/linuxppc/gcc-4.0.2_uclibc/usr/bin/fakeroot \
        -i /home/dng/linuxppc/gcc-4.0.2_uclibc/fakeroot.env \
        -s /home/dng/linuxppc/gcc-4.0.2_uclibc/fakeroot.env -- \
        chown -R root:root /home/ppcroot/swdev/buildroot-dng/build_powerpc/root
# Use fakeroot to pretend to create all needed device nodes
/home/dng/linuxppc/gcc-4.0.2_uclibc/usr/bin/fakeroot \
        -i /home/dng/linuxppc/gcc-4.0.2_uclibc/fakeroot.env \
        -s /home/dng/linuxppc/gcc-4.0.2_uclibc/fakeroot.env -- \
        /home/dng/linuxppc/gcc-4.0.2_uclibc/bin/makedevs \
        -d target/generic/device_table.txt \
        /home/ppcroot/swdev/buildroot-dng/build_powerpc/root
rootdir=/home/ppcroot/swdev/buildroot-dng/build_powerpc/root
table='target/generic/device_table.txt'
# Use fakeroot so mkcramfs believes the previous fakery
/home/dng/linuxppc/gcc-4.0.2_uclibc/usr/bin/fakeroot \
        -i /home/dng/linuxppc/gcc-4.0.2_uclibc/fakeroot.env \
        -s /home/dng/linuxppc/gcc-4.0.2_uclibc/fakeroot.env -- \
        /home/ppcroot/swdev/buildroot-dng/build_powerpc/cramfs-1.1/mkcramfs -q -
b \
        /home/ppcroot/swdev/buildroot-
dng/build_powerpc/root /home/ppcroot/swdev/buildroot-dng/rootfs.powerpc.cramfs
Swapping filesystem endian-ness


Cheers,
Daniel
