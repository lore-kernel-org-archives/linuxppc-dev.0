Return-Path: <anton@samba.org>
Date: Wed, 31 Aug 2011 14:23:48 +1000
From: Anton Blanchard <anton@samba.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 05/10] fadump: Convert firmware-assisted cpu state
	dump data into elf notes.
Message-ID: <20110831142348.7ef28a18@kryten>
In-Reply-To: <20110713180722.6210.20251.stgit@mars.in.ibm.com>
References: <20110713180252.6210.34810.stgit@mars.in.ibm.com>
	<20110713180722.6210.20251.stgit@mars.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Milton Miller <miltonm@bga.com>, Michael Ellerman <michael@ellerman.id.au>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> diff --git a/kernel/panic.c b/kernel/panic.c
> index 6923167..1965b50 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -49,6 +49,15 @@ static long no_blink(int state)
>  long (*panic_blink)(int state);
>  EXPORT_SYMBOL(panic_blink);
>  
> +#ifdef CONFIG_FA_DUMP
> +/*
> + * provide an empty default implementation here -- architecture
> + * code may override this
> + */
> +void __attribute__ ((weak)) crash_fadump(struct pt_regs *regs, const char *str)
> +{}
> +#endif
> +
>  /**
>   *	panic - halt the system
>   *	@fmt: The text string to print
> @@ -81,6 +90,13 @@ NORET_TYPE void panic(const char * fmt, ...)
>  	dump_stack();
>  #endif
>  
> +#ifdef CONFIG_FA_DUMP
> +	/*
> +	 * If firmware-assisted dump has been registered then trigger
> +	 * firmware-assisted dump and let firmware handle everything else.
> +	 */
> +	crash_fadump(NULL, buf);
> +#endif
>  	/*
>  	 * If we have crashed and we have a crash kernel loaded let it handle
>  	 * everything else.

Firmware assisted dump is an IBM POWER Systems specific feature and it
shouldn't leak into a common file like this. Isn't there an existing
hook we can catch like the panic notifier?

Anton
