From: "Kapil Konde" <kapilkk@yahoo.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: HOWTO: Creating a root file system < 32 MB
Date: Fri, 31 Aug 2001 18:30:55 +0530
Message-ID: <GDEHIPAFEMJDKNFDCIEBGEKKCAAA.kapilkk@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <m15cnZX-001SysC@bucks>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

	Can anybody please tell me how do I create a root filesys for my mpx8xx
target.

Thanks in advance,
Kapil.

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of
diekema_jon
Sent: Friday, August 31, 2001 6:09 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: HOWTO: Creating a root file system < 32 MB



HOWTO: Creating a root file system < 32 MB

Objective:

    Create a Linux root file system that is under 32MB for a MPC8260 target.

Direction:

    The size of the root file system in HardHat Linux, HHL, 2.0 (169MB)
    is significantly larger than that of HHL 1.2 (94MB).  The capabilities
    in the HHL 1.2 root file system, are more than adequate for an embedded
    board.  We will start with all the packages in HHL 1.2, and
    removed the fluff until we hit our target size.

Tools used:

	The following tools were used to determine the purpose and
	files contained in the various packages:

        gnorpm -q <package-name>

        rpm -q -i <package-name>
            Display package information

        rpm -q --list <package-name>
            List files in package.

        rpm -q --docfiles <package-name>
            List only documentation files (implies -l).

1. Obtain the HHL 1.2 packages from MontaVista:

   ftp://ftp.mvista.com/pub/...

   Note: I created a CDROM with *ALL* the packages to make it easy to
         install something that got removed.

2. Mount the HardHat Linux 1.2 PPC CDROM under /mnt/cdrom

3. Install all *.i386.rpm and *.noarch.rpm RPM's

   cd /mnt/cdrom/ppc_82xx/RPMS
   rpm -ihv `find *.i386.rpm *.noarch.rpm | grep -v busybox`
   cd /mnt/cdrom/common
   rpm -ihv *.noarch.rpm

4. The following packages (74) were installed:

hhl-kernel-2.2.14-1.2.2-1
hhl-kernel-2.4.0-test2-1.2.2-1
hhl-ppc_82xx-apache-1.3.12-2
hhl-ppc_82xx-apache-devel-1.3.12-2
hhl-ppc_82xx-apache-html_manual-1.3.12-2
hhl-ppc_82xx-ash-0.2-2
hhl-ppc_82xx-bash-2.03-6
hhl-ppc_82xx-binutils-2.10.0.12-1
hhl-ppc_82xx-bonnie-1-0
hhl-ppc_82xx-c++-2.95.2-13
hhl-ppc_82xx-cpio-2.4.2-1
hhl-ppc_82xx-dhcp-2.0-0
hhl-ppc_82xx-diffutils-2.7-1
hhl-ppc_82xx-e2fsprogs-1.18-1
hhl-ppc_82xx-filesystem-2.0-12
hhl-ppc_82xx-fileutils-4.0-2
hhl-ppc_82xx-findutils-4.1-1
hhl-ppc_82xx-ftp-0.15-4
hhl-ppc_82xx-ftpd-0.11-3
hhl-ppc_82xx-gated-1-1
hhl-ppc_82xx-gawk-3.0.4-1
hhl-ppc_82xx-gcc-2.95.2-13
hhl-ppc_82xx-gdb-5.0-1
hhl-ppc_82xx-gdb-client-5.0-1
hhl-ppc_82xx-gdb-server-5.0-1
hhl-ppc_82xx-getty_ps-2.0.7j-0
hhl-ppc_82xx-glibc-2.1.3-1e
hhl-ppc_82xx-gpm-1.17.9-1
hhl-ppc_82xx-grep-2.4-1
hhl-ppc_82xx-gzip-1.2.4-2
hhl-ppc_82xx-inetd-0.10-6
hhl-ppc_82xx-ipchains-1.3.9-1
hhl-ppc_82xx-kernel-headers-2.4.0-test2-1.2.2-1
hhl-ppc_82xx-ldconfig-1.9.5-2
hhl-ppc_82xx-libstdc++-2.10.0-13
hhl-ppc_82xx-libtermcap-2.0.8-3
hhl-ppc_82xx-modutils-2.1.121-2
hhl-ppc_82xx-netperf-2.1pl3-1
hhl-ppc_82xx-net-tools-1.53-3
hhl-ppc_82xx-pciutils-2.1.8-0
hhl-ppc_82xx-pdisk-0.8a-1
hhl-ppc_82xx-perl-5.00503-6
hhl-ppc_82xx-ping-0.10-6
hhl-ppc_82xx-popt-1.4-1
hhl-ppc_82xx-procps-2.0.4-2
hhl-ppc_82xx-psmisc-18-2
hhl-ppc_82xx-pump-0.7.2-1
hhl-ppc_82xx-pvm-3.4.3-0
hhl-ppc_82xx-sash-3.4-5
hhl-ppc_82xx-sbc8260-lsp-2.4.0-test2-1.2.2-3
hhl-ppc_82xx-sbc8260-lsp-binaries-2.4.0-test2-1.2.2-3
hhl-ppc_82xx-sbc8260-tools-2.4.0-test2-1.2.2-3
hhl-ppc_82xx-sed-3.02-1
hhl-ppc_82xx-sh-utils-2.0-4
hhl-ppc_82xx-sp8240-lsp-2.4.0-test2-1.2.2-2
hhl-ppc_82xx-sp8240-lsp-binaries-2.4.0-test2-1.2.2-2
hhl-ppc_82xx-strace-4.2-1
hhl-ppc_82xx-sysvinit-2.77-6
hhl-ppc_82xx-tar-1.13.11-2
hhl-ppc_82xx-tcpdump-3.4-1
hhl-ppc_82xx-telnet-4.4.2-3
hhl-ppc_82xx-telnetd-0.10-4
hhl-ppc_82xx-termcap-9.12.6-2
hhl-ppc_82xx-textutils-2.0-2
hhl-ppc_82xx-tftp-0.15-2
hhl-ppc_82xx-ucd-snmp-4.1.1-2
hhl-ppc_82xx-ucd-snmp-devel-4.1.1-2
hhl-ppc_82xx-ucd-snmp-utils-4.1.1-2
hhl-ppc_82xx-util-linux-2.10m-1
hhl-ppc_82xx-vi-5.6-1
hhl-ppc_82xx-webs-2.1-4
hhl-ppc_82xx-zlib-1.1.3-2
hhl-remove-1-0
hhl-rpmconfig-0.14-1

