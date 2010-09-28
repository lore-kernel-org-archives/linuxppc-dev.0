Return-Path: <yanok@emcraft.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 7C8A0B70E6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 22:25:29 +1000 (EST)
From: Ilya Yanok <yanok@emcraft.com>
To: linuxppc-dev@lists.ozlabs.org, wd@denx.de, dzu@denx.de, vlad@emcraft.com
Subject: [PATCH 1/3] mpc512x_dma: scatter/gather fix
Date: Tue, 28 Sep 2010 14:24:54 +0200
Message-Id: <1285676696-5358-2-git-send-email-yanok@emcraft.com>
In-Reply-To: <1285676696-5358-1-git-send-email-yanok@emcraft.com>
References: <1285676696-5358-1-git-send-email-yanok@emcraft.com>
Cc: Piotr Ziecik <kosmo@semihalf.com>, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While testing mpc512x-dma driver with dmatest module I've found that
I can hang the mpc512x-dma issueing request from multiple threads to
the single channel.
(insmod dmatest.ko max_channels=1 threads_per_chan=16)
After investingating this case I've managed to find that this happens
if and only if we have more than one quequed requests.
In this case the driver tries to make use of hardware scatter/gather
functionality. I've found two problems with scatter/gather:
 1. When TCD is copied form RAM to the TCD register space with memcpy_io()
e_sg bit eventually gets cleared. This results in only first TCD being
executed. I've added setting of e_sg bit excplicitly in the TCD registers.
BTW, what is the correct way to do this? (How can I use setbits with bitfield
structure?) After that hardware loads consecutive TCDs and we hit the
second issue.
 2. Existing code clears int_maj bit in the last TCD so we never get
an interrupt on transfefr completion.

With these fixes my tests with many threads of single channel succeed but
tests that use many channels simultaneously still don't work reliable.

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
Cc: Piotr Ziecik <kosmo@semihalf.com>
---
 drivers/dma/mpc512x_dma.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index 4e9cbf3..1bc04aa 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -252,11 +252,13 @@ static void mpc_dma_execute(struct mpc_dma_chan *mchan)
 		prev = mdesc;
 	}
 
-	prev->tcd->start = 0;
 	prev->tcd->int_maj = 1;
 
 	/* Send first descriptor in chain into hardware */
 	memcpy_toio(&mdma->tcd[cid], first->tcd, sizeof(struct mpc_dma_tcd));
+
+	if (first != prev)
+		mdma->tcd[cid].e_sg = 1;
 	out_8(&mdma->regs->dmassrt, cid);
 }
 
-- 
1.7.2.3
