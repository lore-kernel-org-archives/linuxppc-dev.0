Return-Path: <BATV+d8c56d9a67374e13c9b4+5014+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRwgp4pYbzDqZJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 21:48:22 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Gross <mark.gross@intel.com>, Tejun Heo <tj@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: RFC: better timer interface
Date: Tue, 16 May 2017 13:48:03 +0200
Message-Id: <20170516114812.10660-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

this series attempts to provide a "modern" timer interface where the
callback gets the timer_list structure as an argument so that it
can use container_of instead of having to cast to/from unsigned long
all the time (or even worse use function pointer casts, we have quite
a few of those as well).

For that it steals another bit from the cpu mask to add a modern flag,
and if that flag is set the different new function prototype is used.
Last but least new helpers to initialize these modern timers are added.
Instead of having a larger number of initialization macros we simply
pass the timer flags to them.
