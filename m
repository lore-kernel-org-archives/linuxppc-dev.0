Date: Sun, 4 Jul 2004 01:33:37 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: kernel build failures with gcc 3.3.3 and newer, Inconsistent kallsyms data, try setting CONFIG_KALLSYMS_EXTRA_PASS
Message-ID: <20040703233337.GA7144@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


linux-2.6.7-bk16 has a new kallsyms check. This check fails with gcc
newer than 3.3.2. It passes with 3.4.1 and the hammer branch.

all symbols are 0x10 off with gcc 3.3.3, like:

 diff -u System.map .tmp_System.map |  grep tcp_hashinfo
-c032f4e0 D tcp_hashinfo
+c032f500 D tcp_hashinfo

the intial nm -n output has only these differences:

 cut -b 10- gcc332/nm-m-.tmp_vmlinux1 > 2.o
 cut -b 10- gcc333/nm-m-.tmp_vmlinux1 > 3.o
 diff -u 2.o 3.o
--- 2.o 2004-07-04 01:28:31.938466375 +0200
+++ 3.o 2004-07-04 01:28:34.877522576 +0200
@@ -8510,8 +8510,8 @@
 t cdrom_read_cdda_old
 t cdrom_read_cdda_bpc
 t cdrom_read_cdda
-T cdrom_ioctl
 a Hash_base
+T cdrom_ioctl
 t cdrom_switch_blocksize
 t mmc_ioctl
 t cdrom_get_track_info
@@ -30838,8 +30838,8 @@
 t af_unix_init
 t packet_init
 t init_sunrpc
-T _einittext
 t __setup_str_nosmp
+T _einittext
 t __setup_str_maxcpus
 t __setup_str_profile_setup
 t __setup_str_debug_kernel



--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
