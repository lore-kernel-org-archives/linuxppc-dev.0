Return-Path: <nicolas.pitre@linaro.org>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zB9hn3cr4zDqkt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jan 2018 10:47:19 +1100 (AEDT)
Received: by mail-qt0-x242.google.com with SMTP id u42so107838qte.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jan 2018 15:47:19 -0800 (PST)
Date: Tue, 2 Jan 2018 18:47:14 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
cc: linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Ralf Baechle <ralf@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell King <linux@armlinux.org.uk>, Paul Mackerras <paulus@samba.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>, Petr Mladek <pmladek@suse.com>,
 Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org,
 matt@codeblueprint.co.uk
Subject: Re: [PATCH v7 02/10] module: allow symbol exports to be disabled
In-Reply-To: <20180102200549.22984-3-ard.biesheuvel@linaro.org>
Message-ID: <nycvar.YSQ.7.76.1801021841410.8567@knanqh.ubzr>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
 <20180102200549.22984-3-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2 Jan 2018, Ard Biesheuvel wrote:

> To allow existing C code to be incorporated into the decompressor or
> the UEFI stub, introduce a CPP macro that turns all EXPORT_SYMBOL_xxx
> declarations into nops, and #define it in places where such exports
> are undesirable. Note that this gets rid of a rather dodgy redefine
> of linux/export.h's header guard.
[...]

> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -83,6 +83,15 @@ extern struct module __this_module;
>   */
>  #define __EXPORT_SYMBOL(sym, sec)	=== __KSYM_##sym ===
>  
> +#elif defined(__DISABLE_EXPORTS)
> +
> +/*
> + * Allow symbol exports to be disabled completely so that C code may
> + * be reused in other execution contexts such as the UEFI stub or the
> + * decompressor.
> + */
> +#define __EXPORT_SYMBOL(sym, sec)
> +

I think you should rather put this first thing in the #if sequence so to 
override the defined(__KSYM_DEPS__) case too.  No need to create build 
dependencies for module symbols that you're going to stub out 
afterwards anyway.


Nicolas
