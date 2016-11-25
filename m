Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPxBc4hvpzDvsB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 11:04:08 +1100 (AEDT)
In-Reply-To: <20161116030215.6886-1-ruscur@russell.cc>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/pci: Always print PHB and PE numbers as hexadecimal
Message-Id: <3tPxBc1Rp2z9t0Z@ozlabs.org>
Date: Fri, 25 Nov 2016 11:04:07 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-11-16 at 03:02:15 UTC, Russell Currey wrote:
> PHB, PE (and by association MVE) numbers are printed as a mix of decimal
> and hexadecimal throughout the kernel.  This can be misleading, so make
> them all hexadecimal.
> 
> Standardising on hex instead of dec because:
> 
>  - PHB numbers are presented in hex in sysfs/debugfs (and lspci, etc)
>  - PE numbers are presented as hex in sysfs and parsed in hex in debugfs
> 
> The only place I think this could cause confusing are the messages during
> boot, i.e.
> 
> 	pci 000a:01     : [PE# 000] Secondary bus 1 associated with PE#0
> 
> which can be a quick way to check PE numbers.  pe_level_printk() will
> only print two characters instead of three, so the above would be
> 
> 	pci 000a:01     : [PE# 00] Secondary bus 1 associated with PE#0
> 
> which gives a hint it's in hex.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1f52f1761456c919814c995710153a

cheers
