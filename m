Message-ID: <387E0A2C.5B09BC41@nua.lampf.lanl.gov>
Date: Thu, 13 Jan 2000 10:23:56 -0700
From: Ben Sapp <bsapp@nua.lampf.lanl.gov>
Reply-To: bsapp@lanl.gov
MIME-Version: 1.0
To: René Pachernegg <rene.pachernegg@apus.co.at>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Building Glibc
References: <20000112225539.62B021B152@elph.research.canon.com.au> <387E02BC.DCCA86B0@apus.co.at>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


René Pachernegg wrote:
> 
> Hello,
> Troubles dont stop.
> Started to build a new version of the GCC for Cross-Compiling for
> PowerPc on i686.
> I found an installation-guide for gcc cross-compiler at
> www.objsw.com/CrossGCC/FAQ-4.htm and followed the steps in 4.1.
> (automate build script (4.5)didnt work). Using:
> binutils 2.9.5.0.22
> gcc 2.95.2
> newlib-1.8.2
> Installing the binutils was successfull.
> Building gcc stopped with:
> as: unknown option -ppc

I have seen this before.   gcc must be finding the incorrect assembler. 
My belief is that it will try to use ${prefix}/${target}/bin/as if it is
available.   I do not think your command line option will effect this
problem because this error occurs after you have the new
compiler(xgcc).  

Make sure this is the target assembler.  You should be able to find what
assembler it is finding by adding the -v option to gcc.  

I have done exactly what you are trying to do.   Below I wrote some
notes on how to do this.  These notes were mostly for myself.  So, they
are not real clear, but hopefully they will be helpful.  

> Used script:
> target=powerpc-eabi
> prefix=/bar
> i=$prefix/bin
> ../gcc-2.8.1/configure --target=$target --prefix=$prefix -v /
> --with-newlib --enable-languages=c --with-gnu-ld --with-gnu-as
> make all install/
>         AS_FOR_TARGET=$i/${target}-as \
>         LD_FOR_TARGET=$i/${target}-ld \
>         AR_FOR_TARGET=$i/${target}-ar \
>         RANLIB_FOR_TARGET=$i/${target}-ranlib
> The Assembler used, is the one installed by binutils for powerpc.
> I didnt found any hint of any option -ppc in any file (greped it) in any
> of the 3 tools. But there is the as option -mppc. Maybe this is the
> option that is intended to be used.
> Any propositions?
> Regards
>         Rene
> 
> Does somebody know what to do??


Building cross development tools for powerpc-linux i686-linux
-------------------------------------------------------------------
ls -l binutils-2.9.5.0.22.tar.bz2 gcc-core-2.95.2.tar.bz2
gcc-2.95.2.tar.bz2 \
glibc-2.1.2.tar.gz glibc-crypt-2.1.2.tar.gz
glibc-linuxthreads-2.1.2.tar.gz
-rw-r--r--    1 bsapp    user     5150541 Jan  5 09:30
binutils-2.9.5.0.22.tar.bz2
-rw-r--r--    1 bsapp    user     9784016 Dec  4 17:13
gcc-2.95.2.tar.bz2
-rw-r--r--    1 bsapp    user     6768356 Dec  7 13:29
gcc-core-2.95.2.tar.bz2
-rw-r--r--    1 bsapp    user     8504830 Dec  3 11:23
glibc-2.1.2.tar.gz
-rw-r--r--    1 bsapp    user       40730 Dec  7 16:39
glibc-crypt-2.1.2.tar.gz
-rw-r--r--    1 bsapp    user      126522 Dec  7 16:33
glibc-linuxthreads-2.1.2.tar.gz
bzcat binutils-2.9.5.0.22.tar.bz2 | tar -xvf -
bzcat gcc-core-2.95.2.tar.bz2 | tar -xvf -
mv gcc-2.95.2 gcc-core-2.95.2
bzcat gcc-2.95.2.tar.bz2 | tar -xvf -
gtar -xzvf glibc-2.1.2.tar.gz
cd glibc-2.1.2
gtar -xzvf ../glibc-crypt-2.1.2.tar.gz
gtar -xzvf ../glibc-linuxthreads-2.1.2.tar.gz
mkdir build
mkdir build/binutils
mkdir build/gcc-core
mkdir build/gcc
mkdir build/glibc
cd ../build/binutils
../../binutils-2.9.5.0.22/configure --prefix=/ppctools
--target=powerpc-linux
gmake
gmake install
setenv PATH /ppctools/bin:${PATH}
cd ../gcc-core
../../gcc-core-2.95.2/configure --prefix=/ppctools
--target=powerpc-linux --with-newlib
gmake
gmake install
### Build the kernel
cd ../glibc
setenv CC powerpc-linux-gcc
setenv AR powerpc-linux-ar
setenv RANLIB powerpc-linux-ranlib
../../glibc-2.1.2/configure --prefix=/ppctools --host=powerpc-linux
--with-headers=<kernel source>/include
--enable-add-ons=crypt,linuxthreads
gmake
gmake install
cd ../gcc
unsetenv CC
unsetenv AR
unsetenv RANLIB
../../gcc-2.95.2/configure --prefix=/ppctools --target=powerpc-linux
--with-libs=/ppctools/lib --with-headers=/ppctools/include
--enable-languages="c,c++,f77"
gmake
gmake install
-------------------------------------------------------------------------


-- 
Ben Sapp                         Los Alamos National Laboratory
email: <mailto:bsapp@lanl.gov>   Phone: (505)667-3277
Fax:   (505)665-7920             URL:   http://www.neutrino.lanl.gov/
--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
