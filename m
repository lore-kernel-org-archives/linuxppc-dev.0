Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4F877B7D5B
	for <linuxppc-dev@ozlabs.org>; Tue, 25 May 2010 05:02:15 +1000 (EST)
Subject: Re: [PATCH 1/3] powerpc/head fsl: fix the case where we are not in
	the first page
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1270412343-19334-2-git-send-email-sebastian@breakpoint.cc>
Date: Mon, 24 May 2010 14:01:39 -0500
Message-Id: <1B420EEE-E06B-4AA2-977E-D3B1B0166679@kernel.crashing.org>
References: <1270412343-19334-1-git-send-email-sebastian@breakpoint.cc>
	<1270412343-19334-2-git-send-email-sebastian@breakpoint.cc>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: linuxppc-dev@ozlabs.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 4, 2010, at 3:19 PM, Sebastian Andrzej Siewior wrote:

> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> During boot we change the mapping a few times until we have a "defined"
> mapping. During this procedure a small 4KiB mapping is created and after
> that one a 64MiB. Currently the offset of the 4KiB page in that we run
> is zero because the complete startup up code is in first page which
> starts at RPN zero.
> If the code is recycled and moved to another location then its execution
> will fail because the start address in 64 MiB mapping is computed
> wrongly. It does not consider the offset to the page from the begin of
> the memory.
> This patch fixes this. Usually (system boot) r25 is zero so this does
> not change anything unless the code is recycled.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> arch/powerpc/kernel/head_fsl_booke.S |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

applied to next

- k
