Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F3726DDF23
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 03:48:45 +1100 (EST)
Message-Id: <141BB874-FDA4-4107-BEF6-15B84023E44B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20081009003259.GA8373@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: fix fsl_upm nand driver modular build
Date: Mon, 13 Oct 2008 11:48:38 -0500
References: <20081008222815.GA20542@redhat.com>
	<20081008230219.GA8075@oksana.dev.rtsoft.ru>
	<20081008233306.GA31771@redhat.com>
	<20081009003259.GA8373@oksana.dev.rtsoft.ru>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 8, 2008, at 7:32 PM, Anton Vorontsov wrote:

> The fsl_upm nand driver fails to build because fsl_lbc_lock isn't
> exported, the lock is needed by the inlined fsl_upm_run_pattern()
> function:
>
> ERROR: "fsl_lbc_lock" [drivers/mtd/nand/fsl_upm.ko] undefined!
>
> Dave Jones purposed to export the lock, but it is better to just  
> uninline
> the fsl_upm_run_pattern().
>
> When uninlined we also no longer need the exported fsl_lbc_regs, and
> both fsl_lbc_lock and fsl_lbc_regs could be marked static.
>
> While at it, also add some missing includes that we should have  
> included
> explicitly.
>
> Reported-by: Dave Jones <davej@redhat.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---


applied.

- k
