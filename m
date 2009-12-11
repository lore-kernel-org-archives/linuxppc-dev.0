Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 097AFB7BDE
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Dec 2009 12:57:30 +1100 (EST)
Subject: Re: [PATCH 1/3] powerpc/83xx/suspend: Clear deep_sleeping after
	devices resume
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091210180053.GA32482@oksana.dev.rtsoft.ru>
Date: Thu, 10 Dec 2009 19:56:59 -0600
Message-Id: <B72822DE-9F31-436E-9571-C82BDE4DFDCE@kernel.crashing.org>
References: <20091210175957.GA30682@oksana.dev.rtsoft.ru>
	<20091210180053.GA32482@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 10, 2009, at 12:00 PM, Anton Vorontsov wrote:

> Currently 83xx PMC driver clears deep_sleeping variable very early,
> before devices are resumed. This makes fsl_deep_sleep() unusable in
> drivers' resume() callback.
> 
> Sure, drivers can store fsl_deep_sleep() value on suspend and use
> the stored value on resume. But a better solution is to postpone
> clearing the deep_sleeping variable, i.e. move it into finish()
> callback.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Acked-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/platforms/83xx/suspend.c |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)

applied to next

- k
