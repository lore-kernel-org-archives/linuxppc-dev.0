Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id E5D51DDDE7
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 15:35:46 +1100 (EST)
Date: Thu, 15 Mar 2007 15:35:46 +1100
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: Re: Don't pass the stack pointer to zImage's start() function
Message-ID: <20070315043546.GE12768@bakeyournoodle.com>
References: <20070315042904.GE14061@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070315042904.GE14061@localhost.localdomain>
From: tony@bakeyournoodle.com (Tony Breeds)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 15, 2007 at 03:29:04PM +1100, David Gibson wrote:
> At present, the zImage entry code passes a copy of the stack pointer
> to the start() function.  There's no real reason for this; the only
> thing start() does with it is print it out.  It appears to be a
> leftover debugging hack, so, this patch removes it.

<snip>

> --- working-2.6.orig/arch/powerpc/boot/main.c	2007-03-15 14:03:09.000000000 +1100
> +++ working-2.6/arch/powerpc/boot/main.c	2007-03-15 14:07:05.000000000 +1100
> @@ -256,7 +256,7 @@ struct dt_ops dt_ops;
>  struct console_ops console_ops;
>  struct loader_info loader_info;
>  
> -void start(void *sp)
> +void start(void)
>  {
>  	struct addr_range vmlinux, initrd;
>  	kernel_entry_t kentry;
> @@ -268,8 +268,7 @@ void start(void *sp)
>  	if (platform_ops.fixups)
>  		platform_ops.fixups();
>  
> -	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r",
> -	       _start, sp);
> +	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r", _start);

Shouldn't that be:

+	printf("\n\rzImage starting: loaded at 0x%p\n\r", _start);

or similar?

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
