Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 57A6ADDF14
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 04:11:25 +1100 (EST)
In-Reply-To: <20070321063150.04BA4DDE9F@ozlabs.org>
References: <20070321063150.04BA4DDE9F@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d33fab3c1f5376bc078ea1b805babbdc@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/4] powerpc: Add device tree utility functions to zImage
Date: Wed, 21 Mar 2007 18:10:21 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> @@ -262,6 +253,10 @@ void start(void *sp)
>  	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r",
>  	       _start, sp);
>
> +	/* Ensure that the device tree has a /chosen node */
> +	if (! finddevice("/chosen"))
> +		create_node(NULL, "chosen");
> +
>  	vmlinux = prep_kernel();
>  	initrd = prep_initrd(vmlinux, loader_info.initrd_addr,
>  			     loader_info.initrd_size);

So this is done early, and unconditional now?  Just
double checking, not enough context (for me, anyway)
in the patch itself.


Segher
