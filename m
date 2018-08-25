Return-Path: <linus971@gmail.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41yVwj2d7SzDqwt
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Aug 2018 07:02:57 +1000 (AEST)
Received: by mail-io0-x241.google.com with SMTP id n18-v6so9826644ioa.9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Aug 2018 14:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
 <20180821202900.208417-1-ndesaulniers@google.com>
In-Reply-To: <20180821202900.208417-1-ndesaulniers@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 Aug 2018 14:02:43 -0700
Message-ID: <CA+55aFxL-u3uvGGv0GOoHhEwV8fy=BCN1yScxKQiVMPoHtg=Wg@mail.gmail.com>
Subject: Re: [PATCH] treewide: remove current_text_addr
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Anvin <hpa@zytor.com>,
 Simon Horman <horms@verge.net.au>, Nathan Chancellor <natechancellor@gmail.com>,
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
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@sifive.com>,
 aou@eecs.berkeley.edu, Martin Schwidefsky <schwidefsky@de.ibm.com>,
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
 "Linux/m68k" <linux-m68k@lists.linux-m68k.org>,
 linux-mips <linux-mips@linux-mips.org>,
 "moderated list:NIOS2 ARCHITECTURE" <nios2-dev@lists.rocketboards.org>,
 openrisc@lists.librecores.org, Parisc List <linux-parisc@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-riscv@lists.infradead.org, linux-s390 <linux-s390@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>,
 linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 21, 2018 at 1:31 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> I suspect that current_text_addr predated GNU C extensions for statement
> expressions and/or taking the address of a label, then the macro was
> reimplemented for every new archs include/asm/processor.h, even though
> there were very few call sites, and none required an assembly
> implementation vs the C implementation.

I actually have this very dim memory that we had some compiler issues
where a label in the code resulted in gcc generating worse code
elsewhere in that same function.

But current_text_addr() predates both the git and the BK history, so
it's all shrouded in antiquity, and even if my dim recollection is
true, it may not be true any more. There aren't so many call sites
that it is likely to matter anyway.

             Linus
