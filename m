Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2137CC433F5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Dec 2021 19:10:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JFMBV3Tk3z3cTg
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Dec 2021 06:10:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4JFMB112gqz2yP3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Dec 2021 06:09:44 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 1BGIuSL3021510;
 Thu, 16 Dec 2021 12:56:28 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 1BGIuLq7021509;
 Thu, 16 Dec 2021 12:56:21 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Thu, 16 Dec 2021 12:56:20 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 00/13] Unify asm/unaligned.h around struct helper
Message-ID: <20211216185620.GP614@gate.crashing.org>
References: <20210514100106.3404011-1-arnd@kernel.org>
 <CAMj1kXG0CNomZ0aXxh_4094fT+g4bVWFCkrd7QwgTQgiqoxMWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG0CNomZ0aXxh_4094fT+g4bVWFCkrd7QwgTQgiqoxMWA@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-wireless@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
 "Richard Russon \(FlatCap\)" <ldm@flatcap.org>, X86 ML <x86@kernel.org>,
 Amitkumar Karwar <amitkarwar@gmail.com>, James Morris <jmorris@namei.org>,
 Eric Dumazet <edumazet@google.com>, Paul Mackerras <paulus@samba.org>,
 linux-m68k <linux-m68k@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 "open list:SPARC + UltraSPARC \(sparc/sparc64\)" <sparclinux@vger.kernel.org>,
 Stafford Horne <shorne@gmail.com>, linux-arch <linux-arch@vger.kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>, Yoshinori Sato <ysato@users.osdn.me>,
 Russell King <linux@armlinux.org.uk>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Kalle Valo <kvalo@codeaurora.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Jakub Kicinski <kuba@kernel.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Jonas Bonn <jonas@southpole.se>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Ganapathi Bhat <ganapathi017@gmail.com>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 linux-block@vger.kernel.org, openrisc@lists.librecores.org,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, Jens Axboe <axboe@kernel.dk>,
 Arnd Bergmann <arnd@kernel.org>, John Johansen <john.johansen@canonical.com>,
 Xinming Hu <huxinming820@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-ntfs-dev@lists.sourceforge.net, linux-security-module@vger.kernel.org,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 "open list:BPF JIT for MIPS \(32-BIT AND 64-BIT\)" <netdev@vger.kernel.org>,
 johannes@sipsolutions.net,
 "open list:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>,
 Sharvari Harisangam <sharvari.harisangam@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Dec 16, 2021 at 06:29:40PM +0100, Ard Biesheuvel wrote:
> I think this series is a huge improvement, but it does not solve the
> UB problem completely. As we found, there are open issues in the GCC
> bugzilla regarding assumptions in the compiler that aligned quantities
> either overlap entirely or not at all. (e.g.,
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=100363)

That isn't open, it was closed as INVALID back in May.

(Naturally) aligned quantities only overlap if they are the same datum.
This follows directly from the definition of (naturally) aligned.  There
is no mystery here.

All unaligned data need to be marked up properly.

> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is used in many places to
> conditionally emit code that violates C alignment rules.

Most of this is ABI, not C.  It is the ABI that requires certain
alignments.  Ignoring that plain does not work, but even if it would
you will end up with much slower generated code.

> whereas the following pattern makes more sense, I think, and does not
> violate any C rules in the common case:
> 
> #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>   // use unaligned accessors, which are cheap or even entirely free
> #else
>   // avoid unaligned accessors, as they are expensive; instead, reorganize
>   // the data so we don't need them (similar to setting NET_IP_ALIGN to 2)
> #endif

Yes, this looks more reasonable.

> The only remaining problem here is reinterpreting a char* pointer to a
> u32*, e.g., for accessing the IP address in an Ethernet frame when
> NET_IP_ALIGN == 2, which could suffer from the same UB problem again,
> as I understand it.

The problem is never casting a pointer to pointer to character type, and
then later back to an appriopriate pointer type.  These things are both
required to work.  The problem always is accessing something as if it
was something of another type, which is not valid C.  This however is
exactly what -fno-strict-aliasing allows, so that works as well.

But this does not have much to do with alignment.


Segher
