Return-Path: <ebiederm@xmission.com>
Received: from etrn.xmission.com (etrn.xmission.com [198.60.22.17])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 90BD42C0174
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 May 2013 16:40:13 +1000 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
References: <519DCBEF.3090208@asianux.com>
Date: Thu, 23 May 2013 22:59:55 -0700
In-Reply-To: <519DCBEF.3090208@asianux.com> (Chen Gang's message of "Thu, 23
 May 2013 15:57:35 +0800")
Message-ID: <877gio3okk.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH] arch: configuration,
 deleting 'CONFIG_BUG' since always need it.
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, linux-sh@vger.kernel.org,
 heiko.carstens@de.ibm.com, "paulus@samba.org" <paulus@samba.org>,
 hpa@zytor.com, walken@google.com, egtvedt@samfundet.no,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 user-mode-linux-devel@lists.sourceforge.net, ysato@users.sourceforge.jp,
 richard@nod.at, deller@gmx.de, x86@kernel.org, jejb@parisc-linux.org,
 "mingo@redhat.com" <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Frederic Weisbecker <fweisbec@gmail.com>, paulmck@linux.vnet.ibm.com,
 hskinnemoen@gmail.com, Serge Hallyn <serge.hallyn@canonical.com>,
 Mike Frysinger <vapier@gentoo.org>, Arnd Bergmann <arnd@arndb.de>,
 Will Deacon <will.deacon@arm.com>, jdike@addtoit.com, akinobu.mita@gmail.com,
 user-mode-linux-user@lists.sourceforge.net,
 uclinux-dist-devel@blackfin.uclinux.org, Thomas Gleixner <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 linux-parisc@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 rkuo@codeaurora.org, lethal@linux-sh.org, linux-hexagon@vger.kernel.org,
 schwidefsky@de.ibm.com, linux390@de.ibm.com,
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

Chen Gang <gang.chen@asianux.com> writes:

> The crazy user can unset 'CONFIG_BUG' in menuconfig: "> General setup >
> Configure standard kernel features (expert users) > BUG() Support".
>
> But in fact, we always need it, and quite a few of architectures have
> already implemented it (e.g. alpha, arc, arm, avr32, blackfin, cris,
> frv, ia64, m68k, mips, mn10300, parisc, powerpc, s390, sh, sparc, x86).
>
> And kernel also already has prepared a default effective implementation
> for the architectures which is unwilling to implement it by themselves
> (e.g. arm64, c6x, h8300, hexagon, m32r, metag, microblaze, openrisc,
> score, tile, um, unicore32, xtensa).
>
> So need get rid of 'CONFIG_BUG', and let it always enabled everywhere.


This looks like the right way to handle this to me.  If the BUG
annotations are too big and not needed they should simply be deleted
from the code base.  Disabling CONFIG_BUG which removes the BUG
annotations from the binaries without modifying the source code seems
like the wrong approach.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
