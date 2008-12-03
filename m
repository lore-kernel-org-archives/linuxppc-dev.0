Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id B2840DDDDF
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Dec 2008 12:51:04 +1100 (EST)
Message-ID: <4935E65B.30305@windriver.com>
Date: Wed, 03 Dec 2008 09:52:27 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Stephen Horton <SHorton@kodiaknetworks.com>
Subject: Re: Marvell mv64462 + mpc744x PCI Interrupt Cause Error Handling
References: <295C5089A56CE143B316E5F67CA99CB001F4389F@cowboy.inovate.inovate.com>
In-Reply-To: <295C5089A56CE143B316E5F67CA99CB001F4389F@cowboy.inovate.inovate.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Stephen Horton wrote:
> Hi folks,
> 
>  
> 
> I'm really hoping Mark Greer or Dale Farnsworth sees this email. In my
> current project, we are in the process of updating a board that has a
> Marvell mv64462 system controller and a Freescale mpc7447A processor on
> it. The board was originally developed with Gentoo Linux 2.6.9, but we
> have ported Linux 2.6.24 kernel onto it. The new kernel is working well
> thanks to help from people on this list. However, in examining the
> differences between the 2 kernels, I can see that the 2.6.24 kernel
> registers no interrupt error handling routines (see PCI Error Report
> Register Map in the Marvell documentation). The error handlers for cpu,
> sram, and specifically for the PCI bus that were previously in:
> 
>             /arch/ppc/syslib/mv64460_pic.c
> 
> are absent from:
> 
>             /arch/powerpc/sysdev/mv64x60_pic.c
> 
>  
> 
> Can someone who is familiar with the history of the ppc->powerpc
> migration for this architecture help me figure out why the error
> handling wasn't ported over? Is there some reason for this, such as it
> didn't work properly or had some disadvantages? Is this error handling
> done in 2.6.24 in some more generic manner that I have not yet found? Is
> this an exercise left for me to implement?
> 
>  

Untill v2.6.27 you can find corresponding dts content such as cpu-error,
sram-ctrl, pci-error and mem-ctrl, in file, prpmc2800.dts. All events are
handled on EDAC, error detection and reporting, as an unified mode. So you can
track the directory drivers/edac/ for more information. I think these are not
upgraded completely for v2.6.24.

Best Regards
Tiejun

> 
> Thanks,
> 
> Stephen
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
