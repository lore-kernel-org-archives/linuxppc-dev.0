Message-ID: <006601c1e424$2347d3f0$1a11efcb@industrialDiv.hanasys.co.kr>
Reply-To: "Sangmoon Kim" <dogoil@etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: "Timothy Robb" <xavier@vianet.ca>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <000b01c1e418$f49c0c20$0a02a8c0@WorkGroup>
Subject: Re: Trouble building a cross compiler
Date: Mon, 15 Apr 2002 11:20:39 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Now the problem lies with my glibc.  I do the following, which I got
> from the instructions for building a sh4-linux target but with some
> input for the embedded power pc stuff and it doesn't work.
>
> CC=powerpc-linux-gcc AR=powerpc-linux-ar RANLIB=powerpc-linux-ranlib
> configure --host=$TARGET --prefix=$PREFIX
> --with-headers=$PREFIX/TARGET/include --disable-debug
> --disable-profile --disable-sanity-checks
> make
>
It seams like you forgot the linuxthreads thing.
Try this.
tar -xzf glibc-2.2.5.tar.gz
cd glibc-2.2.5
tar -xzf ../glibc-linuxthreads-2.2.5.tar.gz
cd ..
mkdir build-glibc; cd build-glibc
CC=${TARGET}-gcc AR=${TARGET}-ar RANLIB=${TARGET}-ranlib \
   ../glibc-2.2.5/configure --host=$TARGET --prefix=${PREFIX}/${TARGET} \
   --enable-add-ons=linuxthreads --with-headers=${PREFIX}/${TARGET}/include \
   2>&1 | tee configure.log
make all install info install-info 2>&1 | tee make.log
cd ..
- Sangmoon Kim -

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
