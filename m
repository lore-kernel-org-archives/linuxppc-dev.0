Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18425.47270.756180.55444@cargo.ozlabs.ibm.com>
Date: Mon, 7 Apr 2008 16:01:10 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Update linker script to properly set physical
	addresses
In-Reply-To: <Pine.LNX.4.64.0804030128170.15263@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0804030128170.15263@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> We can set LOAD_OFFSET and use the AT attribute on sections and the
> linker will properly set the physical address of the LOAD program
> header for us.

Nice...

>  #define KERNELBASE      ASM_CONST(CONFIG_KERNEL_START)
>  #define PAGE_OFFSET	ASM_CONST(CONFIG_PAGE_OFFSET)
> +#define LOAD_OFFSET	ASM_CONST((CONFIG_KERNEL_START-CONFIG_PHYSICAL_START))

I think this should be CONFIG_PAGE_OFFSET - CONFIG_PHYSICAL_START
though.

Paul.
