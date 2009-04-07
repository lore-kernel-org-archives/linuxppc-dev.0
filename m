Return-Path: <tosubrata@gmail.com>
Received: from mail-bw0-f180.google.com (mail-bw0-f180.google.com
	[209.85.218.180]) by ozlabs.org (Postfix) with ESMTP id BB761DDFAC
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 17:15:00 +1000 (EST)
Received: by bwz28 with SMTP id 28so2046070bwz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 07 Apr 2009 00:14:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090407131950.9ab4430b.sfr@canb.auug.org.au>
References: <20090407131950.9ab4430b.sfr@canb.auug.org.au>
Date: Tue, 7 Apr 2009 12:21:18 +0530
Message-ID: <bb33bcf20904062351p63645851h9b33d47f57c57e7f@mail.gmail.com>
Subject: Re: [PATCH] powerpc: wire up preadv and pwritev
From: Subrata Modak <tosubrata@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: multipart/alternative; boundary=00504502e11e27188f0466f17103
Cc: ltp-list <ltp-list@lists.sf.net>, maknayak@in.ibm.com,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Gerd Hoffmann <kraxel@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--00504502e11e27188f0466f17103
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Stephen,

On Tue, Apr 7, 2009 at 8:49 AM, Stephen Rothwell <sfr@canb.auug.org.au>wrote:

>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/include/asm/systbl.h |    2 ++
>  arch/powerpc/include/asm/unistd.h |    4 +++-
>  2 files changed, 5 insertions(+), 1 deletions(-)
>
> Tested on pseries_defconfig (verified using strace{,64} and inspecting
> the files).  Test program (modified from the original because the API and
> ABI changed and I added a test with larger offsets):
>
> #if 0
> set -x
> gcc -Wall -O2 -m32 -o preadv $0
> gcc -Wall -O2 -m32 -D_FILE_OFFSET_BITS=64 -DLARGE_TEST -o preadv32 $0
> gcc -Wall -O2 -m64 -DLARGE_TEST -o preadv64 $0
> ./preadv
> ./preadv32
> ./preadv64
> exit 0
> #endif
> /*
>  * preadv demo / test
>  *
>  * (c) 2008 Gerd Hoffmann <kraxel@redhat.com>
>  * Modified for new ABI and large offset test by Stephen Rothwell
>  *
>  * build with "sh $thisfile"
>  */
>
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <errno.h>
> #include <inttypes.h>
> #include <sys/uio.h>
>
> /* ----------------------------------------------------------------- */
> /* syscall windup                                                    */
>
> #include <sys/syscall.h>
> #if 1
> /* WARNING: Be sure you know what you are doing if you enable this.
>  * linux syscall code isn't upstream yet, syscall numbers are subject
>  * to change */
> # ifndef __NR_preadv
> #  ifdef __i386__
> #   define __NR_preadv  333
> #   define __NR_pwritev 334
> #  endif
> #  ifdef __x86_64__
> #   define __NR_preadv  295
> #   define __NR_pwritev 296
> #  endif
> #  ifdef __powerpc__
> #   define __NR_preadv  319
> #   define __NR_pwritev 320
> #  endif
> # endif
> #endif
> #ifndef __NR_preadv
> # error preadv/pwritev syscall numbers are unknown
> #endif
>
> #define HALF_BITS (sizeof(unsigned long)*4)
>
> static ssize_t preadv(int fd, const struct iovec *iov, int iovcnt,
>                      off_t offset)
> {
>        return syscall(__NR_preadv, fd, iov, iovcnt,
>                       (unsigned long)offset,
>                       (unsigned long)((offset >> HALF_BITS) >> HALF_BITS));
> }
>
> static ssize_t pwritev(int fd, const struct iovec *iov, int iovcnt,
>                       off_t offset)
> {
>        return syscall(__NR_pwritev, fd, iov, iovcnt,
>                       (unsigned long)offset,
>                       (unsigned long)((offset >> HALF_BITS) >> HALF_BITS));
> }
>
> /* ----------------------------------------------------------------- */
> /* demo/test app                                                     */
>
> static char filename[] = "/tmp/preadv-XXXXXX";
> static char outbuf[11] = "0123456789";
> static char inbuf[11]  = "----------";
>
> static struct iovec ovec[2] = {{
>                .iov_base = outbuf + 5,
>                .iov_len  = 5,
>        },{
>                .iov_base = outbuf + 0,
>                .iov_len  = 5,
>        }};
>
> static struct iovec ivec[3] = {{
>                .iov_base = inbuf + 6,
>                .iov_len  = 2,
>        },{
>                .iov_base = inbuf + 4,
>                .iov_len  = 2,
>        },{
>                .iov_base = inbuf + 2,
>                .iov_len  = 2,
>        }};
>
> void cleanup(void)
> {
>        unlink(filename);
> }
>
> int main(int argc, char **argv)
> {
>        int fd, rc;
>
>        fd = mkstemp(filename);
>        if (-1 == fd) {
>                perror("mkstemp");
>                exit(1);
>        }
>        atexit(cleanup);
>
>        /* write to file: "56789-01234" */
>        rc = pwritev(fd, ovec, 2, 0);
>        if (rc < 0) {
>                perror("pwritev");
>                exit(1);
>        }
>
>        /* read from file: "78-90-12" */
>        rc = preadv(fd, ivec, 3, 2);
>        if (rc < 0) {
>                perror("preadv");
>                exit(1);
>        }
>
>        printf("result  : %s\n", inbuf);
>        printf("expected: %s\n", "--129078--");
>
> #ifdef LARGE_TEST
>
>        /* write to file: "56789-01234" */
>        rc = pwritev(fd, ovec, 2, 0x300000000ULL);
>        if (rc < 0) {
>                perror("pwritev");
>                exit(1);
>        }
>
>        /* read from file: "78-90-12" */
>        rc = preadv(fd, ivec, 3, 0x300000000ULL + 2);
>        if (rc < 0) {
>                perror("preadv");
>                exit(1);
>        }
>
>        printf("result  : %s\n", inbuf);
>        printf("expected: %s\n", "--129078--");
>
> #endif
>
>        exit(0);
> }
>

