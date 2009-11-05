Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EC576B7E8E
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 00:15:48 +1100 (EST)
Subject: Re: [PATCH 1/7] powerpc/qe: Make qe_reset() code path safe for
	repeated invocation
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20090915214352.GA24821@oksana.dev.rtsoft.ru>
Date: Thu, 5 Nov 2009 07:15:42 -0600
Message-Id: <236D3307-03C3-453A-B308-DC7D2D3300B9@kernel.crashing.org>
References: <20090915214321.GA19377@oksana.dev.rtsoft.ru>
	<20090915214352.GA24821@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 15, 2009, at 4:43 PM, Anton Vorontsov wrote:

> For MPC8569 CPUs we'll need to reset QE after each suspend, so make
> qe_reset() code path suitable for repeated invocation, that is:
>
> - Don't initialize rheap structures if already initialized;
> - Don't allocate muram for SDMA if already allocated, just  
> reinitialize
>  registers with previously allocated muram offset;
> - Remove __init attributes from qe_reset() and cpm_muram_init();
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/include/asm/qe.h    |    2 +-
> arch/powerpc/sysdev/cpm_common.c |    5 ++++-
> arch/powerpc/sysdev/qe_lib/qe.c  |   12 +++++++-----
> 3 files changed, 12 insertions(+), 7 deletions(-)

applied to next.

- k
