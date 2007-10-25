Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 49AF3DDE1A
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 06:44:34 +1000 (EST)
Subject: Re: [RFC] [PATCH] PowerPC: Workaround for the 440EP(x)/GR(x)
	processors identical PVR issue.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Valentine Barshak <vbarshak@ru.mvista.com>
In-Reply-To: <20071025181640.GA18933@ru.mvista.com>
References: <20071025181640.GA18933@ru.mvista.com>
Content-Type: text/plain
Date: Fri, 26 Oct 2007 06:44:11 +1000
Message-Id: <1193345051.7018.15.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sr@denx.de
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-10-25 at 22:16 +0400, Valentine Barshak wrote:
> PowerPC 440EP(x) 440GR(x) processors have the same PVR values, since
> they have identical cores. However, FPU is not supported on GR(x) and
> enabling APU instruction broadcast in the CCR0 register (to enable FPU)
> may cause unpredictable results. There's no safe way to detect FPU
> support at runtime. This patch provides a workarund for the issue.
> We use a POWER6 "logical PVR approach". First, we identify all EP(x)
> and GR(x) processors as GR(x) ones (which is safe). Then we check 
> the device tree cpu path. If we have a EP(x) processor entry,
> we call identify_cpu again with PVR | 0x8. This bit is always 0
> in the real PVR. This way we enable FPU only for 440EP(x).
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

Why not just or-in the FPU feature bit ?

Ben.
