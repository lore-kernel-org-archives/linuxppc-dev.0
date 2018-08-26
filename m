Return-Path: <linus971@gmail.com>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41z62w656KzDr4h
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 06:25:28 +1000 (AEST)
Received: by mail-it0-x242.google.com with SMTP id g18-v6so8471809itg.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Aug 2018 13:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
 <20180821202900.208417-1-ndesaulniers@google.com>
 <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
 <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
 <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com>
 <7f49eeab-a5cc-867f-58fb-abd266f9c2c9@zytor.com>
 <6ca8a1d3-ff95-e9f4-f003-0a5af85bcb6f@zytor.com>
In-Reply-To: <6ca8a1d3-ff95-e9f4-f003-0a5af85bcb6f@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 26 Aug 2018 13:25:14 -0700
Message-ID: <CA+55aFzuSCKfmgT9efHuwtan+m3+bPh4BpwbZwn5gGX_H=Thuw@mail.gmail.com>
Subject: Re: [PATCH] treewide: remove current_text_addr
To: Peter Anvin <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Helge Deller <deller@gmx.de>, Nick Desaulniers <ndesaulniers@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Simon Horman <horms@verge.net.au>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
 Vineet Gupta <vgupta@synopsys.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Mark Salter <msalter@redhat.com>, jacquiot.aurelien@gmail.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 James Hogan <jhogan@kernel.org>, Greentime Hu <green.hu@gmail.com>,
 deanbo422@gmail.com,
 Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Rich Felker <dalias@libc.org>, David Miller <davem@davemloft.net>,
 gxt@pku.edu.cn,
 "the arch/x86 maintainers" <x86@kernel.org>, Jeff Dike <jdike@addtoit.com>,
 Richard Weinberger <richard@nod.at>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Tobias Klauser <tklauser@distanz.ch>, noamc@ezchip.com, mickael.guene@st.com,
 Nicolas Pitre <nicolas.pitre@linaro.org>, Kees Cook <keescook@chromium.org>,
 Dave Martin <Dave.Martin@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 alex.bennee@linaro.org,
 Laura Abbott <labbott@redhat.com>, ynorov@caviumnetworks.com,
 Mark Rutland <mark.rutland@arm.com>, "chenhc@lemote.com" <chenhc@lemote.com>,
 "Maciej W. Rozycki" <macro@mips.com>, Arnd Bergmann <arnd@arndb.de>,
 David Howells <dhowells@redhat.com>,
 sukadev@linux.vnet.ibm.com, Nick Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K. V" <aneesh.kumar@linux.vnet.ibm.com>, felix@linux.vnet.ibm.com,
 Ram Pai <linuxram@us.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>,
 Cornelia Huck <cohuck@redhat.com>, gor@linux.vnet.ibm.com,
 nick.alcock@oracle.com,
 shannon.nelson@oracle.com, nagarathnam.muthusamy@oracle.com,
 Andrew Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
 linux-alpha@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 arcml <linux-snps-arc@lists.infradead.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-c6x-dev@linux-c6x.org,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 linux-hexagon@vger.kernel.org,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "Linux/m68k" <linux-m68k@vger.kernel.org>,
 linux-mips <linux-mips@linux-mips.org>,
 "moderated list:NIOS2 ARCHITECTURE" <nios2-dev@lists.rocketboards.org>,
 openrisc@lists.librecores.org, Parisc List <linux-parisc@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-riscv@lists.infradead.org, linux-s390 <linux-s390@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 26, 2018 at 12:32 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> Here is a full-blown (user space) test program demonstrating the whole
> technique and how to use it.

So while I agree that some _THIS_IP_ users might be better off being
converted to __builtin_return_address(0) at the caller, I also think
that the whole "notailcall" thing shows why that can easily be more
problematic than just our currnet _THIS_IP_ solution.

Honestly, I'd suggest:

 - just do the current_text_addr() to _THIS_IP_ conversion

 - keep _THIS_IP_ and make it be the generic one, and screw the whole
"some architectures might implement is better" issue. Nobody cares.

 - try to convince people to move away from the "we want the kernel
instruction pointer for the call" model entirely, and consider this a
"legacy" issue.

The whole instruction pointer is a nasty thing. We should discourage
it and not make complex infrastructure for it.

Instead, maybe we could encourage something like

  struct kernel_loc { const char *file; const char *fn; int line; };

  #define __GEN_LOC__(n) \
        ({ static const struct kernel_loc n = { \
                __FILE__, __FUNCTION__, __LINE__  \
           }; &n; })

  #define _THIS_LOC_ __GEN_LOC__(__UNIQUE_ID(loc))

which is a hell of a lot nicer to use, and actually allows gcc to
optimize things (try it: if you pass a _THIS_LOC_ off to an inline
function, and that inline function uses the name and line number, gcc
will pick them up directly, without the extra structure dereference.

Wouldn't it be much nicer to pass these kinds of "location pointer"
around, rather than the nasty _THIS_IP_ thing?

Certainly lockdep looks like it could easily take that "const struct
kernel_loc *" instead of "unsigned long ip". Makes it easy to print
out the lockdep info.

Ok, I didn't try to convert anybody, so maybe people who currently use
_THIS_IP_ or current_text_addr() have some fundamental reason why they
want just that, but let's not male _THIS_IP_ more complex than it
needs to be.

Hmm?

             Linus
