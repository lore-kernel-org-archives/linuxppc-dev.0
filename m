Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCjSd1Kv6zDsy9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 19:40:49 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pseries: add definitions for new
 H_SIGNAL_SYS_RESET hcall
In-Reply-To: <20161108060806.16168-1-npiggin@gmail.com>
References: <20161108060806.16168-1-npiggin@gmail.com>
Date: Tue, 08 Nov 2016 19:40:47 +1100
Message-ID: <87shr2jre8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> This has not made its way to a PAPR release yet, but we have an hcall
> number assigned.
>
>   H_SIGNAL_SYS_RESET = 0x380
>
>   Syntax:
>   hcall(uint64 H_SIGNAL_SYS_RESET, /* generate a system reset NMI on   */
>                                    /* the threads indicated by target  */
>         int64 target); /* thread target selection */
>         /* -1 = target all online threads including the caller         */
>         /* -2 = target all online threads except for the caller        */
>         /* All other negative values: reserved                         */
>         /* Positive values: The thread to be targeted,                 */
>         /* obtained from the value of the "ibm,ppc-interrupt-server#s" */
>         /* property of the CPU in the OF device tree                   */
>
>   Semantics:
>   - If the NMI handlers are not registered, terminate the partition.

Are we sure about that part ie. "terminate the partition".

AFAIK we don't use the FWNMI handlers on KVM at all, so it's just wrong
there.

It also means we can't safely use this on PowerVM until we've registered
those handlers, which currently happens at setup_arch() time, which is
fairly late in boot.

cheers
