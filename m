Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 41G5zv3CHQzF1KG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 01:14:34 +1000 (AEST)
Date: Wed, 27 Jun 2018 16:15:11 +0100
From: Will Deacon <will.deacon@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Kees Cook <keescook@chromium.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell King <linux@armlinux.org.uk>, Paul Mackerras <paulus@samba.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
 James Morris <jmorris@namei.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@linaro.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v9 0/6] add support for relative references in special
 sections
Message-ID: <20180627151510.GE30631@arm.com>
References: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ard,

On Tue, Jun 26, 2018 at 08:27:55PM +0200, Ard Biesheuvel wrote:
> This adds support for emitting special sections such as initcall arrays,
> PCI fixups and tracepoints as relative references rather than absolute
> references. This reduces the size by 50% on 64-bit architectures, but
> more importantly, it removes the need for carrying relocation metadata
> for these sections in relocatable kernels (e.g., for KASLR) that needs
> to be fixed up at boot time. On arm64, this reduces the vmlinux footprint
> of such a reference by 8x (8 byte absolute reference + 24 byte RELA entry
> vs 4 byte relative reference)
> 
> Patch #3 was sent out before as a single patch. This series supersedes
> the previous submission. This version makes relative ksymtab entries
> dependent on the new Kconfig symbol HAVE_ARCH_PREL32_RELOCATIONS rather
> than trying to infer from kbuild test robot replies for which architectures
> it should be blacklisted.
> 
> Patch #1 introduces the new Kconfig symbol HAVE_ARCH_PREL32_RELOCATIONS,
> and sets it for the main architectures that are expected to benefit the
> most from this feature, i.e., 64-bit architectures or ones that use
> runtime relocations.
> 
> Patch #2 add support for #define'ing __DISABLE_EXPORTS to get rid of
> ksymtab/kcrctab sections in decompressor and EFI stub objects when
> rebuilding existing C files to run in a different context.

I had a small question on patch 3, but it's really for my understanding.
So, for patches 1-3:

Reviewed-by: Will Deacon <will.deacon@arm.com>

Thanks,

Will
