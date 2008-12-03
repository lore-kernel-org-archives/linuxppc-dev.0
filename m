Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id BF00BDDD01
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 16:31:25 +1100 (EST)
Date: Tue, 2 Dec 2008 23:31:18 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Remove modpost warning with start_secondary
Message-ID: <20081203053118.GH6829@localdomain>
References: <1228278723-1153-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1228278723-1153-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> WARNING: vmlinux.o(.text+0x2aa): Section mismatch in reference from the variable __secondary_start to the function .devinit.text:start_secondary()
> The function __secondary_start() references
> the function __devinit start_secondary().
> 
> start_secondary gets called by __secondary_start which is in asm code so its
> not marked as __devinit.  Its easier to just remove the __devinit from
> start_secondary than try and deal with __secondary_start.

Which just gets another mismatch warning here:

WARNING: arch/powerpc/kernel/built-in.o(.text+0x23cc4): Section mismatch in reference from the function .start_secondary() to the function .devinit.text:.smp_store_cpu_info()
The function .start_secondary() references
the function __devinit .smp_store_cpu_info().
This is often because .start_secondary lacks a __devinit 
annotation or the annotation of .smp_store_cpu_info is wrong.

Isn't there a better way to address this?  It doesn't seem right to
increase the kernel's memory usage to get rid of a modpost warning.
