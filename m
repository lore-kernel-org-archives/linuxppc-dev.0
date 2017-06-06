Return-Path: <arndbergmann@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whpf14ppdzDqPZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 21:01:29 +1000 (AEST)
Received: by mail-oi0-x244.google.com with SMTP id h4so24280059oib.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Jun 2017 04:01:29 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20170603135111.5444-2-asarai@suse.de>
References: <20170603135111.5444-1-asarai@suse.de>
 <20170603135111.5444-2-asarai@suse.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Jun 2017 13:01:23 +0200
Message-ID: <CAK8P3a3j4rB+iVX=a36csE6mX9iMRp14TS1UeePyFsjTKQyiZw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] tty: add compat_ioctl callbacks
To: Aleksa Sarai <asarai@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-alpha@vger.kernel.org,
 "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-sh@vger.kernel.org,
 sparclinux <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org,
 linux-arch <linux-arch@vger.kernel.org>,
 Christian Brauner <christian.brauner@ubuntu.com>,
 Valentin Rothberg <vrothberg@suse.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 3, 2017 at 3:51 PM, Aleksa Sarai <asarai@suse.de> wrote:
> In order to avoid future diversions between fs/compat_ioctl.c and
> drivers/tty/pty.c, define .compat_ioctl callbacks for the relevant
> tty_operations structs. Since both pty_unix98_ioctl() and
> pty_bsd_ioctl() are compatible between 32-bit and 64-bit userspace no
> special translation is required.
>
> Signed-off-by: Aleksa Sarai <asarai@suse.de>
> ---
>  Makefile          |  1 +
>  drivers/tty/pty.c | 22 ++++++++++++++++++++++
>  fs/compat_ioctl.c |  6 ------
>  3 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 470bd4d9513a..fb689286d83a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -401,6 +401,7 @@ KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
>                    -fno-strict-aliasing -fno-common \
>                    -Werror-implicit-function-declaration \
>                    -Wno-format-security \
> +                  -Wno-error=int-in-bool-context \
>                    -std=gnu89 $(call cc-option,-fno-PIE)

This  slipped in by accident I assume? It seems completely unrelated.

> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> index 65799575c666..2a6bd9ae3f8b 100644
> --- a/drivers/tty/pty.c
> +++ b/drivers/tty/pty.c
> @@ -481,6 +481,16 @@ static int pty_bsd_ioctl(struct tty_struct *tty,
>         return -ENOIOCTLCMD;
>  }
>
> +static long pty_bsd_compat_ioctl(struct tty_struct *tty,
> +                                unsigned int cmd, unsigned long arg)
> +{
> +       /*
> +        * PTY ioctls don't require any special translation between 32-bit and
> +        * 64-bit userspace, they are already compatible.
> +        */
> +       return pty_bsd_ioctl(tty, cmd, arg);
> +}
> +

This looks correct but unnecessary, you can simply point both
function pointers to the same function:

>   * not really modular, but the easiest way to keep compat with existing
> @@ -502,6 +512,7 @@ static const struct tty_operations master_pty_ops_bsd = {
>         .chars_in_buffer = pty_chars_in_buffer,
>         .unthrottle = pty_unthrottle,
>         .ioctl = pty_bsd_ioctl,
> +       .compat_ioctl = pty_bsd_compat_ioctl,

           .compat_ioctl = pty_bsd_ioctl,

The separate handler would only be required when you need any kind
of special handling depending on the command.

> diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
> index 6116d5275a3e..112b3e1e20e3 100644
> --- a/fs/compat_ioctl.c
> +++ b/fs/compat_ioctl.c
> @@ -866,8 +866,6 @@ COMPATIBLE_IOCTL(TIOCGDEV)
>  COMPATIBLE_IOCTL(TIOCCBRK)
>  COMPATIBLE_IOCTL(TIOCGSID)
>  COMPATIBLE_IOCTL(TIOCGICOUNT)
> -COMPATIBLE_IOCTL(TIOCGPKT)
> -COMPATIBLE_IOCTL(TIOCGPTLCK)
>  COMPATIBLE_IOCTL(TIOCGEXCL)
>  /* Little t */
>  COMPATIBLE_IOCTL(TIOCGETD)
> @@ -883,16 +881,12 @@ COMPATIBLE_IOCTL(TIOCMGET)
>  COMPATIBLE_IOCTL(TIOCMBIC)
>  COMPATIBLE_IOCTL(TIOCMBIS)
>  COMPATIBLE_IOCTL(TIOCMSET)
> -COMPATIBLE_IOCTL(TIOCPKT)
>  COMPATIBLE_IOCTL(TIOCNOTTY)
>  COMPATIBLE_IOCTL(TIOCSTI)
>  COMPATIBLE_IOCTL(TIOCOUTQ)
>  COMPATIBLE_IOCTL(TIOCSPGRP)
>  COMPATIBLE_IOCTL(TIOCGPGRP)
> -COMPATIBLE_IOCTL(TIOCGPTN)
> -COMPATIBLE_IOCTL(TIOCSPTLCK)
>  COMPATIBLE_IOCTL(TIOCSERGETLSR)
> -COMPATIBLE_IOCTL(TIOCSIG)

Looks good.

       Arnd
