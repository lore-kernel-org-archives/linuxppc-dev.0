Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 627031007E1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:47:13 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <83b483784a630638c8c7b5f0e05c2af2c58394ff.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:29:31 -0500
Subject: [PATCH 17/37]  powerpc cell: use smp_request_message_ipi
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a request to merge patchwork id 3780 with the same subject.
I believe it was marked "changes requested" because it depended on a
patch that had requested changes, but those were resolved and this
one got overlooked.  The next patch will remove smp_msg_recv.

thanks,
milton

Here is the original change log:

Subject: [PATCH 15/16]  powerpc cell: use smp_request_message_ipi

cell native has 4 interrupts for ipis, so use the new smp_request_message_ipi
to save pathlength and the data-dependent branch.

This has the side effects of enabling the debugger ipi for kdump and
setting IRQF_PERCPU for the ipi interrupts.  It doesn't undo the virq
mapping if it turns out the ipi is not used.
