Return-Path: <olof@lixom.net>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7BDD3B6FA8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2012 10:30:19 +1000 (EST)
Received: by pbbrp16 with SMTP id rp16so297630pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jun 2012 17:30:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120605120222.6722a3e3@kryten>
References: <20120604175858.38dac554@kryten> <20120605120222.6722a3e3@kryten>
Date: Wed, 6 Jun 2012 17:30:17 -0700
Message-ID: <CAOesGMj6rPD=tjOvP-A2O_FXPefySdRh5xKFF9Rk6GG4WWcBtA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Optimise the 64bit optimised __clear_user
From: Olof Johansson <olof@lixom.net>
To: Anton Blanchard <anton@samba.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mikey@neuling.org, michael@ellerman.id.au, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 4, 2012 at 7:02 PM, Anton Blanchard <anton@samba.org> wrote:
>
> I blame Mikey for this. He elevated my slightly dubious testcase:
>
> # dd if=/dev/zero of=/dev/null bs=1M count=10000
>
> to benchmark status. And naturally we need to be number 1 at creating
> zeros. So lets improve __clear_user some more.
>
> As Paul suggests we can use dcbz for large lengths. This patch gets
> the destination cacheline aligned then uses dcbz on whole cachelines.
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

Besides the comments from Segher, feel free to add:

Tested-by: Olof Johansson <olof@lixom.net>
Acked-by: Olof Johansson <olof@lixom.net>

Didn't help performance all that much on pa6t, but it didn't go down.
Too low on cycles to actually analyze why at this time.

-OIof
