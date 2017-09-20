Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxqSS3KXvzDqR8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 16:23:36 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bhumika Goyal <bhumirks@gmail.com>, julia.lawall@lip6.fr,
 benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: Re: [PATCH] powerpc: make irq_chip const, __initdata and __initconst
In-Reply-To: <1505743967-19448-1-git-send-email-bhumirks@gmail.com>
References: <1505743967-19448-1-git-send-email-bhumirks@gmail.com>
Date: Wed, 20 Sep 2017 16:23:33 +1000
Message-ID: <87o9q5lwgq.fsf@concordia.ellerman.id.au>
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

Bhumika Goyal <bhumirks@gmail.com> writes:

> Make ehv_pic_irq_chip, mpic_ipi_chip and mpic_tm_chip const as they are
> used only as a copy operation. This usage is during init, so make them
> __initconst too.
> Make mpic_ipi_chip __initdata as it is only modified during the init
> phase and there is no reference of it anywhere after init.

The change log doesn't seem to match the code.

It's mpic_tm_chip which you marked __initdata, and that looks wrong, as
we keep a pointer to it here:

	mpic->hc_tm = mpic_tm_chip;

cheers
