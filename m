Message-ID: <38794288.3E28E453@charter.net>
Date: Sun, 09 Jan 2000 20:23:04 -0600
From: Dan Dickey <ddickey@charter.net>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>,
        Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: My cookbook approach to building a cross compiler for the powerpc on an
 intel x86 Linux box
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok; I originally wrote this in HTML - but the list doesn't accept
attachments.  So, here is how it looks as text; sorry for the
poor formatting.  Consider it a work in progress.  :)
	-Dan




Other documents referenced:

   * http://members.home.com/mmporter/linux/cross/  (less useful)
   * http://www.objsw.com/CrossGCC/  (more useful)

 
------------------------------------------------------------------------

Binutils
Originally retrieved from ftp.cygnus.com - but that seems to be a fairly
"old"
version in terms of the PowerPC world.  Downloaded binutils-2.9.1.0.19a
from

ftp://ftp.cdrom.com/pub/linux/tsx-11/packages/GCC/binutils-2.9.1.0.19a.tar.gz

and built and installed it.  Went on to GCC-2.95.2; but it insists that
a
newer
version of binutils is needed.  Referred to binutils-2.9.4.0.8 or newer.
Downloaded
ftp://ftp.varesearch.com/pub/support/hjl/binutils/binutils-2.9.5.0.22.tar.bz2

and will build and install it.

$ cd /usr/local/src
$ bunzip2 -c binutils-2.9.5.0.22.tar.bz2 | tar xf -
$ cd /usr/local/ppc
$ mkdir build-binutils-2.9.5.0.22
$ cd build-binutils-2.9.5.0.22
$ ../../src/binutils-2.9.5.0.22/configure --target=powerpc-eabi
--prefix=/usr/local/ppc -v
$ make all
$ make install

 
------------------------------------------------------------------------

Newlib - part 1


$ cd /usr/local/src
$ tar zxf newlib-1.8.2.tar.gz

 
------------------------------------------------------------------------

GCC
Using the latest version of egcs (now GCC) - version 2.95.2 as retrieved
using
anonymous cvs.


$ PATH=$PATH:/usr/local/ppc/bin
$ export CVSROOT=:pserver:anoncvs@anoncvs.cygnus.com:/cvs/gcc
$ cvs login
(Logging in to anoncvs@anoncvs.cygnus.com)
CVS password: anoncvs
$ cd /usr/local/src
$ cvs -z 9 co -rgcc-2_95-branch egcs
$ cd egcs
$ ln -s ../newlib-1.8.2/newlib .
$ ln -s ../newlib-1.8.2/libgloss .
$ cd /usr/local/ppc
$ mkdir build-gcc-2.95.2
$ cd build-gcc-2.95.2
$ ../../src/egcs/configure --target=powerpc-eabi --with-cpu=860 \
--with-newlib --enable-languages=c++ --prefix=/usr/local/ppc -v
$ make all
$ make install

 
------------------------------------------------------------------------

Newlib - part 2


$ cd /usr/local/ppc
$ mkdir build-newlib-1.8.2
$ cd build-newlib-1.8.2
$ ../../src/newlib-1.8.2/configure --target=powerpc-eabi
--prefix=/usr/local/ppc -v
$ make all
$ make install

 
------------------------------------------------------------------------

Glibc
 
------------------------------------------------------------------------

Bootloader
 
------------------------------------------------------------------------

Kernel
 
------------------------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
