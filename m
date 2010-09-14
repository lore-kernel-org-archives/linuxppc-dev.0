Return-Path: <timur.tabi@gmail.com>
Received: from mail-yx0-f170.google.com (mail-yx0-f170.google.com
	[209.85.213.170]) by ozlabs.org (Postfix) with ESMTP id 86E11B6EEE
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Sep 2010 02:06:04 +1000 (EST)
Received: by yxt33 with SMTP id 33so2605262yxt.15
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 09:06:02 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1282329921-24394-1-git-send-email-timur@freescale.com>
References: <1282329921-24394-1-git-send-email-timur@freescale.com>
From: Timur Tabi <timur@freescale.com>
Date: Tue, 14 Sep 2010 11:05:32 -0500
Message-ID: <AANLkTikn-DW6g9Zx07vR8hn7Zk3O=JMTe+r9CRbPe_YH@mail.gmail.com>
Subject: Re: [PATCH] hvc_console: fix dropping of characters when output byte
	channel is full
To: Andrew Morton <akpm@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: amit.shah@redhat.com, linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew,

Would you please take a moment to review this patch I sent last month?
I'd like for it to be incorporated into 2.6.37, but I'm having a hard
time finding someone to consider it.

Thanks.

On Fri, Aug 20, 2010 at 1:45 PM, Timur Tabi <timur@freescale.com> wrote:
> hvc_console_print() calls the HVC client driver's put_chars() callback
> to write some characters to the console. =A0If the callback returns 0, th=
at
> indicates that no characters were written (perhaps the output buffer is
> full), but hvc_console_print() treats that as an error and discards the
> rest of the buffer.
>
> So change hvc_console_print() to just loop and call put_chars() again if =
it
> returns a 0 return code.
>
> This change makes hvc_console_print() behave more like hvc_push(), which
> does check for a 0 return code and re-schedules itself.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> =A0drivers/char/hvc_console.c | =A0 19 ++++++++++++++++++-
> =A01 files changed, 18 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
> index fa27d16..b4deffd 100644
> --- a/drivers/char/hvc_console.c
> +++ b/drivers/char/hvc_console.c
> @@ -3,6 +3,7 @@
> =A0* Copyright (C) 2001 Paul Mackerras <paulus@au.ibm.com>, IBM
> =A0* Copyright (C) 2004 Benjamin Herrenschmidt <benh@kernel.crashing.org>=
, IBM Corp.
> =A0* Copyright (C) 2004 IBM Corporation
> + * Copyright 2009 Freescale Semiconductor, Inc.
> =A0*
> =A0* Additional Author(s):
> =A0* =A0Ryan S. Arnold <rsa@us.ibm.com>
> @@ -141,6 +142,7 @@ static void hvc_console_print(struct console *co, con=
st char *b,
> =A0 =A0 =A0 =A0char c[N_OUTBUF] __ALIGNED__;
> =A0 =A0 =A0 =A0unsigned i =3D 0, n =3D 0;
> =A0 =A0 =A0 =A0int r, donecr =3D 0, index =3D co->index;
> + =A0 =A0 =A0 unsigned int timeout =3D 1000000; /* Keep trying for up to =
one second */
>
> =A0 =A0 =A0 =A0/* Console access attempt outside of acceptable console ra=
nge. */
> =A0 =A0 =A0 =A0if (index >=3D MAX_NR_HVC_CONSOLES)
> @@ -152,6 +154,10 @@ static void hvc_console_print(struct console *co, co=
nst char *b,
>
> =A0 =A0 =A0 =A0while (count > 0 || i > 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (count > 0 && i < sizeof(c)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* If the local buffer (c) =
is not full, then copy some
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* bytes from the input b=
uffer to it. We stop when the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* local buffer is full. =
\n is converted to \r\n.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (b[n] =3D=3D '\n' && !d=
onecr) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0c[i++] =3D=
 '\r';
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0donecr =3D=
 1;
> @@ -162,14 +168,25 @@ static void hvc_console_print(struct console *co, c=
onst char *b,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r =3D cons_ops[index]->put=
_chars(vtermnos[index], c, i);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r <=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* throw a=
way chars on error */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (r > 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i -=3D r;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (i > 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0memmove(c, c+r, i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* If r =3D=
=3D 0, then the client driver didn't do
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* anythi=
ng, so wait 1us and try again. =A0If we
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* time o=
ut, then just exit.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!--time=
out)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Reset the timeout */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D 1000000;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> =A0}
> --
> 1.7.0.1
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Timur Tabi
Linux kernel developer at Freescale
