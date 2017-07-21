Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDKyJ2GMNzDqsd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 16:06:00 +1000 (AEST)
Message-ID: <1500617137.10674.20.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/vdso64: Add support for
 CLOCK_{REALTIME/MONOTONIC}_COARSE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Santosh Sivaraj <santosh@fossix.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Srikar Dronamraju
 <srikar@linux.vnet.ibm.com>
Date: Fri, 21 Jul 2017 16:05:37 +1000
In-Reply-To: <20170721044048.3dbqldqh6m7wj5kc@santosiv.in.ibm.com>
References: <20170720095834.15153-1-santosh@fossix.org>
 <87bmofgsbh.fsf@concordia.ellerman.id.au>
 <20170721044048.3dbqldqh6m7wj5kc@santosiv.in.ibm.com>
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

On Fri, 2017-07-21 at 10:10 +0530, Santosh Sivaraj wrote:
> In case of a bogus clock id, the default case sets 'ret' to -1, which forces it
> to fallback to the syscall.
> > I think the solution is probably to do the syscall fallback in asm, and
> > everything else in C.
> 
> Ok. That's what Sergey also sugested. I will send a v2.

Beware that the vDSO has no TOC. You need to be extremely careful that
the generated code by the compiler doesn't try to access/use a TOC.

I would rather continue doing things in asm at this stage.

Ben.
