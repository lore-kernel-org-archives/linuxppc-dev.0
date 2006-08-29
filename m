Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9C02367B58
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 06:28:37 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7TKSWOb004003
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 16:28:32 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7TKSWqc269522
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 16:28:32 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7TKSW3P001989
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 16:28:32 -0400
Date: Tue, 29 Aug 2006 15:28:31 -0500
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: undefined reference to pci_io_base
Message-ID: <20060829202831.GB27372@austin.ibm.com>
References: <44F47ABE.7080602@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44F47ABE.7080602@am.sony.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 29, 2006 at 10:34:54AM -0700, Geoff Levand wrote:
> I'm trying to understand the intended design of the inb()
> and outb() macros in asm-powerpc/io.h. They are causing
> me some grief when I set CONFIG_PCI=n:
> 
>   drivers/built-in.o: undefined reference to `pci_io_base'
> 
> This is coming from drivers/char/mem.c, which is always
> built in, and is referencing pci_io_base through inb()
> and outb().
> 
> Anyway, it seems asm-powerpc/io.h has two sets of io macros,
> one set for iSeries, and one generic set for everything else.
> The problem arises because the generic macros just use the eeh
> macros in eeh.h, which in turn, directly use pci_io_base. 
> 
> I can think of three solutions to this that work for me, but
> I'm not sure which, if any, would be the most proper.  One
> would be to just have this in io.h:
> 
>   #if defined(CONFI_PCI)
>   extern unsigned long pci_io_base;
>   #else
>   #define pci_io_base 0
>   #endif

This makes the most sense to me; it compiles to something nice.

> Another would be to have this in some file that is always built
> in, like setup-common.c:
> 
>   #if !defined(CONFI_PCI)
>   unsigned long pci_io_base;
>   EXPORT_SYMBOL(pci_io_base);
>   #endif

This compiles to something ugly and pointless ... 

> A third would be to have another set of io macros in io.h that
> are used when CONFIG_PCI=n.

I'm not sure that yet-another set of macros improves readabily.
Those macros are already fairly byzantine in thier inter-connections.

--linas
