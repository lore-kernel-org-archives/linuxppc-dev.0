Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E3A24DDD0D
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 21:25:34 +1000 (EST)
Subject: Re: [RFC] [PATCH] PowerPC: Workaround for the
	440EP(x)/GR(x)	processors identical PVR issue.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Valentine Barshak <vbarshak@ru.mvista.com>
In-Reply-To: <4721C9E9.10208@ru.mvista.com>
References: <20071025181640.GA18933@ru.mvista.com>
	<1193345051.7018.15.camel@pasglop>  <4721C9E9.10208@ru.mvista.com>
Content-Type: text/plain
Date: Fri, 26 Oct 2007 21:25:23 +1000
Message-Id: <1193397923.13638.5.camel@pasglop>
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


On Fri, 2007-10-26 at 15:05 +0400, Valentine Barshak wrote:
> 
> It's not enough. We need to enable APU instruction broadcast for
> EP(x) 
> (call __init_fpu_44x in arch/powerpc/kernel/cpu_setup_44x.S).
> Or do you suggest to or-in FPU feature bit and enable APUIB later,
> not 
> in the cpu_setup callback?

It can be done at any time before the feature fixup. However, on 32
bits, iirc, the fixup happens very early so it might not be that easy...
just asking :-) Your patch is allright, we can always find a better way
to do it later on.

Ben.
