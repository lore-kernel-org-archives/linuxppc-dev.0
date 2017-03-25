Return-Path: <oohall@gmail.com>
Received: from mail-qt0-x233.google.com (mail-qt0-x233.google.com
 [IPv6:2607:f8b0:400d:c0d::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vqkS45Q8yzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 13:16:36 +1100 (AEDT)
Received: by mail-qt0-x233.google.com with SMTP id n21so5021326qta.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 19:16:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1596fddf-b6c0-02cc-cbbd-0f74606206aa@cisco.com>
References: <1596fddf-b6c0-02cc-cbbd-0f74606206aa@cisco.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Sat, 25 Mar 2017 13:16:33 +1100
Message-ID: <CAOSf1CFrhMJiD0XPboNVkgKvgG+EOdHJSzUsN8wVuB1YsO-K7g@mail.gmail.com>
Subject: Re: Build failure -- powerpc/boot: Add OPAL console to epapr wrappers
To: Daniel Walker <danielwa@cisco.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 xe-linux-external@cisco.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 25, 2017 at 4:00 AM, Daniel Walker <danielwa@cisco.com> wrote:
> I get this build failure,
>
>
> In file included from arch/powerpc/boot/fdt.c:51:
> ../arch/powerpc/boot/libfdt_env.h:9: error: redefinition of typedef
> 'uint32_t'
> ../arch/powerpc/boot/types.h:20: note: previous declaration of 'uint32_t'
> was here
> ../arch/powerpc/boot/libfdt_env.h:10: error: redefinition of typedef
> 'uint64_t'
> ../arch/powerpc/boot/types.h:21: note: previous declaration of 'uint64_t'
> was here
> make[2]: *** [arch/powerpc/boot/fdt.o] Error 1
> make[1]: *** [uImage] Error 2
> make[1]: Leaving directory `/nobackup/danielwa/linux/t1040'
> make: *** [sub-make] Error 2
>
>
> and it bisects to ,
>
>
> commit 656ad58ef19e2a763fa5c938b20ae0f6b8d67242
> Author: Oliver O'Halloran <oohall@gmail.com>
> Date:   Fri Jul 1 00:34:37 2016 +1000
>
>     powerpc/boot: Add OPAL console to epapr wrappers
>
>     This patch adds an OPAL console backend to the powerpc boot wrapper so
>     that decompression failures inside the wrapper can be reported to the
>     user. This is important since it typically indicates data corruption in
>     the firmware and other nasty things.
>
>     Currently this only works when building a little endian kernel. When
>     compiling a 64 bit BE kernel the wrapper is always build 32 bit to be
>     compatible with some 32 bit firmwares. BE support will be added at a
>     later date. Another limitation of this is that only the "raw" type of
>     OPAL console is supported, however machines that provide a hvsi console
>     also provide a raw console so this is not an issue in practice.
>
>     Actually-written-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>     Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
>     [mpe: Move #ifdef __powerpc64__ to avoid warnings on 32-bit]
>     Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
>
> I can provide a config file if needed. My apologies if this was already
> reported.

Thanks for the report, I don't think this is a known bug. mpe's build
testing is pretty thorough so I'm surprised this wasn't caught sooner.

A config file and the version of gcc that you're using would be useful.

Oliver
