Return-Path: <olaf@ibook.aepfle.de>
Received: from natklopstock.rzone.de (natklopstock.rzone.de [81.169.145.174])
	by ozlabs.org (Postfix) with ESMTP id 5F4D667BF5
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 18:04:54 +1000 (EST)
Date: Wed, 18 Oct 2006 10:04:11 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Ingo Molnar <mingo@elte.hu>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: implicit declaration of function set_irq_chip_and_handler
Message-ID: <20061018080411.GA13340@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Current Linus tree has two new warnings

arch/powerpc/kernel/irq.c: In function irq_dispose_mapping:
arch/powerpc/kernel/irq.c:642: warning: implicit declaration of function set_irq_chip_and_handler
arch/powerpc/sysdev/mpic.c: In function mpic_host_map:
arch/powerpc/sysdev/mpic.c:770: warning: implicit declaration of function set_irq_chip_and_handler

It links anyway for some reason.
There is no prototype anymore, but still many users.

a460e745e8f9c75a0525ff94154a0629f9d3e05d is likely the culprit:
 [PATCH] genirq: clean up irq-flow-type naming
