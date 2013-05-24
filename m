Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C7C362C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 May 2013 12:14:36 +1000 (EST)
Message-ID: <519ECCCF.8090909@asianux.com>
Date: Fri, 24 May 2013 10:13:35 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since always
 need it.
References: <519DCBEF.3090208@asianux.com> <201305231259.43750.arnd@arndb.de>
 <20130523112401.GO18614@n2100.arm.linux.org.uk>
 <201305231409.02359.arnd@arndb.de>
 <20130523125033.GP18614@n2100.arm.linux.org.uk>
 <CAMuHMdUzcBuDupe4Fa6XieziGPMpPKC_k8X8gUUmDvLJ+Fe=Hg@mail.gmail.com>
In-Reply-To: <CAMuHMdUzcBuDupe4Fa6XieziGPMpPKC_k8X8gUUmDvLJ+Fe=Hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Catalin Marinas <Catalin.Marinas@arm.com>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "paulus@samba.org" <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Michel Lespinasse <walken@google.com>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>,
 =?UTF-8?B?SMOldmFyZCBTa2lubmVtb2Vu?= <hskinnemoen@gmail.com>,
 Serge Hallyn <serge.hallyn@canonical.com>, Mike Frysinger <vapier@gentoo.org>,
 Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
 Jeff Dike <jdike@addtoit.com>, Akinobu Mita <akinobu.mita@gmail.com>,
 uml-user <user-mode-linux-user@lists.sourceforge.net>,
 "uclinux-dist-devel@blackfin.uclinux.org"
 <uclinux-dist-devel@blackfin.uclinux.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Richard Kuo <rkuo@codeaurora.org>, Paul Mundt <lethal@linux-sh.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, linux-hexagon@vger.kernel.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/23/2013 10:10 PM, Geert Uytterhoeven wrote:
> On Thu, May 23, 2013 at 2:50 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> > On Thu, May 23, 2013 at 02:09:02PM +0200, Arnd Bergmann wrote:
>>> >> On Thursday 23 May 2013, Russell King - ARM Linux wrote:
>>>> >> > This is the problem you guys are missing - unreachable() means "we lose
>>>> >> > control of the CPU at this point".
>>> >>
>>> >> I'm absolutely aware of this. Again, the current behaviour of doing nothing
>>> >> at all isn't very different from undefined behavior when you get when you
>>> >> get to the end of a function returning a pointer without a "return" statement,
>>> >> or when you return from a function that has determined that it is not safe
>>> >> to continue.
>> >
>> > Running off the end of a function like that is a different kettle of fish.
>> > The execution path is still as the compiler intends - what isn't is that
>> > the data returned is likely to be random trash.
>> >
>> > That's _quite_ different from the CPU starting to execute the contents
>> > of a literal data pool.
> I agree it's best to e.g. trap and reboot.

After read the arch/*/include/asm/bug.h,

It seems panic() is not suitable for NOMMU platforms (only m68k use it,
also need CONFIG_BUG and CONFIG_SUN3 enabled).

And unreachable() is need followed with an asm inline instruction (arm,
x86, powerpc mips...).

And __builtin_trap() is "the mechanism used may vary from release to
release so should not rely on any particular implementation" (ref to
"http://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html", used by m68k,
sparc, ia64).

I can not find any *trap*() and *unreachable*() in "include/asm-generic/"

I can not find any suitable implementation which 'generic' enough to add
in "include/asm-generic/" (and in fact, CONFIG_BUG itself is not
'generic' enough to be in "include/asm-generic/").


At last, I still suggest to delete CONFIG_BUG, so most of architectures
can skip this issue firstly.

Then for specific architectures, also can get 3 benefits:

a. the related maintainers can implement it as their own willing (not
need discus it with another platform maintainers again);

b. the related maintainers can free use the platform specific features
(which can not be used in "include/asm-generic/");

c. the related maintainers are more familiar their own architectures
demands and requirements.



----------- arch/m68k/include/asm/bug.h --------------------------------

  1 #ifndef _M68K_BUG_H
  2 #define _M68K_BUG_H
  3
  4 #ifdef CONFIG_MMU
  5 #ifdef CONFIG_BUG
  6 #ifdef CONFIG_DEBUG_BUGVERBOSE
  7 #ifndef CONFIG_SUN3
  8 #define BUG() do { \
  9         printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
 10         __builtin_trap(); \
 11 } while (0)
 12 #else
 13 #define BUG() do { \
 14         printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
 15         panic("BUG!"); \
 16 } while (0)
 17 #endif
 18 #else
 19 #define BUG() do { \
 20         __builtin_trap(); \
 21 } while (0)
 22 #endif
 23
 24 #define HAVE_ARCH_BUG
 25 #endif
 26 #endif /* CONFIG_MMU */
 27
 28 #include <asm-generic/bug.h>
 29
 30 #endif




Thanks.
-- 
Chen Gang

Asianux Corporation