How about contributing the above test to LTP(http://ltp.sourceforge.net/)
under GPL ? If you agree, i would soon send you a Patch integrating the same
to LTP.

Regards--
Subrata


>
> diff --git a/arch/powerpc/include/asm/systbl.h
> b/arch/powerpc/include/asm/systbl.h
> index fe16649..3fb6d9e 100644
> --- a/arch/powerpc/include/asm/systbl.h
> +++ b/arch/powerpc/include/asm/systbl.h
> @@ -322,3 +322,5 @@ SYSCALL_SPU(epoll_create1)
>  SYSCALL_SPU(dup3)
>  SYSCALL_SPU(pipe2)
>  SYSCALL(inotify_init1)
> +COMPAT_SYS_SPU(preadv)
> +COMPAT_SYS_SPU(pwritev)
> diff --git a/arch/powerpc/include/asm/unistd.h
> b/arch/powerpc/include/asm/unistd.h
> index e07d0c7..7e03ebe 100644
> --- a/arch/powerpc/include/asm/unistd.h
> +++ b/arch/powerpc/include/asm/unistd.h
> @@ -341,10 +341,12 @@
>  #define __NR_dup3              316
>  #define __NR_pipe2             317
>  #define __NR_inotify_init1     318
> +#define __NR_preadv            319
> +#define __NR_pwritev           320
>
>  #ifdef __KERNEL__
>
> -#define __NR_syscalls          319
> +#define __NR_syscalls          321
>
>  #define __NR__exit __NR_exit
>  #define NR_syscalls    __NR_syscalls
> --
> 1.6.2.1
>
> --
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/ <http://www.canb.auug.org.au/%7Esfr/>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



-- 
Regards & Thanks--
Subrata

--00504502e11e27188f0466f17103
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Stephen,<br><br><div class=3D"gmail_quote">On Tue, Apr 7, 2009 at 8:49 A=
M, Stephen Rothwell <span dir=3D"ltr">&lt;<a href=3D"mailto:sfr@canb.auug.o=
rg.au">sfr@canb.auug.org.au</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt=
 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
Signed-off-by: Stephen Rothwell &lt;<a href=3D"mailto:sfr@canb.auug.org.au"=
>sfr@canb.auug.org.au</a>&gt;<br>
---<br>
=C2=A0arch/powerpc/include/asm/systbl.h | =C2=A0 =C2=A02 ++<br>
=C2=A0arch/powerpc/include/asm/unistd.h | =C2=A0 =C2=A04 +++-<br>
=C2=A02 files changed, 5 insertions(+), 1 deletions(-)<br>
<br>
Tested on pseries_defconfig (verified using strace{,64} and inspecting<br>
the files). =C2=A0Test program (modified from the original because the API =
and<br>
ABI changed and I added a test with larger offsets):<br>
<br>
#if 0<br>
set -x<br>
gcc -Wall -O2 -m32 -o preadv $0<br>
gcc -Wall -O2 -m32 -D_FILE_OFFSET_BITS=3D64 -DLARGE_TEST -o preadv32 $0<br>
gcc -Wall -O2 -m64 -DLARGE_TEST -o preadv64 $0<br>
./preadv<br>
./preadv32<br>
./preadv64<br>
exit 0<br>
#endif<br>
/*<br>
=C2=A0* preadv demo / test<br>
=C2=A0*<br>
=C2=A0* (c) 2008 Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com">kra=
xel@redhat.com</a>&gt;<br>
=C2=A0* Modified for new ABI and large offset test by Stephen Rothwell<br>
=C2=A0*<br>
=C2=A0* build with &quot;sh $thisfile&quot;<br>
=C2=A0*/<br>
<br>
#include &lt;stdio.h&gt;<br>
#include &lt;stdlib.h&gt;<br>
#include &lt;unistd.h&gt;<br>
#include &lt;errno.h&gt;<br>
#include &lt;inttypes.h&gt;<br>
#include &lt;sys/uio.h&gt;<br>
<br>
/* ----------------------------------------------------------------- */<br>
/* syscall windup =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
<br>
#include &lt;sys/syscall.h&gt;<br>
#if 1<br>
/* WARNING: Be sure you know what you are doing if you enable this.<br>
=C2=A0* linux syscall code isn&#39;t upstream yet, syscall numbers are subj=
ect<br>
=C2=A0* to change */<br>
# ifndef __NR_preadv<br>
# =C2=A0ifdef __i386__<br>
# =C2=A0 define __NR_preadv =C2=A0333<br>
# =C2=A0 define __NR_pwritev 334<br>
# =C2=A0endif<br>
# =C2=A0ifdef __x86_64__<br>
# =C2=A0 define __NR_preadv =C2=A0295<br>
# =C2=A0 define __NR_pwritev 296<br>
# =C2=A0endif<br>
# =C2=A0ifdef __powerpc__<br>
# =C2=A0 define __NR_preadv =C2=A0319<br>
# =C2=A0 define __NR_pwritev 320<br>
# =C2=A0endif<br>
# endif<br>
#endif<br>
#ifndef __NR_preadv<br>
# error preadv/pwritev syscall numbers are unknown<br>
#endif<br>
<br>
#define HALF_BITS (sizeof(unsigned long)*4)<br>
<br>
static ssize_t preadv(int fd, const struct iovec *iov, int iovcnt,<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0off_t offset)<br>
{<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0return syscall(__NR_preadv, fd, iov, iovcnt,<br=
>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (unsigned long)offset,<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (unsigned long)((offset &gt;&gt; HALF_BITS) &gt;&gt; HALF_BITS));<br>
}<br>
<br>
static ssize_t pwritev(int fd, const struct iovec *iov, int iovcnt,<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 off_t offset)<br>
{<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0return syscall(__NR_pwritev, fd, iov, iovcnt,<b=
r>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (unsigned long)offset,<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (unsigned long)((offset &gt;&gt; HALF_BITS) &gt;&gt; HALF_BITS));<br>
}<br>
<br>
/* ----------------------------------------------------------------- */<br>
/* demo/test app =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
<br>
static char filename[] =3D &quot;/tmp/preadv-XXXXXX&quot;;<br>
static char outbuf[11] =3D &quot;0123456789&quot;;<br>
static char inbuf[11] =C2=A0=3D &quot;----------&quot;;<br>
<br>
static struct iovec ovec[2] =3D {{<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.iov_base =3D outbu=
f + 5,<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.iov_len =C2=A0=3D =
5,<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0},{<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.iov_base =3D outbu=
f + 0,<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.iov_len =C2=A0=3D =
5,<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0}};<br>
<br>
static struct iovec ivec[3] =3D {{<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.iov_base =3D inbuf=
 + 6,<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.iov_len =C2=A0=3D =
2,<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0},{<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.iov_base =3D inbuf=
 + 4,<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.iov_len =C2=A0=3D =
2,<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0},{<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.iov_base =3D inbuf=
 + 2,<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.iov_len =C2=A0=3D =
2,<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0}};<br>
<br>
void cleanup(void)<br>
{<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0unlink(filename);<br>
}<br>
<br>
int main(int argc, char **argv)<br>
{<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0int fd, rc;<br>
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D mkstemp(filename);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (-1 =3D=3D fd) {<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perror(&quot;mkstem=
p&quot;);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0atexit(cleanup);<br>
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* write to file: &quot;56789-01234&quot; */<br=
>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D pwritev(fd, ovec, 2, 0);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc &lt; 0) {<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perror(&quot;pwrite=
v&quot;);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* read from file: &quot;78-90-12&quot; */<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D preadv(fd, ivec, 3, 2);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc &lt; 0) {<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perror(&quot;preadv=
&quot;);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;result =C2=A0: %s\n&quot;, inbuf);=
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;expected: %s\n&quot;, &quot;--1290=
78--&quot;);<br>
<br>
#ifdef LARGE_TEST<br>
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* write to file: &quot;56789-01234&quot; */<br=
>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D pwritev(fd, ovec, 2, 0x300000000ULL);<br=
>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc &lt; 0) {<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perror(&quot;pwrite=
v&quot;);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* read from file: &quot;78-90-12&quot; */<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D preadv(fd, ivec, 3, 0x300000000ULL + 2);=
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc &lt; 0) {<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perror(&quot;preadv=
&quot;);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;result =C2=A0: %s\n&quot;, inbuf);=
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;expected: %s\n&quot;, &quot;--1290=
78--&quot;);<br>
<br>
#endif<br>
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(0);<br>
}<br>
</blockquote><div><br>How about contributing the above test to LTP(<a href=
=3D"http://ltp.sourceforge.net/">http://ltp.sourceforge.net/</a>) under GPL=
 ? If you agree, i would soon send you a Patch integrating the same to LTP.=
<br>
<br>Regards--<br>Subrata<br><br></div><blockquote class=3D"gmail_quote" sty=
le=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex;=
 padding-left: 1ex;"><br>
<br>
diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/s=
ystbl.h<br>
index fe16649..3fb6d9e 100644<br>
--- a/arch/powerpc/include/asm/systbl.h<br>
+++ b/arch/powerpc/include/asm/systbl.h<br>
@@ -322,3 +322,5 @@ SYSCALL_SPU(epoll_create1)<br>
=C2=A0SYSCALL_SPU(dup3)<br>
=C2=A0SYSCALL_SPU(pipe2)<br>
=C2=A0SYSCALL(inotify_init1)<br>
+COMPAT_SYS_SPU(preadv)<br>
+COMPAT_SYS_SPU(pwritev)<br>
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/u=
nistd.h<br>
index e07d0c7..7e03ebe 100644<br>
--- a/arch/powerpc/include/asm/unistd.h<br>
+++ b/arch/powerpc/include/asm/unistd.h<br>
@@ -341,10 +341,12 @@<br>
=C2=A0#define __NR_dup3 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0316=
<br>
=C2=A0#define __NR_pipe2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 317<br>
=C2=A0#define __NR_inotify_init1 =C2=A0 =C2=A0 318<br>
+#define __NR_preadv =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0319<br>
+#define __NR_pwritev =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 320<br>
<br>
=C2=A0#ifdef __KERNEL__<br>
<br>
-#define __NR_syscalls =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0319<br>
+#define __NR_syscalls =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0321<br>
<br>
=C2=A0#define __NR__exit __NR_exit<br>
=C2=A0#define NR_syscalls =C2=A0 =C2=A0__NR_syscalls<br>
--<br>
1.6.2.1<br>
<br>
--<br>
Cheers,<br>
Stephen Rothwell =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0<a href=3D"mailto:sfr@canb.auug.org.au">sfr@canb.auug.org.au</=
a><br>
<a href=3D"http://www.canb.auug.org.au/%7Esfr/" target=3D"_blank">http://ww=
w.canb.auug.org.au/~sfr/</a><br>
<font color=3D"#888888">--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel=
&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =C2=A0<a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
Please read the FAQ at =C2=A0<a href=3D"http://www.tux.org/lkml/" target=3D=
"_blank">http://www.tux.org/lkml/</a><br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Regards &amp; Th=
anks--<br>Subrata<br>

--00504502e11e27188f0466f17103--
