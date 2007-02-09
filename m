Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 29908DDE30
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 17:52:08 +1100 (EST)
Subject: Re: [PATCH] Celleb: improve htab lock
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
In-Reply-To: <200702090643.l196hHDv006227@toshiba.co.jp>
References: <200702090643.l196hHDv006227@toshiba.co.jp>
Content-Type: text/plain
Date: Fri, 09 Feb 2007 17:52:00 +1100
Message-Id: <1171003920.2620.427.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> We need to turn IRQs off when calling htab functions if and only
> if it is non-atomic, so the "pSeries with LPAR" htab function have
> no spin_lock or local_irq_save/restore. We think tweaking EE bit
> locally gives a way to decrease times to be IRQs off and on again
> (yes, it's smallthing to compare with calling HV),
> so we prefer current implementation.

Well, it might be indeed worth keeping it that way to avoid long
latencies with EE off with a big batch... I'll keep it that way for now,
though I suppose I should add some documentation on the expected caller
context in machdep.h next to the function pointers.

Ben.
