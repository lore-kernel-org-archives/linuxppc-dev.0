Subject: RE: Problem with shared libraries in HHL with initrd
Date: Fri, 6 Oct 2000 12:37:36 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-ID: <EADB10BAC266A14A85ECBF8686A73E310A90C0@kolkrabbi.flaga.is>
From: Kári Davíðsson <kd@flaga.is>
To: "Linux Embedded ppc (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You need to mimic the installation in you cross development environment,
e.g.
if your cross development libraries are in /usr/cross/lib on your host
you should put
them at the same place on your ramdisk.

In addition you nee the linker in /lib, i.e. something like the
following
-rwxr-xr-x   1 root     0          182887 Apr 16  2000 ld-2.1.3.so
lrwxrwxrwx   1 root     0              11 Aug 23  2000 ld.so.1 ->
ld-2.1.3.so
The linker is in /usr/cross/lib on your cross development host.

There is a lot of stuff in /usr/cross/lib. Some you need some you don't.
I managed to cut the libs down to the following, and you might even
strip it more.

-rwxr-xr-x   1 root     0            3652 Aug 17  2000
libBrokenLocale-2.1.3.so
lrwxrwxrwx   1 root     0              20 Aug 23  2000
libBrokenLocale.so -> libBrokenLocale.so.1
lrwxrwxrwx   1 root     0              24 Aug 23  2000
libBrokenLocale.so.1 -> libBrokenLocale-2.1.3.so
-rwxr-xr-x   1 root     0            9996 Aug 17  2000 libSegFault.so
-rwxr-xr-x   1 root     0         1467224 Aug 18  2000 libc-2.1.3.so
-rw-r--r--   1 root     0             194 Apr 16  2000 libc.so
lrwxrwxrwx   1 root     0              13 Aug 23  2000 libc.so.6 ->
libc-2.1.3.so
-rwxr-xr-x   1 root     0           33076 Aug 17  2000 libcrypt-2.1.3.so
lrwxrwxrwx   1 root     0              13 Aug 23  2000 libcrypt.so ->
libcrypt.so.1
lrwxrwxrwx   1 root     0              17 Aug 23  2000 libcrypt.so.1 ->
libcrypt-2.1.3.so
-rwxr-xr-x   1 root     0          343592 Aug 17  2000 libm-2.1.3.so
lrwxrwxrwx   1 root     0               9 Aug 23  2000 libm.so ->
libm.so.6
lrwxrwxrwx   1 root     0              13 Aug 23  2000 libm.so.6 ->
libm-2.1.3.so
-rwxr-xr-x   1 root     0           18171 Apr 16  2000
libnss_dns-2.1.3.so
lrwxrwxrwx   1 root     0              15 Aug 23  2000 libnss_dns.so ->
libnss_dns.so.2
lrwxrwxrwx   1 root     0              19 Aug 23  2000 libnss_dns.so.2
-> libnss_dns-2.1.3.so
-rwxr-xr-x   1 root     0           57328 Apr 25  2000
libnss_files-2.1.3.so
lrwxrwxrwx   1 root     0              17 Sep 26  2000 libnss_files.so
-> libnss_files.so.2
lrwxrwxrwx   1 root     0              21 Sep 26  2000 libnss_files.so.2
-> libnss_files-2.1.3.so
-rwxr-xr-x   1 root     0           86410 Apr 28  2000 libproc.so.2.0.6
-rwxr-xr-x   1 root     0           89632 Aug 17  2000 libpthread-0.8.so
lrwxrwxrwx   1 root     0              15 Aug 23  2000 libpthread.so ->
libpthread.so.0
lrwxrwxrwx   1 root     0              17 Aug 23  2000 libpthread.so.0
-> libpthread-0.8.so
-rwxr-xr-x   1 root     0           69880 Aug 17  2000
libresolv-2.1.3.so
lrwxrwxrwx   1 root     0              14 Aug 23  2000 libresolv.so ->
libresolv.so.2
lrwxrwxrwx   1 root     0              18 Aug 23  2000 libresolv.so.2 ->
libresolv-2.1.3.so
-r-xr-xr-x   1 root     0          346572 Aug 17  2000
libstdc++-3-libc6.1-2-2.10.0.so
lrwxrwxrwx   1 root     0              31 Aug 23  2000
libstdc++-libc6.1-2.so.3 -> libstdc++-3-libc6.1-2-2.10.0.so
-rwxr-xr-x   1 root     0           11935 Apr 25  2000 libutil-2.1.3.so
lrwxrwxrwx   1 root     0              12 Sep 25  2000 libutil.so ->
libutil.so.1
lrwxrwxrwx   1 root     0              16 Sep 25  2000 libutil.so.1 ->
libutil-2.1.3.so

Hope this helps,

K.D.

-----Original Message-----
From: jonb@marel.is [mailto:jonb@marel.is]
Sent: 6. október 2000 12:13
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problem with shared libraries in HHL with initrd



Hi

I am using Hard Hat Linux 1.2 with a custom MPC823 board and I am trying
to
create a minimal initial ram disk, so the board can boot without having
an
NFS root file system.  I am having a problem because shared libraries
are
not being found.  For example init reports:

  init: error in loading shared libraries: libc.so.6: cannot open shared
object file: No such file or directory

My minimal file system has the following directories: /bin, /dev and
/lib .
I put the shared libs
in the /lib directory.  In /bin I have init, sh and ls, copied from
/opt/hardhat/devkit/ppc/8xx/target/bin.

I seems the system expects to find the shared libraries in some other
directory than /lib.

I saw some discussion on the list about some symbolic links being
required
to get this
working, but I have tried everything I can think of.

Everything is fine if I use staticly linked binaries.

Can anyone give me directions ?
Does someone have a "minroot.tar.gz" made with HHL 1.2 ?


Regards,

Jon Benediktsson
Marel hf.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
