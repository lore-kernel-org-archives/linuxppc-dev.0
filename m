From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Date: Tue, 5 Dec 2000 17:25:07 +0100
Content-Type: text/plain;
  charset="US-ASCII"
Cc: max@trega.com
To: alex@cosmo.allay.net, Alex Avriette <alex@macachu.yi.org>,
        linuxppc-dev@lists.linuxppc.org
References: <Pine.LNX.4.10.10012050215570.22364-100000@macachu.ex-pressnet.com>
In-Reply-To: <Pine.LNX.4.10.10012050215570.22364-100000@macachu.ex-pressnet.com>
Subject: Re: lots of questions (va_list, embedded perl, cvsd, introduction - sort of)
MIME-Version: 1.0
Message-Id: <00120517250700.01539@enzo.bigblue.local>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tuesday 05 December 2000 08:39, Alex Avriette wrote:
> void
> log (const char *fmt, ...)
> {
>     va_list ap;
>
>     char buf[1024];
>
>     va_start (ap, fmt); vsnprintf ( buf, 1022, fmt, ap ); va_end (ap);
>     va_start (ap, fmt); vprintf ( fmt, ap ); va_end (ap);
>
>     fputc ('\n', stdout);
>     fflush (stdout);
>
>     putchan ( "#log", "logd", buf );
> }

This code looks OK. What environment? (gcc/glibc)

> #include <stdarg.h>
> #include <stdio.h>
>
> void vsn_test ( const char *fmt, ...)
> {
>   va_list ap; char buf [1024]; int i;
>
>   va_start ( ap, fmt ); vsnprintf ( buf, 1022, fmt, ap ); va_end ( ap );
>
>   for (i = 1; i < 5; i++)
>   { printf ( "pass [%d] %s\n", i, buf );
>     va_start ( ap, fmt ); vsnprintf ( buf, 1022, fmt, ap ); va_end ( ap );
> } }

This works as expected here.

> void v_test ( const char *fmt, ...)
> {
>   va_list ap; int i;
>
>   for (i = 1; i != 5; i++)
>   { printf ( "pass [%d] ", i );
>     va_start ( ap, fmt ); vprintf ( fmt, ap ); va_end ( ap ); printf
> ("\n"); } }

This works as expected here.

> void vs_test ( const char *fmt, ...)
> {
>   va_list ap; char buf[1024]; int i;
>
>   for (i = 1; i != 5; i++)
>   { printf ("pass [%d] %s\n", i );
>     va_start ( ap, fmt ); vsprintf ( buf, fmt, ap ); va_end ( ap ); }
> }

This testcase is buggy (look at the printf!), if fixed it behaves as
expected. You would have seen that if you compiled with -W -Wall!

> void dual_va_test ( const char *fmt, ...)
> {
>   va_list ap; char buf [1024]; int i;
>
>   for (i = 1; i < 5; i++)
>   { va_start ( ap, fmt ); vsnprintf ( buf, 1022, fmt, ap); va_end ( ap ) ;
>     printf ( "dual-run pass [%d][vsn] %s\n", i, buf );
>     printf ( "dual-run pass [%d][v] ", i);
>     va_start ( ap, fmt ); vprintf ( fmt, ap ); va_end ( ap ); printf
> ("\n"); } }

This works as expected here.

> void nested_test ( const char *fmt, ...)
> {
>   va_list ap; char bufa [1024]; char bufb [1024]; int i;
>
>   for (i = 1; i < 5; i++)
>   { va_start ( ap, fmt );
>     vsnprintf ( bufa, 1022, fmt, ap );
>     vsnprintf ( bufb, 1022, fmt, ap );
>     va_end ( ap );
>
>     printf ("buffer [a] pass [%d]: %s\n", i, bufa);
>     printf ("buffer [b] pass [%d]: %s\n", i, bufb); }
> }

