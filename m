Return-Path: <yamada.masahiro@socionext.com>
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41L6hN35swzF1NW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 14:00:04 +1000 (AEST)
Received: from mail-ua0-f182.google.com (mail-ua0-f182.google.com
 [209.85.217.182]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id w643xfT6003500
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jul 2018 12:59:41 +0900
Received: by mail-ua0-f182.google.com with SMTP id z4-v6so2603751uao.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jul 2018 20:59:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703233430.14416-2-labbott@redhat.com>
References: <20180703233430.14416-1-labbott@redhat.com>
 <20180703233430.14416-2-labbott@redhat.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 4 Jul 2018 12:59:00 +0900
Message-ID: <CAK7LNAS7XBwDidNaLKC1wD+G30AyAvTHG5GN=UAiP5zz1EO8JA@mail.gmail.com>
Subject: Re: [PATCHv5 1/4] kbuild: Add build salt to the kernel and modules
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

Thanks for the update.


2018-07-04 8:34 GMT+09:00 Laura Abbott <labbott@redhat.com>:
>
> The build id generated from --build-id can be generated in several different
> ways, with the default being the sha1 on the output of the linked file. For
> distributions, it can be useful to make sure this ID is unique, even if the
> actual file contents don't change. The easiest way to do this is to insert
> a section with some data.
>
> Add an ELF note to both the kernel and module which contains some data based
> off of a config option.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v5: I used S-o-b here since the majority of the code was written
> already.


I think Suggested-by is good enough.
S-o-b is appended as a patch is passed from people to people.

Anyway, this looks good except one bike-shed.

> Please feel free to change the tag if you think it's not
> appropriate. I also tweaked this to take an ascii string instead of just
> a hex value since this makes things much easier on the distribution
> side.
> ---


> diff --git a/init/Kconfig b/init/Kconfig
> index 041f3a022122..8de789f40db9 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -107,6 +107,15 @@ config LOCALVERSION_AUTO
>
>           which is done within the script "scripts/setlocalversion".)
>
> +config BUILD_SALT
> +       string "Build ID Salt"
> +       default "Linux"


How about empty string ""
for default?




-- 
Best Regards
Masahiro Yamada
