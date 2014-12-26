Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri6.pp.htv.fi (filtteri6.pp.htv.fi [213.243.153.189])
 by lists.ozlabs.org (Postfix) with ESMTP id 873851A0C44
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Dec 2014 23:09:53 +1100 (AEDT)
Date: Fri, 26 Dec 2014 14:09:43 +0200
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Subject: Re: [PATCH] powerpc/smp: Fix Non-boot cpus cannot be bring up.
Message-ID: <20141226120943.GC582@fuloong-minipc.musicnaut.iki.fi>
References: <1419230320-37558-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419230320-37558-1-git-send-email-dongsheng.wang@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Mon, Dec 22, 2014 at 02:38:40PM +0800, Dongsheng Wang wrote:
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
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

This fixes v3.19-rc1 boot on G5 Xserve.

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
