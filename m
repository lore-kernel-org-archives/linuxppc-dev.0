Return-Path: <yamada.masahiro@socionext.com>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41L6ch6NZdzF0X5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 13:56:52 +1000 (AEST)
Received: from mail-vk0-f51.google.com (mail-vk0-f51.google.com
 [209.85.213.51]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id w643uH3G020307
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jul 2018 12:56:17 +0900
Received: by mail-vk0-f51.google.com with SMTP id j11-v6so2331315vke.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jul 2018 20:56:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703233430.14416-5-labbott@redhat.com>
References: <20180703233430.14416-1-labbott@redhat.com>
 <20180703233430.14416-5-labbott@redhat.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 4 Jul 2018 12:55:35 +0900
Message-ID: <CAK7LNARxwNkzkUif9dj1oVFGYP4J41C+t=W4YFVxM+J94siGvA@mail.gmail.com>
Subject: Re: [PATCHv5 4/4] arm64: Add build salt to the vDSO
To: Laura Abbott <labbott@redhat.com>
Cc: Mark Wielaard <mjw@fedoraproject.org>, "H . J . Lu" <hjl.tools@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
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

2018-07-04 8:34 GMT+09:00 Laura Abbott <labbott@redhat.com>:
>
> The vDSO needs to have a unique build id in a similar manner
> to the kernel and modules. Use the build salt macro.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v5: I was previously focused on x86 only but since powerpc gave a patch,
> I figured I would do arm64 since the changes were also fairly simple.
> ---
>  arch/arm64/kernel/vdso/note.S | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/kernel/vdso/note.S b/arch/arm64/kernel/vdso/note.S
> index b82c85e5d972..2c429dfd3f45 100644
> --- a/arch/arm64/kernel/vdso/note.S
> +++ b/arch/arm64/kernel/vdso/note.S
> @@ -22,7 +22,10 @@
>  #include <linux/uts.h>
>  #include <linux/version.h>
>  #include <linux/elfnote.h>
> +#include <linux/build-salt.h>
>
>  ELFNOTE_START(Linux, 0, "a")
>         .long LINUX_VERSION_CODE
>  ELFNOTE_END
> +
> +BUILD_SALT;



I think this works, but
I prefer no-semicolon in assembly files.

For coding consistency,
I want ';' as statement delimiter in .c files.
But, only new line after each statement in .S files.

For example, in arch/x86/xen/xen-head.S
I see no semicolon after ELFNOTE().

I found this:
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0473k/dom1359731141352.html
It says ';' starts a comment line
although it is not the case of GAS.


Same for 3/4.



-- 
Best Regards
Masahiro Yamada
