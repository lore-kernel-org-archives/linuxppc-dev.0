Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rs5YJ5PHnzDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jul 2016 20:40:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 02/14] powerpc/irq: Add support for HV virtualization
 interrupts
In-Reply-To: <1467959838-6900-2-git-send-email-benh@kernel.crashing.org>
References: <1467959838-6900-1-git-send-email-benh@kernel.crashing.org>
 <1467959838-6900-2-git-send-email-benh@kernel.crashing.org>
Date: Sat, 16 Jul 2016 20:40:01 +1000
Message-ID: <87ziphamta.fsf@@concordia.ellerman.id.au>
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> This will be delivering external interrupts from the XIVE to the
> Hypervisor. We treat it as a normal external interrupt for the
> lazy irq disable code (so it will be replayed as a 0x500) and
> route it to do_IRQ.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/include/asm/exception-64s.h |  2 ++
>  arch/powerpc/include/asm/reg.h           |  1 +
>  arch/powerpc/kernel/cpu_setup_power.S    |  2 ++
>  arch/powerpc/kernel/exceptions-64s.S     | 19 +++++++++++++++++++
>  4 files changed, 24 insertions(+)

This is breaking allmodconfig with:

arch/powerpc/kernel/exceptions-64s.S:778: Error: attempt to move .org backwards
arch/powerpc/kernel/exceptions-64s.S:779: Error: attempt to move .org backwards
arch/powerpc/kernel/exceptions-64s.S:803: Error: attempt to move .org backwards
arch/powerpc/kernel/exceptions-64s.S:804: Error: attempt to move .org backwards
arch/powerpc/kernel/exceptions-64s.S:823: Error: attempt to move .org backwards
arch/powerpc/kernel/exceptions-64s.S:833: Error: attempt to move .org backwards

http://kisskb.ozlabs.ibm.com/kisskb/buildresult/12746513/

cheers