dell 345} du -h -s /opt/hardhat/devkit/ppc/82xx/target
94M     /opt/hardhat/devkit/ppc/82xx/target

5. Remove the web server support (~5MB)

rpm --erase hhl-ppc_82xx-apache-html_manual-1.3.12-2
rpm --erase hhl-ppc_82xx-apache-devel-1.3.12-2
rpm --erase hhl-ppc_82xx-apache-1.3.12-2
rpm --erase hhl-ppc_82xx-webs-2.1-4

dell 366} du -h -s /opt/hardhat/devkit/ppc/82xx/target
89M     /opt/hardhat/devkit/ppc/82xx/target

6. Remove the SNMP support (~5MB)

rpm --erase hhl-ppc_82xx-ucd-snmp-utils-4.1.1-2
rpm --erase hhl-ppc_82xx-ucd-snmp-devel-4.1.1-2
rpm --erase hhl-ppc_82xx-ucd-snmp-4.1.1-2

dell 374} du -h -s /opt/hardhat/devkit/ppc/82xx/target
84M     /opt/hardhat/devkit/ppc/82xx/target

7. Removing the Linux Support Packages, LSP, and tools (~5MB)

   We are using the Linux kernels from the BitKeeper repositories
   at bk://ppc.bkserver.net/linuxppc_2_4 and
   bk://ppc.bkserver.net/linuxppc_2_4_devel, so we don't need these
   older Linux bits.

rpm --erase hhl-ppc_82xx-sp8240-lsp-binaries-2.4.0-test2-1.2.2-2
rpm --erase hhl-ppc_82xx-sbc8260-lsp-binaries-2.4.0-test2-1.2.2-3
rpm --erase hhl-ppc_82xx-sp8240-lsp-2.4.0-test2-1.2.2-2
rpm --erase hhl-ppc_82xx-sbc8260-lsp-2.4.0-test2-1.2.2-3
rpm --erase hhl-ppc_82xx-kernel-headers-2.4.0-test2-1.2.2-1
rpm --erase hhl-ppc_82xx-sbc8260-tools-2.4.0-test2-1.2.2-3

dell 391} du -h -s /opt/hardhat/devkit/ppc/82xx/target
79M     /opt/hardhat/devkit/ppc/82xx/target

8. The MPC8260 doesn't have a PCI bus or a hard disk drive

