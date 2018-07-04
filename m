Return-Path: <yamada.masahiro@socionext.com>
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41L6fg2v6dzF1LS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 13:58:34 +1000 (AEST)
Received: from mail-vk0-f53.google.com (mail-vk0-f53.google.com
 [209.85.213.53]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id w643wHqh003027
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jul 2018 12:58:18 +0900
Received: by mail-vk0-f53.google.com with SMTP id j11-v6so2332927vke.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jul 2018 20:58:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703232200.11315-1-labbott@redhat.com>
References: <20180703232200.11315-1-labbott@redhat.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 4 Jul 2018 12:57:36 +0900
Message-ID: <CAK7LNAR4ed62CjH-i5YSL5ngW5aMRbMpKZn8UhNQ20KoMwP9cQ@mail.gmail.com>
Subject: Re: [PATCHv5 0/4] Salted build ids via ELF notes
To: Laura Abbott <labbott@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>, Mark Wielaard <mjw@fedoraproject.org>,
 "H . J . Lu" <hjl.tools@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi.

2018-07-04 8:21 GMT+09:00 Laura Abbott <labbott@redhat.com>:
>
> Hi,
>
> This is v5 of the series to allow unique build ids in the kernel. As a
> reminder of the context:




> ""
> In Fedora, the debug information is packaged separately (foo-debuginfo) and
> can be installed separately. There's been a long standing issue where only one
> version of a debuginfo info package can be installed at a time. Mark Wielaard
> made an effort for Fedora 27 to allow parallel installation of debuginfo (see
> https://fedoraproject.org/wiki/Changes/ParallelInstallableDebuginfo for
> more details)
>
> Part of the requirement to allow this to work is that build ids are
> unique between builds. The existing upstream rpm implementation ensures
> this by re-calculating the build-id using the version and release as a
> seed. This doesn't work 100% for the kernel because of the vDSO which is
> its own binary and doesn't get updated. After poking holes in a few of my
> ideas, there was a discussion with some people from the binutils team about
> adding --build-id-salt to let ld do the calculation debugedit is doing. There
> was a counter proposal made to add in the salt while building. The
> easiest proposal was to add an item in the linker script vs. linking in
> an object since we need the salt to go in every module as well as the
> kernel and vmlinux.
> ""

I think this information is helpful to explain the background
of this work, but the cover letter cannot be committed in git.

Could you add this in 1/4 please?


If I read only the simple log in 1/4,
I would wonder why it is useful...







> v5 uses the approach suggested by Masahiro Yamada which uses the
> existing ELF note macro to more easily add the salt (vs previous
> approaches which tried to adjust via linker section).
>
> If arch maintainers are okay, I'd like acks for this so this can go
> through the kbuild tree.
>
> Thanks,
> Laura
>
> Laura Abbott (4):
>   kbuild: Add build salt to the kernel and modules
>   x86: Add build salt to the vDSO
>   powerpc: Add build salt to the vDSO
>   arm64: Add build salt to the vDSO
>
>  arch/arm64/kernel/vdso/note.S     |  3 +++
>  arch/powerpc/kernel/vdso32/note.S |  3 +++
>  arch/x86/entry/vdso/vdso-note.S   |  3 +++
>  arch/x86/entry/vdso/vdso32/note.S |  3 +++
>  include/linux/build-salt.h        | 20 ++++++++++++++++++++
>  init/Kconfig                      |  9 +++++++++
>  init/version.c                    |  3 +++
>  scripts/mod/modpost.c             |  3 +++
>  8 files changed, 47 insertions(+)
>  create mode 100644 include/linux/build-salt.h
>
> --
> 2.17.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
