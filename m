Return-Path: <rusty@rustcorp.com.au>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 1/3] add support for exporting symbols from .S files
Date: Tue, 12 Aug 2008 12:03:56 +1000
References: <200808111606.44103.arnd@arndb.de>
	<200808111618.08206.arnd@arndb.de>
In-Reply-To: <200808111618.08206.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808121203.57182.rusty@rustcorp.com.au>
Cc: linux-arch@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Al Viro <viro@zeniv.linux.org.uk>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 12 August 2008 00:18:07 Arnd Bergmann wrote:
> This makes it possible to export symbols from assembly files, instead
> of having to export them through an extra ksyms.c file.
>
> I found this nicer to implement using a gas macro than a cpp macro.
...
> +	.ifeq BITS_PER_LONG-32
> +	.align 3
> +\symtab:
> +	.long \sym
> +	.long \strtab
> +	.else
> +	.align 4

Good work!   Hmm, you can .balign BITS_PER_LONG/8 outside the ifeq.  
Unfortunately .long doesn't do the Right Thing on 64 bit, so getting rid of 
the if is harder.

Acked-by: Rusty Russell <rusty@rustcorp.com.au>

Cheers,
Rusty.
