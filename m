Message-ID: <3C17BFB2.A40932ED@ixiacom.com>
Date: Wed, 12 Dec 2001 12:36:02 -0800
From: Dan Kegel <dkegel@ixiacom.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: building gcc3.02 for ppc405 with Hardhat 2 Journeyman tools
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Here's how I built gcc3 and
integrated it into the hardhat tools for ppc405.  Works for me,
but YMMV.  Thanks to Bryan Rittmeyer for the recipe.

#!/bin/sh

set -x -e
WORKDIR=`pwd`

#wget ftp://ftp.gnu.org/pub/gnu/gcc/gcc-3.0.2/gcc-core-3.0.2.tar.gz
#wget ftp://ftp.gnu.org/pub/gnu/gcc/gcc-3.0.2/gcc-g++-3.0.2.tar.gz

# Muck around in the hardhat tree to let the gcc build process find what it
# needs.  FIXME These steps must all be run as root.
cd /opt/hardhat/devkit/ppc/405

# Avoid exit if links exist by using a subshell
(
ln -s powerpc-hardhat-linux powerpc-linux
cd bin
ln -s ppc_405-ar powerpc-linux-ar
ln -s ppc_405-ld powerpc-linux-ld
ln -s ppc_405-nm powerpc-linux-nm
ln -s ppc_405-ranlib powerpc-linux-ranlib
ln -s ppc_405-strip powerpc-linux-strip
)

find . -name crt?.o -exec cp {} powerpc-linux/lib \;

# Extract the source into the same directory as the tarballs
cd $WORKDIR
tar zxvf gcc-core-3.0.2.tar.gz
tar zxvf gcc-g++-3.0.2.tar.gz

PATH=/opt/hardhat/devkit/ppc/405/bin:$PATH
export PATH

mkdir gcc-build
cd gcc-build
../gcc-3.0.2/configure \
        --target=powerpc-linux \
        --prefix=/opt/hardhat/devkit/ppc/405 \
        --with-headers=/opt/hardhat/devkit/ppc/405/target/usr/include \
        --enable-shared \
        --enable-long-long \
        --enable-threads=posix \
        --enable-langugages=c,c++ \
        --nfp \
        --with-cpu=403

make
make install

# FIXME: are these paths right?
cp -d /opt/hardhat/devkit/ppc/405/powerpc-linux/lib/nof/libs*
/opt/hardhat/devkit/ppc/405/target/usr/lib
cp -d /opt/hardhat/devkit/ppc/405/powerpc-linux/lib/libgcc_s_nof*
/opt/hardhat/devkit/ppc/405/target/lib
cp -R -d /opt/hardhat/devkit/ppc/405/include/g++-v3
/opt/hardhat/devkit/ppc/405/target/usr/include

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
