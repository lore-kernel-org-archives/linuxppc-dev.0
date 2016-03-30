Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZlVL1SnmzDq6X
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 22:17:30 +1100 (AEDT)
Message-ID: <1459336643.23987.6.camel@ellerman.id.au>
Subject: Re: [v2] ppc64/book3s: fix branching to out of line handlers in
 relocation kernel
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, Michael Neuling
 <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>
Date: Wed, 30 Mar 2016 22:17:23 +1100
In-Reply-To: <56FB83C1.7070306@linux.vnet.ibm.com>
References: <3qZT2T1R7fz9sDC@ozlabs.org>
 <56FB7CB8.1010801@linux.vnet.ibm.com> <56FB83C1.7070306@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-03-30 at 13:14 +0530, Hari Bathini wrote:
> 
> Alternatively, how about moving the OOLs handlers that can't be branched with
> LOAD_HANDLER under __end_interrupts. This way we won't be copying more than a
> few absolutely needed handlers.
> 
> STD_RELON_EXCEPTION_HV_OOL(0xe40, emulation_assist)
> .
> .
> STD_RELON_EXCEPTION_HV_OOL(0xf80, hv_facility_unavailable)
> 
> 
> We can leave __end_handlers marker to indicate code that should be part 
> of the first 64K of kernel image.

That might work. But I suspect you will run into issues with ".org backwards",
ie. running out of space in head_64.S

But try it and let me know if it works.

I think we also need to write a script or little C program which looks at the
vmlinux and checks that nothing below __end_whatever does a direct branch. So
that we don't break it again in future.

cheers
