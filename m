Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 506861A05E1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 12:00:42 +1100 (AEDT)
Message-ID: <1419296441.30550.3.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/smp: Fix Non-boot cpus cannot be bring up.
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Date: Tue, 23 Dec 2014 12:00:41 +1100
In-Reply-To: <1419230320-37558-1-git-send-email-dongsheng.wang@freescale.com>
References: <1419230320-37558-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-12-22 at 14:38 +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> Kernel cannot bring up Non-boot cpus always get "Processor xx is stuck".
> this issue bring by http://patchwork.ozlabs.org/patch/418912/ (powerpc:
> Secondary CPUs must set cpu_callin_map after setting active and online)
> We need to take timebase after bootup cpu give the timebase firstly.
> 
> When start_secondary, non-boot cpus set cpu_callin_map for boot cpu
> after that boot cpu will give the timebase for non-boot cpu. Otherwise
> non-boot cpus will fall in dead loop to waiting bootup cpu to give
> imebase.

Right.

However, doesn't this introduce the possibility that the secondary cpu is up
and marked online but has an unsynchronised clock?

cheers
