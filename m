Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 01EB3DDE0F
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 18:10:50 +1100 (EST)
Subject: Re: [patch] powerpc: hash lock use lock bitops
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
In-Reply-To: <20071120062618.GB31514@wotan.suse.de>
References: <20071120050826.GA18332@wotan.suse.de>
	<20071120050950.GB18332@wotan.suse.de>
	<1195538904.6970.37.camel@pasglop>
	<20071120062618.GB31514@wotan.suse.de>
Content-Type: text/plain
Date: Tue, 20 Nov 2007 18:10:40 +1100
Message-Id: <1195542640.6970.39.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-11-20 at 07:26 +0100, Nick Piggin wrote:
> 
> BTW, here is another thing which you might want to think about. Again
> untested for temporary lack of hardware.
> 
> --
> 
> The radix-tree is now RCU safe, so powerpc can avoid the games it was playing
> in order to have a lockless readside. Saves an irq disable/enable, a couple of
> __get_cpu_var()s, a cacheline, and a memory barrier, in the fastpath. Should
> save a cycle or two...

Yup, I know. I need to work on that for -rt anyway due to other issues...

Thanks !

Ben.
