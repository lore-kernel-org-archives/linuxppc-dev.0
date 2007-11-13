Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3172CDDEE6
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 07:17:57 +1100 (EST)
Date: Tue, 13 Nov 2007 23:15:59 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/2] PowerPC: 4xx uic updates
Message-ID: <20071113201559.GA26172@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These patches update 4xx uic code. The first one
fixes a minor issue with edge-triggered interrupts,
while the second one makes it use generic level and edge irq
handlers. I've added irq ack'ing to the unmask callback for
level-triggered interrupts, because to de-assert them we have
to do 2 things is the exact order as below:
1. de-assert the external source in the ISR.
2. ack the IRQ on the UIC.
So, ack'ing level interrupts before unmasking them makes possible
to use generic level irq handler and it doesn't hurt, cause
we can never miss a level-triggered interrupt. It always stays
asserted untill the external source is removed and ack'ed on UIC.

These have been tested on Sequoia PowerPC 440EPx board.
Thanks,
Valentine.