This testcase is bogus since you miss the required va_start/va_end pairs. It
misbehaves as expected.

I've tested this both with gcc-2.95.3 and a recent gcc-2.97 snapshot. This
looks a lot like your are still using egcs on PPC, don't do that, use
gcc-2.95.[23] as the current distributions do.

Franz.


gcc-2.95.3 log:
[fsirl@enzo:/cvsx/bugs]$ ~/gnubin2/bin/gcc -v
Reading specs from
/home/fsirl/gnubin2/lib/gcc-lib/ppc-redhat-linux/2.95.3/specs
gcc version 2.95.3 19991130 (prerelease)
[fsirl@enzo:/cvsx/bugs]$ ~/gnubin2/bin/gcc -O2 -W -Wall va-arg-test.c
[fsirl@enzo:/cvsx/bugs]$ ./a.out
pass [1] int: 25 string: somestring
pass [2] int: 25 string: somestring
pass [3] int: 25 string: somestring
pass [4] int: 25 string: somestring
pass [1] int: 25 string: somestring
pass [2] int: 25 string: somestring
pass [3] int: 25 string: somestring
pass [4] int: 25 string: somestring
pass [1] int: 25 string: somestring
pass [2] int: 25 string: somestring
pass [3] int: 25 string: somestring
pass [4] int: 25 string: somestring
dual-run pass [1][vsn] int: 25 string: somestring
dual-run pass [1][v] int: 25 string: somestring
dual-run pass [2][vsn] int: 25 string: somestring
dual-run pass [2][v] int: 25 string: somestring
dual-run pass [3][vsn] int: 25 string: somestring
dual-run pass [3][v] int: 25 string: somestring
dual-run pass [4][vsn] int: 25 string: somestring
dual-run pass [4][v] int: 25 string: somestring
buffer [a] pass [1]: int: 25 string: somestring
buffer [b] pass [1]: int: 2147480576 string:
buffer [a] pass [2]: int: 25 string: somestring
buffer [b] pass [2]: int: 2147480576 string:
buffer [a] pass [3]: int: 25 string: somestring
buffer [b] pass [3]: int: 2147480576 string:
buffer [a] pass [4]: int: 25 string: somestring
buffer [b] pass [4]: int: 2147480576 string:
[fsirl@enzo:/cvsx/bugs]$

gcc-2.97 log:
[fsirl@enzo:/cvsx/bugs]$ gcc -v
Reading specs from /usr/lib/gcc-lib/ppc-redhat-linux/2.97/specs
Configured with:  --prefix=/usr --mandir=/usr/man --infodir=/usr/info
--enable-shared --enable-threads=posix --host=ppc-redhat-linux
gcc version 2.97 20001106 (experimental)
[fsirl@enzo:/cvsx/bugs]$ gcc -O2 -W -Wall va-arg-test.c
[fsirl@enzo:/cvsx/bugs]$ ./a.out
pass [1] int: 25 string: somestring
pass [2] int: 25 string: somestring
pass [3] int: 25 string: somestring
pass [4] int: 25 string: somestring
pass [1] int: 25 string: somestring
pass [2] int: 25 string: somestring
pass [3] int: 25 string: somestring
pass [4] int: 25 string: somestring
pass [1] int: 25 string: somestring
pass [2] int: 25 string: somestring
pass [3] int: 25 string: somestring
pass [4] int: 25 string: somestring
dual-run pass [1][vsn] int: 25 string: somestring
dual-run pass [1][v] int: 25 string: somestring
dual-run pass [2][vsn] int: 25 string: somestring
dual-run pass [2][v] int: 25 string: somestring
dual-run pass [3][vsn] int: 25 string: somestring
dual-run pass [3][v] int: 25 string: somestring
dual-run pass [4][vsn] int: 25 string: somestring
dual-run pass [4][v] int: 25 string: somestring
Segmentation fault
[fsirl@enzo:/cvsx/bugs]$

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
