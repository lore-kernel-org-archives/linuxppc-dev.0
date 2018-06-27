Return-Path: <sergey.senozhatsky@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41G4p94DGXzDrbK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 00:20:58 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id c10-v6so988308pgu.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2018 07:20:58 -0700 (PDT)
Date: Wed, 27 Jun 2018 23:20:53 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
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
Subject: Re: [PATCH v9 4/6] init: allow initcall tables to be emitted using
 relative references
Message-ID: <20180627142053.GB477@tigerII.localdomain>
References: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
 <20180626182802.19932-5-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180626182802.19932-5-ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (06/26/18 20:27), Ard Biesheuvel wrote:
>  /*
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 247808333ba4..688a27b0888c 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2772,7 +2772,8 @@ EXPORT_SYMBOL(unregister_console);
>  void __init console_init(void)
>  {
>  	int ret;
> -	initcall_t *call;
> +	initcall_t call;
> +	initcall_entry_t *ce;
>  
>  	/* Setup the default TTY line discipline. */
>  	n_tty_init();
> @@ -2781,13 +2782,14 @@ void __init console_init(void)
>  	 * set up the console device so that later boot sequences can
>  	 * inform about problems etc..
>  	 */
> -	call = __con_initcall_start;
> +	ce = __con_initcall_start;
>  	trace_initcall_level("console");
> -	while (call < __con_initcall_end) {
> -		trace_initcall_start((*call));
> -		ret = (*call)();
> -		trace_initcall_finish((*call), ret);
> -		call++;
> +	while (ce < __con_initcall_end) {
> +		call = initcall_from_entry(ce);
> +		trace_initcall_start(call);
> +		ret = call();
> +		trace_initcall_finish(call, ret);
> +		ce++;
>  	}
>  }

printk bits look OK to me.
The patch set works fine on my x86_64 and does reduce the size of vmlinux.

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
