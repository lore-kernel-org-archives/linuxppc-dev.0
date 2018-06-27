Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Fs5w6hwGzF164
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2018 15:33:56 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>,
 Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell King <linux@armlinux.org.uk>, Paul Mackerras <paulus@samba.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>,
 Ingo Molnar <mingo@redhat.com>, James Morris <jmorris@namei.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@linaro.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Jessica Yu <jeyu@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: Re: [PATCH v9 0/6] add support for relative references in special
 sections
In-Reply-To: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
References: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
Date: Wed, 27 Jun 2018 15:33:44 +1000
Message-ID: <87r2ks6bev.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
> This adds support for emitting special sections such as initcall arrays,
> PCI fixups and tracepoints as relative references rather than absolute
> references. This reduces the size by 50% on 64-bit architectures, but
> more importantly, it removes the need for carrying relocation metadata
> for these sections in relocatable kernels (e.g., for KASLR) that needs
> to be fixed up at boot time. On arm64, this reduces the vmlinux footprint
> of such a reference by 8x (8 byte absolute reference + 24 byte RELA entry
> vs 4 byte relative reference)
...
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>

This seems to be working on powerpc.

It boots on a couple of machines with no obvious badness.

And there's some size reduction with a random config I had lying around:

  Total: Before=14820494, After=14673313, chg -0.99%


It can get some more testing once it's in linux-next as far as I'm
concerned.

  Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
