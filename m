Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9822CDE0C9
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 08:19:50 +1000 (EST)
Subject: Re: [PATCH 02/12] fs_enet: Add MPC5121 FEC support.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40905140700k3ca28ac0m74c9c161ad538abc@mail.gmail.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<20090506220954.5D3AF83420E8@gemini.denx.de>
	<fa686aa40905061539t4fa463aehe56fdb64d053135d@mail.gmail.com>
	<200905141438.23348.kosmo@semihalf.com>
	<fa686aa40905140700k3ca28ac0m74c9c161ad538abc@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 19 May 2009 08:17:31 +1000
Message-Id: <1242685051.16901.6.camel@pasglop>
Mime-Version: 1.0
Cc: Becky Bruce <Becky.Bruce@freescale.com>,
	Piotr =?UTF-8?Q?Zi=C4=99cik?= <kosmo@semihalf.com>,
	Detlev Zundel <dzu@denx.de>, John Rigby <jrigby@gmail.com>,
	netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Scott Wood <scottwood@freescale.com>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-05-14 at 08:00 -0600, Grant Likely wrote:
> 
> All of this doesn't actually affect the driver code at all.  It's all
> handled by the kernel and the DMA apis.  What it does affect is
> multiplatform kernels.  The DMA behaviour is set at compile time, not
> run time, depending on the setting of CONFIG_NON_COHERENT_CACHE (see
> arch/powerpc/platforms/Kconfig.cputype).  A kernel which has it on
> won't run properly on a platform which has it off, and visa-versa.

We are close to the point where we can make this a runtime option
though, by just having a different set of dma_ops hooked in.

Cheers,
Ben.
