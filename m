Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVypL1sPXzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 08:33:30 +1000 (AEST)
Message-ID: <1466116390.24271.27.camel@kernel.crashing.org>
Subject: Re: unrecoverable exception on G5 with CONFIG_PPC_EARLY_DEBUG enabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Denis Kirjanov <kda@linux-powerpc.org>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 17 Jun 2016 08:33:10 +1000
In-Reply-To: <CAOJe8K2L8D1M_yZPmyiZ11JvJ+HAS0aFHOnsqaY=xLOnQTA3AA@mail.gmail.com>
References: <CAOJe8K1S9-AjJ106rQJMmTg_5238RzKgjFb9dyGuDY5ddydkgQ@mail.gmail.com>
 <1465216025.2658.7.camel@ellerman.id.au>
 <CAOJe8K1bBf-J6ZJq+VfVv+CVcwGyff32beGL4kXaZBr5ZL9hmw@mail.gmail.com>
 <1466078830.19127.0.camel@ellerman.id.au>
 <CAOJe8K2L8D1M_yZPmyiZ11JvJ+HAS0aFHOnsqaY=xLOnQTA3AA@mail.gmail.com>
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

On Thu, 2016-06-16 at 22:49 +0300, Denis Kirjanov wrote:
> -
> +BEGIN_MMU_FTR_SECTION
> +       b       2f
> +END_MMU_FTR_SECTION_IFSET(MMU_FTR_RADIX)
>         andi.   r10,r12,MSR_RI  /* check for unrecoverable exception
> */
>         beq-    2f

Are we taking an SLB miss before we do the fixup maybe ?

Cheers,
Ben.
