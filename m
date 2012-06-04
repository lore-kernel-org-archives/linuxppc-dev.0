Return-Path: <olof@lixom.net>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BDAD9B6FCA
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2012 23:12:35 +1000 (EST)
Received: by pbbrp16 with SMTP id rp16so7180722pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jun 2012 06:12:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120604175858.38dac554@kryten>
References: <20120604175858.38dac554@kryten>
Date: Mon, 4 Jun 2012 06:12:33 -0700
Message-ID: <CAOesGMjm9fZs26pjGOvaUks+=_2N=v_CBeY89iVpXZcKkccMdg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Optimise the 64bit optimised __clear_user
From: Olof Johansson <olof@lixom.net>
To: Anton Blanchard <anton@samba.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: michael@ellerman.id.au, mikey@neuling.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Mon, Jun 4, 2012 at 12:58 AM, Anton Blanchard <anton@samba.org> wrote:
>
> I blame Mikey for this. He elevated my slightly dubious testcase:
>
> # dd if=3D/dev/zero of=3D/dev/null bs=3D1M count=3D10000
>
> to benchmark status. And naturally we need to be number 1 at creating
> zeros. So lets improve __clear_user some more.
>
> As Paul suggests we can use dcbz for large lengths. This patch gets
> the destination 128 byte aligned then uses dcbz on whole cachelines.
>
> Before:
> 10485760000 bytes (10 GB) copied, 0.414744 s, 25.3 GB/s
>
> After:
> 10485760000 bytes (10 GB) copied, 0.268597 s, 39.0 GB/s
>
> 39 GB/s, a new record.
>
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>
> Index: linux-build/arch/powerpc/lib/string_64.S
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-build.orig/arch/powerpc/lib/string_64.S =A0 =A0 =A0 2012-06-04 =
16:18:56.351604302 +1000
> +++ linux-build/arch/powerpc/lib/string_64.S =A0 =A02012-06-04 16:47:10.5=
38500871 +1000
> @@ -78,7 +78,7 @@ _GLOBAL(__clear_user)
[..]

> +15:
> +err2; =A0dcbz =A0 =A0r0,r3
> + =A0 =A0 =A0 addi =A0 =A0r3,r3,128
> + =A0 =A0 =A0 addi =A0 =A0r4,r4,-128
> + =A0 =A0 =A0 bdnz =A0 =A015b

This breaks architecture spec (and at least one implementation); cache
lines are not guaranteed to be 128 bytes.


-Olof
