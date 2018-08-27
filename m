Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zNtx0XhVzDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 17:34:32 +1000 (AEST)
Date: Mon, 27 Aug 2018 09:33:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, hpa@zytor.com,
 deller@gmx.de, Andrew Morton <akpm@linux-foundation.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
 Simon Horman <horms@verge.net.au>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg KH <gregkh@linuxfoundation.org>, rth@twiddle.net,
 ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com,
 linux@armlinux.org.uk, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, msalter@redhat.com,
 jacquiot.aurelien@gmail.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>, rkuo@codeaurora.org,
 tony.luck@intel.com, fenghua.yu@intel.com,
 Geert Uytterhoeven <geert@linux-m68k.org>, monstr@monstr.eu,
 ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
 green.hu@gmail.com, deanbo422@gmail.com, lftan@altera.com,
 jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
 Stafford Horne <shorne@gmail.com>, jejb@parisc-linux.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 palmer@sifive.com, aou@eecs.berkeley.edu, schwidefsky@de.ibm.com,
 heiko.carstens@de.ibm.com, dalias@libc.org,
 "David S. Miller" <davem@davemloft.net>, gxt@pku.edu.cn,
 x86@kernel.org, jdike@addtoit.com, richard@nod.at, chris@zankel.net,
 jcmvbkbc@gmail.com, Tobias Klauser <tklauser@distanz.ch>,
 noamc@ezchip.com, mickael.guene@st.com, nicolas.pitre@linaro.org,
 Kees Cook <keescook@chromium.org>, Dave Martin <Dave.Martin@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>, alex.bennee@linaro.org,
 Laura Abbott <labbott@redhat.com>, Yury Norov <ynorov@caviumnetworks.com>,
 Mark Rutland <mark.rutland@arm.com>, chenhc@lemote.com,
 macro@mips.com, Arnd Bergmann <arnd@arndb.de>, dhowells@redhat.com,
 sukadev@linux.vnet.ibm.com, Nicholas Piggin <npiggin@gmail.com>,
 aneesh.kumar@linux.vnet.ibm.com, felix@linux.vnet.ibm.com,
 linuxram@us.ibm.com, christophe.leroy@c-s.fr, cohuck@redhat.com,
 gor@linux.vnet.ibm.com, nick.alcock@oracle.com,
 shannon.nelson@oracle.com, nagarathnam.muthusamy@oracle.com,
 luto@kernel.org, bp@suse.de, dave.hansen@linux.intel.com,
 vkuznets@redhat.com, jkosina@suse.cz, linux-alpha@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-snps-arc@lists.infradead.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-c6x-dev@linux-c6x.org, uclinux-h8-devel@lists.sourceforge.jp,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-m68k@vger.kernel.org, linux-mips@linux-mips.org,
 nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org
Subject: Re: [PATCH] treewide: remove current_text_addr
Message-ID: <20180827073358.GV24124@hirez.programming.kicks-ass.net>
References: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
 <20180821202900.208417-1-ndesaulniers@google.com>
 <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
 <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
 <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com>
 <7f49eeab-a5cc-867f-58fb-abd266f9c2c9@zytor.com>
 <6ca8a1d3-ff95-e9f4-f003-0a5af85bcb6f@zytor.com>
 <CA+55aFzuSCKfmgT9efHuwtan+m3+bPh4BpwbZwn5gGX_H=Thuw@mail.gmail.com>
 <CAKwvOd=wAaPBkFHAcWxgMW91a--9gbvu7xrt3j-q8c+-mT=7Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKwvOd=wAaPBkFHAcWxgMW91a--9gbvu7xrt3j-q8c+-mT=7Lw@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 26, 2018 at 07:52:59PM -0700, Nick Desaulniers wrote:
> On Sun, Aug 26, 2018 at 1:25 PM Linus Torvalds

> > Instead, maybe we could encourage something like
> >
> >   struct kernel_loc { const char *file; const char *fn; int line; };
> >
> >   #define __GEN_LOC__(n) \
> >         ({ static const struct kernel_loc n = { \
> >                 __FILE__, __FUNCTION__, __LINE__  \
> >            }; &n; })
> >
> >   #define _THIS_LOC_ __GEN_LOC__(__UNIQUE_ID(loc))
> >
> > which is a hell of a lot nicer to use, and actually allows gcc to
> > optimize things (try it: if you pass a _THIS_LOC_ off to an inline
> > function, and that inline function uses the name and line number, gcc
> > will pick them up directly, without the extra structure dereference.
> >
> > Wouldn't it be much nicer to pass these kinds of "location pointer"
> > around, rather than the nasty _THIS_IP_ thing?
> >
> > Certainly lockdep looks like it could easily take that "const struct
> > kernel_loc *" instead of "unsigned long ip". Makes it easy to print
> > out the lockdep info.

> This is extremely reasonable.  I can follow up with the lockdep folks
> to see if they really need _THIS_IP_ to solve their problem, or if
> there's a simpler solution that can solve their needs.  Sometimes
> taking a step back and asking for clarity around the big picture
> allows simpler solutions to shake out.

What problem are we trying to solve? _THIS_IP_ and _RET_IP_ work fine.
We're 'good' at dealing with text addresses, we use them for call stacks
and all sorts. Why does this need changing?
