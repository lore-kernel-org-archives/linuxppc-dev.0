Return-Path: <ndesaulniers@google.com>
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zGfS4ww1zDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 12:53:14 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id z25-v6so6711744pgu.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Aug 2018 19:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
 <20180821202900.208417-1-ndesaulniers@google.com>
 <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
 <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
 <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com>
 <7f49eeab-a5cc-867f-58fb-abd266f9c2c9@zytor.com>
 <6ca8a1d3-ff95-e9f4-f003-0a5af85bcb6f@zytor.com>
 <CA+55aFzuSCKfmgT9efHuwtan+m3+bPh4BpwbZwn5gGX_H=Thuw@mail.gmail.com>
In-Reply-To: <CA+55aFzuSCKfmgT9efHuwtan+m3+bPh4BpwbZwn5gGX_H=Thuw@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Sun, 26 Aug 2018 19:52:59 -0700
Message-ID: <CAKwvOd=wAaPBkFHAcWxgMW91a--9gbvu7xrt3j-q8c+-mT=7Lw@mail.gmail.com>
Subject: Re: [PATCH] treewide: remove current_text_addr
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: hpa@zytor.com, Peter Zijlstra <peterz@infradead.org>, deller@gmx.de,
 Andrew Morton <akpm@linux-foundation.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
 Simon Horman <horms@verge.net.au>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
 vgupta@synopsys.com, linux@armlinux.org.uk,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 msalter@redhat.com,
 jacquiot.aurelien@gmail.com, Yoshinori Sato <ysato@users.sourceforge.jp>,
 rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com,
 Geert Uytterhoeven <geert@linux-m68k.org>, monstr@monstr.eu,
 ralf@linux-mips.org,
 paul.burton@mips.com, jhogan@kernel.org, green.hu@gmail.com,
 deanbo422@gmail.com, lftan@altera.com, jonas@southpole.se,
 stefan.kristiansson@saunalahti.fi, Stafford Horne <shorne@gmail.com>,
 jejb@parisc-linux.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 palmer@sifive.com, aou@eecs.berkeley.edu, schwidefsky@de.ibm.com,
 heiko.carstens@de.ibm.com, dalias@libc.org,
 "David S. Miller" <davem@davemloft.net>, gxt@pku.edu.cn, x86@kernel.org,
 jdike@addtoit.com, richard@nod.at, chris@zankel.net, jcmvbkbc@gmail.com,
 Tobias Klauser <tklauser@distanz.ch>, noamc@ezchip.com, mickael.guene@st.com,
 nicolas.pitre@linaro.org, Kees Cook <keescook@chromium.org>,
 Dave Martin <Dave.Martin@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 alex.bennee@linaro.org,
 Laura Abbott <labbott@redhat.com>, Yury Norov <ynorov@caviumnetworks.com>,
 Mark Rutland <mark.rutland@arm.com>, chenhc@lemote.com, macro@mips.com,
 Arnd Bergmann <arnd@arndb.de>, dhowells@redhat.com, sukadev@linux.vnet.ibm.com,
 Nicholas Piggin <npiggin@gmail.com>, aneesh.kumar@linux.vnet.ibm.com,
 felix@linux.vnet.ibm.com, linuxram@us.ibm.com, christophe.leroy@c-s.fr,
 cohuck@redhat.com, gor@linux.vnet.ibm.com, nick.alcock@oracle.com,
 shannon.nelson@oracle.com, nagarathnam.muthusamy@oracle.com, luto@kernel.org,
 bp@suse.de, dave.hansen@linux.intel.com, vkuznets@redhat.com, jkosina@suse.cz,
 linux-alpha@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-snps-arc@lists.infradead.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-c6x-dev@linux-c6x.org,
 uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-m68k@vger.kernel.org,
 linux-mips@linux-mips.org, nios2-dev@lists.rocketboards.org,
 openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 26, 2018 at 1:25 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Honestly, I'd suggest:
>
>  - just do the current_text_addr() to _THIS_IP_ conversion
>
>  - keep _THIS_IP_ and make it be the generic one, and screw the whole
> "some architectures might implement is better" issue. Nobody cares.

And mention it to the compiler vendors as this seems like a case where
code gen can be improved.

>
>  - try to convince people to move away from the "we want the kernel
> instruction pointer for the call" model entirely, and consider this a
> "legacy" issue.
>
> The whole instruction pointer is a nasty thing. We should discourage
> it and not make complex infrastructure for it.

Yes, please.  I think we should strive for simplicity here.

>
> Instead, maybe we could encourage something like
>
>   struct kernel_loc { const char *file; const char *fn; int line; };
>
>   #define __GEN_LOC__(n) \
>         ({ static const struct kernel_loc n = { \
>                 __FILE__, __FUNCTION__, __LINE__  \
>            }; &n; })
>
>   #define _THIS_LOC_ __GEN_LOC__(__UNIQUE_ID(loc))
>
> which is a hell of a lot nicer to use, and actually allows gcc to
> optimize things (try it: if you pass a _THIS_LOC_ off to an inline
> function, and that inline function uses the name and line number, gcc
> will pick them up directly, without the extra structure dereference.
>
> Wouldn't it be much nicer to pass these kinds of "location pointer"
> around, rather than the nasty _THIS_IP_ thing?
>
> Certainly lockdep looks like it could easily take that "const struct
> kernel_loc *" instead of "unsigned long ip". Makes it easy to print
> out the lockdep info.
>
> Ok, I didn't try to convert anybody, so maybe people who currently use
> _THIS_IP_ or current_text_addr() have some fundamental reason why they
> want just that, but let's not male _THIS_IP_ more complex than it
> needs to be.
>
> Hmm?
>
>              Linus

This is extremely reasonable.  I can follow up with the lockdep folks
to see if they really need _THIS_IP_ to solve their problem, or if
there's a simpler solution that can solve their needs.  Sometimes
taking a step back and asking for clarity around the big picture
allows simpler solutions to shake out.
-- 
Thanks,
~Nick Desaulniers
