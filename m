Message-ID: <381A4E7F.558A54C0@263.net>
Date: Sat, 30 Oct 1999 09:48:47 +0800
From: Wang Yong <wung_y@263.net>
Reply-To: wung_y@263.net
MIME-Version: 1.0
To: Momchil Velikov <velco@fadata.bg>
CC: linux-ce-devel <linuxce-devel@linuxce.org>,
        linuxppc embedded mail list <linuxppc-embedded@lists.linuxppc.org>,
        linux-ppc <linuxppc-dev@lists.linuxppc.org>
Subject: Re: help, build Cross GCC
References: <38184905.117429CD@263.net> <38184DC8.6773D84D@schweiz.ch> <381878FB.8916CB9@netx4.com> <381912CE.9DB75640@263.net> <38199B27.492FE947@fadata.bg>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


thank you sir, i have got xgcc. but now the problem is glibc. it seems
glibc2.0 still support PPC. GNU say glibc for ppc is still under
development.
how about libc?

Momchil Velikov wrote:
> 
> I built a cross-dev environment sometime ago. Here's what I did:
> 
> 0. got glibc-?.tar.gz from the usual places
>    get binutils-?.tar.gz
>    get egcs-?.tar.gz
> 
> 1. Built and installed binutils
> 
> 2. Began with the egcs
>    configure --prefix=/usr/local                   \
>              --build=i686-pc-linux-gnu             \
>              --host=i686-pc-linux-gnu              \
>              --target=powerpc-unknown-linux-gnu
>    make LANGUAGES=c
>    make -k
> /* make fails, trying to build libgcc.a */
> 
>    make -k LANGUAGES=c install
> /* now we have a compiler, which compiles. We can't link yet, so
>  * we can't create shared libs or executables, but we _can_ create
>  * static glibc
>  */
> 
> 3. Began with glibc
>    configure --prefix=/usr/local                 \
>              --build=i686-pc-linux-gnu           \
>              --host=powerpc-unknown-linux-gnu    \
>              --enable-add-ons=crypt,linuxthreads \
>              --disable-profile
> 
>    make -k
> /* build fails when trying to link some execitables
>  * and some shared libs
>  */
> 
>    make -k install install_root=whatever
> /* now we have enough headers and static librararies to complete
>  * the build of gcc
>  */
> 
> 4. Back to egcs
>    make
>    make install
> /* no errors at this point, now we have complete gcc */
> 
> 5. Back to glibc
>    make
>    make install install_root=whatever
> /* no errors anymore */
> 
> That's all. Don't rely on the exact parameters to configure,
> I got them from memory.
> 
> Regards,
> -velco

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
