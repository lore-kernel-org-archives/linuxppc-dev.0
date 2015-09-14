Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B5311A1760
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 12:55:39 +1000 (AEST)
In-Reply-To: <20150910043621.GA21735@iris.ozlabs.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: powerpc: MSI: Fix race condition in tearing down MSI interrupts
Message-Id: <20150914025539.7985D140549@ozlabs.org>
Date: Mon, 14 Sep 2015 12:55:39 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-10-09 at 04:36:21 UTC, Paul Mackerras wrote:
> This fixes a race which can result in the same virtual IRQ number
> being assigned to two different MSI interrupts.  The most visible
> consequence of that is usually a warning and stack trace from the
> sysfs code about an attempt to create a duplicate entry in sysfs.

<snip>

> The pattern of calling msi_bitmap_free_hwirqs() before
> irq_dispose_mapping() appears in 5 places under arch/powerpc, and
> appears to have originated in commit 05af7bd2d75e ("[POWERPC] MPIC
> U3/U4 MSI backend") from 2007.
> 
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/e297c939b745e420ef0b9dc9

cheers
