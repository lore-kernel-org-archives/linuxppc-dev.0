Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0A3AF67B81
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Jul 2006 00:16:03 +1000 (EST)
Date: Fri, 21 Jul 2006 18:16:21 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "Claus Gindhart" <claus.gindhart@kontron.com>
Subject: Re: Boot strategies and Boot Image formats in arch/powerpc
Message-ID: <20060721181621.29da4ffd@vitb.ru.mvista.com>
In-Reply-To: <DADA32856852FC458E0F96B664A6F55E011E239F@kom-mailsrv1.kontron-modular.com>
References: <DADA32856852FC458E0F96B664A6F55E011E239F@kom-mailsrv1.kontron-modular.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Olaf Wepner <olaf.wepner@kontron.com>,
	Sabine Bielski <sabine.bielski@kontron.com>,
	Stefan Nickl <stefan.nickl@kontron.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 21 Jul 2006 11:35:25 +0200
"Claus Gindhart" <claus.gindhart@kontron.com> wrote:

> Hi all,
> 
> currently i am trying to migrate our existing PowerPC board supports from the arch/ppc - directory into the new arch/powerpc. I am directly working within a cloned paulus_powerpc git repository on the most recent status.
> 
> We (Kontron) want to bring our kernel sources into the appropriate for an open source submission. We are modifying both our proprietary Bootloader, and the Linux Kernel, to make them fit to the new conventions, e.g. the flattened device tree.
> 
> However, i dont understand the following:
> 
> In the old structure, the kernel provided a bunch of sub directories (simple,openfirmware,...) to create a wrapper around the Linux kernel for brining it into the format, which is appropriate for the boot loader used.
> This structure was easily adaptable for custom image formats.
> 
> Now, these dirs dont exist any more.
Well, in arch/powerpc those stuff had no sense so far.. But it may change - see below.
> 
> What is the strategy here (i could assume one the 3 variants below ?
> 
> a) Is it now in the responsibility of the bootloader, to support one of the image formats, 
>     which can be generated here currently ?
> 
This way we have started with powerpc merge and it still could be used. there are plenty of such stuff in the list archives, being discussed, and even followed up with patches.

But that imply u-boot firmware so not interesting for you I assume.

> b) Will these subdirs (e.g. "simple") come here, but just where not ported yet ?
> 
Currently, Mark is working on a thing similar to this case. the kernel building zImage has to compile devicetree to binary dtb and line stuff up so that booting, the shim has started the kernel and have devicetree passed to it. 

> c) Or, shall such wrapper around the kernel, and/or bringing the kernel into a particular file format
>     be performed outside the kernel source, by proprietary tools
>     (e.g. like U-boot does it with the mkimage tool) ?
> 
This was yet another way pondered, but I guess b) looked better.

> -- 
> Mit freundlichen Gruessen / Best regards
> 
> Claus Gindhart
> SW R&D
> Kontron Modular Computers
> phone :++49 (0)8341-803-374
> mailto:claus.gindhart@kontron-modular.com
> http://www.kontron.com
> 
> -----BEGIN GEEK CODE BLOCK-----
>   Version: 3.1
>   GU d- s++:>++:+ a+ C++$ !U !P L++>$ E-- W+(-) N- o?
>   K? w !O !M V !PS PE- Y+ PGP+ t 5? X R* tv- b+ DI+++
>   D-- G e++> h--- !r x+++
> ------END GEEK CODE BLOCK------
> 
> 
> 
> 
> 
> 


-- 
Sincerely, 
Vitaly
