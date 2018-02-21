Return-Path: <yamada.masahiro@socionext.com>
Received: from condef-03.nifty.com (condef-03.nifty.com [202.248.20.68])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zmTv92XHMzF0lN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 18:41:24 +1100 (AEDT)
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-03.nifty.com
 with ESMTP id w1L7dTLA023330
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 16:39:29 +0900
Received: from mail-vk0-f52.google.com (mail-vk0-f52.google.com
 [209.85.213.52]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id w1L7d8cB002271
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 16:39:08 +0900
Received: by mail-vk0-f52.google.com with SMTP id x203so405183vkx.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 23:39:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFkk2KT1krKuDkWt0eHcasfC61fTVQNf-1kqw7icLP9OYGYkXQ@mail.gmail.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
 <20180218221352.GA6651@ravnborg.org>
 <CAFkk2KT1krKuDkWt0eHcasfC61fTVQNf-1kqw7icLP9OYGYkXQ@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 21 Feb 2018 16:38:25 +0900
Message-ID: <CAK7LNAQH0WD3A3T97gce0xmZpMy0zWxTO2StfNWaDbiqjQg8gg@mail.gmail.com>
Subject: Re: [PATCH 00/23] kconfig: move compiler capability tests to Kconfig
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Michal Marek <michal.lkml@markovi.net>,
 Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
 kernel-hardening@lists.openwall.com, Jonathan Corbet <corbet@lwn.net>,
 sparclinux@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>,
 X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Rich Felker <dalias@libc.org>, Jeff Dike <jdike@addtoit.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 user-mode-linux-devel@lists.sourceforge.net,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 user-mode-linux-user@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Richard Weinberger <richard@nod.at>, Emese Revfy <re.emese@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2018-02-20 0:18 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:

>>
>> I'm not happy that we in one context can reference CONFIG variables
>> directly, but inside the $(call ...) and $(shell ...) needs the $ prefix.
>> But I could not come up with something un-ambigious where this could be avoided.
>
> I think we should be careful about allowing references to config
> symbols. It mixes up the parsing and evaluation phases, since $() is
> expanded during parsing (which I consider a feature and think is
> needed to retain sanity).
>
> Patch 06/23 removes the last existing instance of symbol references in
> strings by getting rid of 'option env'. That's an improvement to me.
> We shouldn't add it back.


This is really important design decision,
so I'd like to hear a little more from experts.


For example, x86 allows users to choose sub-arch, either 'i386' or 'x86_64'.

https://github.com/torvalds/linux/blob/v4.16-rc2/arch/x86/Kconfig#L4



If the user toggles CONFIG_64BIT,
the bi-arch compiler will work in a slightly different mode
(at least, back-end parts)

So, my question is, is there a case,

$(cc-option, -m32 -foo) is y, but
$(cc-option, -m64 -foo) is n  ?
(or vice versa)


If the answer is yes, $(cc-option -foo) would have to be re-calculated
every time CONFIG_64BIT is toggled.

This is what I'd like to avoid, though.



-- 
Best Regards
Masahiro Yamada