rpm --erase hhl-ppc_82xx-pciutils-2.1.8-0
rpm --erase hhl-ppc_82xx-pdisk-0.8a-1

dell 405} du -h -s /opt/hardhat/devkit/ppc/82xx/target
79M     /opt/hardhat/devkit/ppc/82xx/target

9. We are operating a standalone board, not as a server for other
   networked devices.  We can remove DHCP, gated, ipchains, PVM, etc.
(~16MB)

   We are using PPCBoot to bring up Linux, and it supports DHCP.
   This means that DHCP client support (pump) can also be removed.

rpm --erase hhl-ppc_82xx-dhcp-2.0-0
rpm --erase hhl-ppc_82xx-gated-1-1
rpm --erase hhl-ppc_82xx-ipchains-1.3.9-1
rpm --erase hhl-ppc_82xx-pvm-3.4.3-0
rpm --erase hhl-ppc_82xx-pump-0.7.2-1

dell 442} du -h -s /opt/hardhat/devkit/ppc/82xx/target
63M     /opt/hardhat/devkit/ppc/82xx/target

10. The following Linux kernel source packages can be removed
    since we are using newer bits.  See item 7.

rpm --erase hhl-kernel-2.2.14-1.2.2-1
rpm --erase hhl-kernel-2.4.0-test2-1.2.2-1

dell 464} du -h -s /opt/hardhat/devkit/ppc/82xx/target
63M     /opt/hardhat/devkit/ppc/82xx/target

11. Since we don't have a disk drive, bonnie, a disk r/w perfomance tool
    can be removed.

rpm --erase hhl-ppc_82xx-bonnie-1-0

12. An embedded board doesn't have a mouse.

rpm --erase hhl-ppc_82xx-gpm-1.17.9-1

dell 494} du -h -s /opt/hardhat/devkit/ppc/82xx/target
63M     /opt/hardhat/devkit/ppc/82xx/target

13. The following static libaries can be removed since they are only present
    in the target root file system.  They don't get referenced from inside
of
    /opt/hardhat/devkit/ppc/82xx/powerpc-hardhat-linux/lib/. (~3MB)

-r--r--r--    1 root     root        43688 Aug  8  2000 ./libcom_err.a
-r--r--r--    1 root     root       313350 Aug  8  2000 ./libe2p.a
-r--r--r--    1 root     root      1421020 Aug  8  2000 ./libext2fs.a
-r--r--r--    1 root     root       250526 Aug  8  2000 ./libss.a
-r--r--r--    1 root     root       154044 Aug  8  2000 ./libuuid.a

(cd /opt/hardhat/devkit/ppc/82xx/target/lib;\
 find . -name '*\.a' | egrep 'libcom_err|libe2p|libext2fs|libss|libuuid' |\
 xargs rm)

dell 534} du -h -s /opt/hardhat/devkit/ppc/82xx/target
60M     /opt/hardhat/devkit/ppc/82xx/target

14. Perl is nice to have, but on an embedded board I can
    live without it. (~16MB)

rpm --erase hhl-ppc_82xx-perl-5.00503-6

dell 559} du -h -s /opt/hardhat/devkit/ppc/82xx/target
46M     /opt/hardhat/devkit/ppc/82xx/target

15. Stripping all the files in the target root file system (~19MB)

cd /opt/hardhat/devkit/ppc/82xx/target
find . -type f -exec /opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-strip {} \;

dell 584} du -h -s /opt/hardhat/devkit/ppc/82xx/target
27M     /opt/hardhat/devkit/ppc/82xx/target

16. The following packages (49) are left:

