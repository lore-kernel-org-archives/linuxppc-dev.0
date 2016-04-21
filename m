Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrKbl085MzDqdZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 23:39:15 +1000 (AEST)
In-Reply-To: <20160329183333.15267.29181.stgit@hbathini.in.ibm.com>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [v2] ppc64/book3s: fix branching to out of line handlers in
 relocation kernel
Message-Id: <3qrKbk27dcz9t5n@ozlabs.org>
Date: Thu, 21 Apr 2016 23:39:13 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-29-03 at 18:34:37 UTC, Hari Bathini wrote:
> Some of the interrupt vectors on 64-bit POWER server processors  are
> only 32 bytes long (8 instructions), which is not enough for the full
> first-level interrupt handler. For these we need to branch to an out-
> of-line (OOL) handler. But when we are running a relocatable kernel,
> interrupt vectors till __end_interrupts marker are copied down to real
> address 0x100. So, branching to labels (read OOL handlers) outside this
> section should be handled differently (see LOAD_HANDLER()), considering
> relocatable kernel, which would need atleast 4 instructions.
...
> 
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Applied to powerpc next with some modifications as discussed, thanks.

https://git.kernel.org/powerpc/c/8ed8ab40047a570fdd8043a40c

cheers
