Content-Type: text/plain;
  charset="us-ascii"
From: Remco Treffkorn <remco@rvt.com>
Reply-To: remco@rvt.com
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Symbol versioning problem
Date: Wed, 10 Jul 2002 14:29:39 -0700
MIME-Version: 1.0
Message-Id: <200207101429.39539.remco@rvt.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am compiling a recent benh kernel. After the build the depmod against
the System.map does not complain, but then, the symbols in it are not
versioned.

Booting the new kernel and depmodding against /proc/ksyms gives me
lots of unresolved symbols like:

depmod: *** Unresolved symbols in /lib/modules/2.4.19-rc1-ben0/kernel/fs/hfs/hfs.o
depmod:         __out_of_line_bug
depmod: *** Unresolved symbols in /lib/modules/2.4.19-rc1-ben0/kernel/fs/smbfs/smbfs.o
depmod:         zone_table
depmod:         flush_dcache_page

Looking those up in /proc/ksyms gives the following:

c00168e4 __out_of_line_bug_R__ver___out_of_line_bug
c02b3e94 zone_table_R__ver_zone_table
c0011994 flush_dcache_page_R__ver_flush_dcache_page

So, instead of the hash we have the symbol name again.
Only very few symbols have this problem.
A quick look at the include files for versioning gave me a head ache ;-)

I don't have this problem with i386, I have not tried another gcc version, but upped
modutils to the latest. No dice

Here is what I have:

Linux io 2.4.19-rc1-ben0 #59 Wed Jul 10 12:06:33 PDT 2002 ppc unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11f
mount                  2.11g
modutils               2.4.16
e2fsprogs              1.26
reiserfsprogs          3.x.1a
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         dmasound_pmac i2c-keywest i2c-core dmasound_core soundcore

Cheers,
Remco


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
