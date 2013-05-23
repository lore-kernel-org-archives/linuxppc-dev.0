Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 783BC2C0178
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 20:32:36 +1000 (EST)
Date: Thu, 23 May 2013 11:29:34 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since
 always need it.
Message-ID: <20130523102934.GN18614@n2100.arm.linux.org.uk>
References: <519DCBEF.3090208@asianux.com>
 <20130523090534.GJ18614@n2100.arm.linux.org.uk>
 <CAMuHMdWez-j1Maa3BD7ucmzv0_zFJnChERQiHFmkCaZUzG0_AA@mail.gmail.com>
 <201305231139.38233.arnd@arndb.de> <878v369fdd.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <878v369fdd.fsf@xmission.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>,
 Linux-sh list <linux-sh@vger.kernel.org>, Chen Gang <gang.chen@asianux.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "paulus@samba.org" <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Michel Lespinasse <walken@google.com>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org,
 uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>,
 =?iso-8859-1?Q?H=E5vard?= Skinnemoen <hskinnemoen@gmail.com>,
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
 linux-hexagon@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
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

On Thu, May 23, 2013 at 03:09:50AM -0700, Eric W. Biederman wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > On Thursday 23 May 2013, Geert Uytterhoeven wrote:
> >> > The problem is: trying to fix that will mean the result is a larger
> >> > kernel than if you just do the usual arch-implemented thing of placing
> >> > an defined faulting instruction at the BUG() site - which defeats the
> >> > purpose of turning off CONFIG_BUG.
> >> 
> >> Is __builtin_unreachable() working well these days?
> >> 
> >
> > Hmm, I just tried the trivial patch below, which seemed to do the right thing.
> > Needs a little more investigation, but that might actually be the correct
> > solution. I thought that at some point __builtin_unreachable() was the same
> > as "do {} while (1)", but this is not the case with the gcc I was using --
> > it just tells gcc that we don't expect to ever get here.
> 
> Yes.
> 
> We already have this abstracted in compiler.h as the macro unreachable,
> so the slight modification of your patch below should handle this case.
> 
> For compilers without __builtin_unreachable() unreachable() expands to
> do {} while(1) but an infinite loop seems reasonable and preserves the
> semantics of the code, unlike the current noop that is do {} while(0).

Semantics of the code really don't come in to it if you use unreachable().
unreachable() is an effective do { } while (0) to the compiler.  It just
doesn't warn about it anymore.  It's actually worse than that - it's
permission to the compiler to just stop considering flow control at that
point and do anything it likes with the following instruction slot.

What __builtin_unreachable() means to the compiler is "we will *never*
get here".  That isn't the case for BUG() - BUG() means "we hope that
we will never get here, but we might, and if we do your data is in
grave danger."

We should either have something at that point (like a call to a function
which panics) or remove the ability to turn off CONFIG_BUG and anyone who
cares about kernel size needs to come up with a single trapping
instruction BUG() implementation.
