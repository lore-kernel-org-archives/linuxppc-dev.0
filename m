Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5AF48B7C07
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 15:39:05 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A6639DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 15:39:04 +1000 (EST)
Message-Id: <28CAE6C1-8A32-4482-B606-6A22EE5BA5A9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090827173021.GD739@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 4/5] powerpc/85xx: Add suspend/resume support
Date: Fri, 28 Aug 2009 00:38:51 -0500
References: <20090827173021.GD739@oksana.dev.rtsoft.ru>
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


On Aug 27, 2009, at 12:30 PM, Anton Vorontsov wrote:

> This patch adds suspend/resume support for MPC8540-compatible and
> MPC8569 CPUs.
>
> MPC8540-compatible PMCs are trivial: we just write SLP bit into PM
> control and status register.
>
> MPC8569 is a bit trickier, QE turns off during suspend and so on
> resume we must reload QE microcode firmware and reset QE.
>
> So far we don't support Deep Sleep mode as found in newer MPC85xx
> CPUs (i.e. MPC8536). It can be relatively easy implemented though,
> and for it we reserve 'mem' suspend type.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/Kconfig                  |    2 +-
> arch/powerpc/platforms/85xx/Makefile  |    1 +
> arch/powerpc/platforms/85xx/suspend.c |  115 ++++++++++++++++++++++++ 
> +++++++++
> 3 files changed, 117 insertions(+), 1 deletions(-)
> create mode 100644 arch/powerpc/platforms/85xx/suspend.c

How did you test this?

I'd also like to get Scott's Ack on this and the device tree patches  
before accepting them.

- k
