Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B3AE67BAC
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 13:12:57 +1000 (EST)
Subject: Re: [PATCH] IPIC: Don't call set_irq_handler with desc->lock held.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20061023163522.GA15901@ld0162-tx32.am.freescale.net>
References: <20061023163522.GA15901@ld0162-tx32.am.freescale.net>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 13:12:49 +1000
Message-Id: <1161659570.10524.531.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> This patch gets things working in the spinlock-debugging-enabled case,
> but I'm curious as to where the handler setting is ideally supposed to be
> done.  I don't see any documentation on set_irq_type() that clarifies
> what the semantics are supposed to be.

It's unclear... the common code calls it, I think, when request_irq() is
passed explicit type. When changing the type, some PICs need to change
the handler, some don't. It looks that none of the PICs I've dealt with
have this problem though...

Ben.
