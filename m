Return-Path: <oohall@gmail.com>
Received: from mail-qg0-x231.google.com (mail-qg0-x231.google.com
 [IPv6:2607:f8b0:400d:c04::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJYH56YtyzDqXx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 09:48:49 +1000 (AEST)
Received: by mail-qg0-x231.google.com with SMTP id e93so83908111qgf.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 16:48:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFwQ9hFt7Zh2CRvLKh-7wi4yxJi3vd8ddPPNxcniKQ+KiuM3WQ@mail.gmail.com>
References: <CAFwQ9hGFeC2700F3yy4vYVNdbO3vid=9hH_qO-5PbOuRDAHGdw@mail.gmail.com>
 <1128bc83-dcaa-718b-4faf-0a58b789dbec@c-s.fr>
 <CAFwQ9hFt7Zh2CRvLKh-7wi4yxJi3vd8ddPPNxcniKQ+KiuM3WQ@mail.gmail.com>
Date: Tue, 31 May 2016 09:48:46 +1000
Message-ID: <CAOSf1CH6QsCzj9oY0RmAKX_uTvmD9Yt_pV=_3xp-SD=5pp+uUg@mail.gmail.com>
Subject: Re: powerpc cross compiler issue
From: oliver <oohall@gmail.com>
To: Safa Hamza <safahamza1@gmail.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 26, 2016 at 9:29 PM, Safa Hamza <safahamza1@gmail.com> wrote:
>
> thanks for replying, I tried a powerpc cross compiler from the list you have
> send but I always got this error
>
>  VDSO32L arch/powerpc/kernel/vdso32/vdso32.so.dbg
> /home/marwa/Bureau/lauterbach/powerpc/gcc-4.6.3-nolibc/powerpc64-linux/bin/../lib/gcc/powerpc64-linux/4.6.3/../../../../powerpc64-linux/bin/ld:
> arch/powerpc/kernel/vdso32/note.o: compiled for a little endian system and
> target is big endian
> /home/marwa/Bureau/lauterbach/powerpc/gcc-4.6.3-nolibc/powerpc64-linux/bin/../lib/gcc/powerpc64-linux/4.6.3/../../../../powerpc64-linux/bin/ld:
> failed to merge target specific data of file
> arch/powerpc/kernel/vdso32/note.o
> collect2: ld returned 1 exit status
> make[2]: *** [arch/powerpc/kernel/vdso32/vdso32.so.dbg] Erreur 1
> make[1]: *** [arch/powerpc/kernel/vdso32] Erreur 2
> make: *** [arch/powerpc/kernel] Erreur 2

This kind of error is  usually caused by building for one endianess
then changing endianness in the kernel configuration. The build system
isn't smart enough to realise that it needs to recompile the VDSO when
this happens so you'll get linker errors unless you clean the build
directory with `make mrproper` or similar.

We should probably fix that.
