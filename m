Message-ID: <3A461339.27E208ED@ife.ee.ethz.ch>
Date: Sun, 24 Dec 2000 16:16:09 +0100
From: Thomas Sailer <sailer@ife.ee.ethz.ch>
Reply-To: sailer@ife.ee.ethz.ch
MIME-Version: 1.0
To: Kaoru Fukui <k_fukui@highway.ne.jp>
CC: linuxppc-dev@lists.linuxppc.org, gcc@gcc.gnu.org
Subject: Re: kerne-2.4.0-test13pre3 with gcc-2.97
References: <20001223145258.Postino-022361@smtp01.highway.ne.jp>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kaoru Fukui wrote:

> The gcc-2.97 makes singleCPU work kernel  well,
> But the smp kernel didn't work.

> diff -urN base/linux/drivers/usb/audio.c fixed/linux/drivers/usb/audio.c
> --- base/linux/drivers/usb/audio.c      Fri Dec 22 13:47:44 2000
> +++ fixed/linux/drivers/usb/audio.c     Sat Dec 23 12:18:21 2000
> @@ -788,7 +788,7 @@
>  {
>         union {
>                 __s16 s[64];
> -               unsigned char b[0];
> +               unsigned char *b;
>         } tmp;
>         unsigned int scnt, maxs, ufmtsh, dfmtsh;
>
> @@ -1139,7 +1139,7 @@
>  {
>         union {
>                 __s16 s[64];
> -               unsigned char b[0];
> +               unsigned char *b;
>         } tmp;
>         unsigned int scnt, maxs, ufmtsh, dfmtsh;
>

This patch is completely bogus. I do not believe you tested these
code paths, it just cannot work that way.

Tom

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
