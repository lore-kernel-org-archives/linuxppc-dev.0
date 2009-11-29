Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1C37BB7B66
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 Nov 2009 10:18:22 +1100 (EST)
Subject: Re: [RFC PATCH v2 08/11] powerpc: gamecube/wii: early debugging
	using usbgecko
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <1259441037-15725-9-git-send-email-albert_herranz@yahoo.es>
References: <1259441037-15725-1-git-send-email-albert_herranz@yahoo.es>
	<1259441037-15725-9-git-send-email-albert_herranz@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 30 Nov 2009 10:18:15 +1100
Message-ID: <1259536695.2076.40.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-11-28 at 21:43 +0100, Albert Herranz wrote:
> +        * Prepare again the same BAT for MMU_init.
> +        * This allows udbg I/O to continue working after the MMU is
> +        * turned on for real.
> +        *
> +        * We are assuming here that exi_io_base is identity mapped.
> +        */
> +       addr = ((unsigned long)exi_io_base) & 0xffff0000;
> +       setbat(1, addr, addr, 128*1024, PAGE_KERNEL_NCG); 

How do you prevent that from overlapping otherwise valid kernel
mappings ?

You need to allocate the virtual space. For a debug thing like that, you
could use the fixmap. In fact, I think we should create a fixmap entry
or two always available for use by early debug.

Cheers,
Ben.
