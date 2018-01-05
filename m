Return-Path: <catalin.marinas@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zCsq86f7JzDqKl
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jan 2018 04:58:44 +1100 (AEDT)
Date: Fri, 5 Jan 2018 17:58:34 +0000
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
Subject: Re: [PATCH v7 07/10] kernel/jump_label: abstract jump_entry member
 accessors
Message-ID: <20180105175834.vqgpsme7itsdg54u@armageddon.cambridge.arm.com>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
 <20180102200549.22984-8-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180102200549.22984-8-ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 02, 2018 at 08:05:46PM +0000, Ard Biesheuvel wrote:
> diff --git a/arch/arm/include/asm/jump_label.h b/arch/arm/include/asm/jump_label.h
> index e12d7d096fc0..7b05b404063a 100644
> --- a/arch/arm/include/asm/jump_label.h
> +++ b/arch/arm/include/asm/jump_label.h
> @@ -45,5 +45,32 @@ struct jump_entry {
>  	jump_label_t key;
>  };
>  
> +static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
> +{
> +	return entry->code;
> +}
> +
> +static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
> +{
> +	return (struct static_key *)((unsigned long)entry->key & ~1UL);
> +}
> +
> +static inline bool jump_entry_is_branch(const struct jump_entry *entry)
> +{
> +	return (unsigned long)entry->key & 1UL;
> +}
> +
> +static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
> +{
> +	return entry->code == 0;
> +}
> +
> +static inline void jump_entry_set_module_init(struct jump_entry *entry)
> +{
> +	entry->code = 0;
> +}
> +
> +#define jump_label_swap		NULL

Is there any difference between these functions on any of the
architectures touched? Even with the relative offset, arm64 and x86
looked the same to me (well, I may have missed some detail).

-- 
Catalin
