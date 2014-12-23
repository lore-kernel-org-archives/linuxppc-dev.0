Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E7DA71A0E47
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 20:56:12 +1100 (AEDT)
Message-ID: <1419328553.27103.66.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/smp: Fix Non-boot cpus cannot be bring up.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 23 Dec 2014 10:55:53 +0100
In-Reply-To: <1419296441.30550.3.camel@ellerman.id.au>
References: <1419230320-37558-1-git-send-email-dongsheng.wang@freescale.com>
 <1419296441.30550.3.camel@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Dongsheng Wang <dongsheng.wang@freescale.com>, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-12-23 at 12:00 +1100, Michael Ellerman wrote:
> On Mon, 2014-12-22 at 14:38 +0800, Dongsheng Wang wrote:
> > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> > 
> > Kernel cannot bring up Non-boot cpus always get "Processor xx is stuck".
> > this issue bring by http://patchwork.ozlabs.org/patch/418912/ (powerpc:
> > Secondary CPUs must set cpu_callin_map after setting active and online)
> > We need to take timebase after bootup cpu give the timebase firstly.
> > 
> > When start_secondary, non-boot cpus set cpu_callin_map for boot cpu
> > after that boot cpu will give the timebase for non-boot cpu. Otherwise
> > non-boot cpus will fall in dead loop to waiting bootup cpu to give
> > imebase.
> 
> Right.
> 
> However, doesn't this introduce the possibility that the secondary cpu is up
> and marked online but has an unsynchronised clock?

As long as it doesn't execute anything (and at that point it shouldn't
have interrupts enabled) it should be ok. The TB cannot be observed
outside of that CPU.

Cheers,
Ben.
