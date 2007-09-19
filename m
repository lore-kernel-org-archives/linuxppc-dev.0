Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A595EDDE42
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 06:16:48 +1000 (EST)
Message-ID: <46F183A9.4060500@freescale.com>
Date: Wed, 19 Sep 2007 15:16:41 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: rheap-managed bootmem allocator
References: <1190229304592-git-send-email-timur@freescale.com>
	<7307F27A-9C96-464A-9285-55DAB9A9A89D@kernel.crashing.org>
In-Reply-To: <7307F27A-9C96-464A-9285-55DAB9A9A89D@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> seems like we should have a way to set bootmem_size via board/platform 
> code and not require a cmdline arg.

I can add a Kconfig option for it, but since there is no Kconfig for the rheap 
itself, I didn't know where to put it.  Once Sylvain's patch is accepted, I 
can update this patch by adding this Kconfig option:

config PPC_RHEAP_BOOTMEM
	int "Default size (in KB) of the rheap bootmem allocator"
	default 0
	---help---
	  This is the default size (in KB) of the boot memory to allocate (via
	  alloc_bootmem).  This value can be  overridden on the kernel command
	  line using the "rhbootmem" option (e.g. "rhbootmem=2M")

One thing I don't like, however, is the name.  It doesn't really make sense to 
call it the "rheap bootmem allocator" because the fact that it uses an rheap 
is hidden from the callers of rheap_bootmem_alloc().

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
