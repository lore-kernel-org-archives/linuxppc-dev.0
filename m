Return-Path: <catalin.marinas@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zCsVP3dbGzDqlw
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jan 2018 04:41:24 +1100 (AEDT)
Date: Fri, 5 Jan 2018 17:41:12 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will.deacon@arm.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
 Nicolas Pitre <nico@linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Petr Mladek <pmladek@suse.com>, Kees Cook <keescook@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 James Morris <james.l.morris@oracle.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Ralf Baechle <ralf@linux-mips.org>, Thomas Garnier <thgarnie@google.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Jessica Yu <jeyu@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v7 05/10] PCI: Add support for relative addressing in
 quirk tables
Message-ID: <20180105174112.jk3mvo5qwg7l4vzo@armageddon.cambridge.arm.com>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
 <20180102200549.22984-6-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180102200549.22984-6-ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 02, 2018 at 08:05:44PM +0000, Ard Biesheuvel wrote:
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 10684b17d0bd..b6d51b4d5ce1 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3556,9 +3556,16 @@ static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
>  		     f->vendor == (u16) PCI_ANY_ID) &&
>  		    (f->device == dev->device ||
>  		     f->device == (u16) PCI_ANY_ID)) {
> -			calltime = fixup_debug_start(dev, f->hook);
> -			f->hook(dev);
> -			fixup_debug_report(dev, calltime, f->hook);
> +			void (*hook)(struct pci_dev *dev);
> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> +			hook = (void *)((unsigned long)&f->hook_offset +
> +					f->hook_offset);
> +#else
> +			hook = f->hook;
> +#endif

More of a nitpick but I've seen this pattern in several places in your
code, maybe worth defining a macro (couldn't come up with a better
name):

#define offset_to_ptr(off) \
	((void *)((unsigned long)&(off) + (off)))

-- 
Catalin
