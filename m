Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.187]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AE1F02C02C3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 01:49:07 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] arch: configuration,
 deleting 'CONFIG_BUG' since always need it.
Date: Tue, 28 May 2013 17:43:52 +0200
References: <519DCBEF.3090208@asianux.com> <20130528081910.GA29557@gmail.com>
 <51A4C564.4040301@zytor.com>
In-Reply-To: <51A4C564.4040301@zytor.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201305281743.52649.arnd@arndb.de>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>,
 Linux-sh list <linux-sh@vger.kernel.org>, Chen Gang <gang.chen@asianux.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "paulus@samba.org" <paulus@samba.org>, Michel Lespinasse <walken@google.com>,
 Ingo Molnar <mingo@kernel.org>, Hans-Christian Egtvedt <egtvedt@samfundet.no>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>,
 H?vard Skinnemoen <hskinnemoen@gmail.com>,
 Serge Hallyn <serge.hallyn@canonical.com>, Mike Frysinger <vapier@gentoo.org>,
 uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
 Will Deacon <will.deacon@arm.com>, Jeff Dike <jdike@addtoit.com>,
 Akinobu Mita <akinobu.mita@gmail.com>,
 uml-user <user-mode-linux-user@lists.sourceforge.net>,
 "uclinux-dist-devel@blackfin.uclinux.org"
 <uclinux-dist-devel@blackfin.uclinux.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
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

On Tuesday 28 May 2013, H. Peter Anvin wrote:
> On 05/28/2013 01:19 AM, Ingo Molnar wrote:
> > 
> > So I think the same principle applies to it as to any other debugging 
> > code: it's fine to be able to turn debugging off. It's a performance 
> > versus kernel robustness/determinism trade-off.
> > 
> 
> I suspect, rather, that BUG() should turn into a trap (or jump to a
> death routine) under any circumstances.  The one thing that can be
> omitted for small configurations are the annotations, which only serve
> to output a more human-readable error message.

Right, that is what the patch I just posted does.

On a related note, I found that WARN_ON() can no longer be compiled
out since there is already code that relies on the side-effects of
the condition. I assume that was an intentional change I missed,
since it used to be defined so that you could remove it completely.

	Arnd