hhl-ppc_82xx-ash-0.2-2
hhl-ppc_82xx-bash-2.03-6
hhl-ppc_82xx-binutils-2.10.0.12-1
hhl-ppc_82xx-c++-2.95.2-13
hhl-ppc_82xx-cpio-2.4.2-1
hhl-ppc_82xx-diffutils-2.7-1
hhl-ppc_82xx-e2fsprogs-1.18-1
hhl-ppc_82xx-filesystem-2.0-12
hhl-ppc_82xx-fileutils-4.0-2
hhl-ppc_82xx-findutils-4.1-1
hhl-ppc_82xx-ftp-0.15-4
hhl-ppc_82xx-ftpd-0.11-3
hhl-ppc_82xx-gawk-3.0.4-1
hhl-ppc_82xx-gcc-2.95.2-13
hhl-ppc_82xx-gdb-5.0-1
hhl-ppc_82xx-gdb-client-5.0-1
hhl-ppc_82xx-gdb-server-5.0-1
hhl-ppc_82xx-getty_ps-2.0.7j-0
hhl-ppc_82xx-glibc-2.1.3-1e
hhl-ppc_82xx-grep-2.4-1
hhl-ppc_82xx-gzip-1.2.4-2
hhl-ppc_82xx-inetd-0.10-6
hhl-ppc_82xx-ldconfig-1.9.5-2
hhl-ppc_82xx-libstdc++-2.10.0-13
hhl-ppc_82xx-libtermcap-2.0.8-3
hhl-ppc_82xx-modutils-2.1.121-2
hhl-ppc_82xx-netperf-2.1pl3-1
hhl-ppc_82xx-net-tools-1.53-3
hhl-ppc_82xx-ping-0.10-6
hhl-ppc_82xx-popt-1.4-1
hhl-ppc_82xx-procps-2.0.4-2
hhl-ppc_82xx-psmisc-18-2
hhl-ppc_82xx-sash-3.4-5
hhl-ppc_82xx-sed-3.02-1
hhl-ppc_82xx-sh-utils-2.0-4
hhl-ppc_82xx-strace-4.2-1
hhl-ppc_82xx-sysvinit-2.77-6
hhl-ppc_82xx-tar-1.13.11-2
hhl-ppc_82xx-tcpdump-3.4-1
hhl-ppc_82xx-telnet-4.4.2-3
hhl-ppc_82xx-telnetd-0.10-4
hhl-ppc_82xx-termcap-9.12.6-2
hhl-ppc_82xx-textutils-2.0-2
hhl-ppc_82xx-tftp-0.15-2
hhl-ppc_82xx-util-linux-2.10m-1
hhl-ppc_82xx-vi-5.6-1
hhl-ppc_82xx-zlib-1.1.3-2
hhl-remove-1-0
hhl-rpmconfig-0.14-1

17. It we don't care about locales, different characters set, etc.
    We can save another ~12MB. This means we could get the root file
    system down to ~15MB.  However, I am happy to stop at 27 MB since
    I hit my goal of being under 32 MB.

1.8M    /opt/hardhat/devkit/ppc/82xx/target/lib/gconv
4.0M    /opt/hardhat/devkit/ppc/82xx/target/share/locale
7.0M    /opt/hardhat/devkit/ppc/82xx/target/share/i18n

18. I kept going with this exercise, and got the root file system down under
    8 MB.  The remaining packages at this point are:

hhl-ppc_82xx-bash-2.03-6
hhl-ppc_82xx-binutils-2.10.0.12-1
hhl-ppc_82xx-c++-2.95.2-13
hhl-ppc_82xx-filesystem-2.0-12
hhl-ppc_82xx-fileutils-4.0-2
hhl-ppc_82xx-gcc-2.95.2-13
hhl-ppc_82xx-gdb-client-5.0-1
hhl-ppc_82xx-getty_ps-2.0.7j-0
hhl-ppc_82xx-glibc-2.1.3-1e
hhl-ppc_82xx-inetd-0.10-6
hhl-ppc_82xx-ldconfig-1.9.5-2
hhl-ppc_82xx-libstdc++-2.10.0-13
hhl-ppc_82xx-libtermcap-2.0.8-3
hhl-ppc_82xx-modutils-2.1.121-2
hhl-ppc_82xx-net-tools-1.53-3
hhl-ppc_82xx-popt-1.4-1
hhl-ppc_82xx-procps-2.0.4-2
hhl-ppc_82xx-psmisc-18-2
hhl-ppc_82xx-sh-utils-2.0-4
hhl-ppc_82xx-sysvinit-2.77-6
hhl-ppc_82xx-telnet-4.4.2-3
hhl-ppc_82xx-telnetd-0.10-4
hhl-ppc_82xx-termcap-9.12.6-2
hhl-ppc_82xx-util-linux-2.10m-1
hhl-ppc_82xx-zlib-1.1.3-2

dell 126} du -s -k /opt/hardhat/devkit/ppc/82xx/target
7853    /opt/hardhat/devkit/ppc/82xx/target

------------------\\----------------------\\----------------------------
Jon Diekema        |                       | Smiths Industries
(616) 241-8310     |                       | 3290 Patterson Avenue, SE
diekema_jon@si.com \\                      \\  Grand Rapids, MI 49512-1991


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
