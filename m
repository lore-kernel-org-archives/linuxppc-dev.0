Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 697D767BB3
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Nov 2006 07:00:27 +1100 (EST)
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <200611192243.34850.sshtylyov@ru.mvista.com>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 07:00:37 +1100
Message-Id: <1163966437.5826.99.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, linux-kernel@vger.kernel.org,
	dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-11-19 at 22:43 +0300, Sergei Shtylyov wrote:
> As fasteoi type chips never had to define their ack() method before the
> recent Ingo's change to handle_fasteoi_irq(), any attempt to execute handler
> in thread resulted in the kernel crash. So, define their ack() methods to be
> the same as their eoi() ones...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> Since there was no feedback on three solutions I suggested, I'm going the way
> of least resistance and making the fasteoi type chips behave the way that
> handle_fasteoi_irq() is expecting from them...

Wait wait wait .... Can somebody (Ingo ?) explain me why the fasteoi
handler is being changed and what is the rationale for adding an ack
that was not necessary before ?

Cheers,
Ben.
