Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A0F9C2C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 19:12:31 +1000 (EST)
Date: Thu, 23 May 2013 10:05:34 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since
 always need it.
Message-ID: <20130523090534.GJ18614@n2100.arm.linux.org.uk>
References: <519DCBEF.3090208@asianux.com>
 <CAMuHMdU7QuzgmWCH145p8PVebBzPo8DBAvbY+0AZa2cmGXmRHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMuHMdU7QuzgmWCH145p8PVebBzPo8DBAvbY+0AZa2cmGXmRHw@mail.gmail.com>
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

On Thu, May 23, 2013 at 10:40:29AM +0200, Geert Uytterhoeven wrote:
> On Thu, May 23, 2013 at 9:57 AM, Chen Gang <gang.chen@asianux.com> wrote:
> > -config BUG
> > -       bool "BUG() support" if EXPERT
> > -       default y
> > -       help
> > -          Disabling this option eliminates support for BUG and WARN, reducing
> > -          the size of your kernel image and potentially quietly ignoring
> > -          numerous fatal conditions. You should only consider disabling this
> > -          option for embedded systems with no facilities for reporting errors.
> > -          Just say Y.
> 
> ... It's about reducing memory size on devices where you can't show bug or
> warning messages.

And turning off CONFIG_BUG causes lots of warning messages at compile time
about functions which are returning nothing which shouldn't.

The problem is: trying to fix that _will_ mean the result is a larger
kernel than if you just do the usual arch-implemented thing of placing
an defined faulting instruction at the BUG() site - which defeats the
purpose of turning off CONFIG_BUG.

Therefore, it's better that CONFIG_BUG always be y and we stop kidding
ourselves that it's possible to turn this off and safely save space.
