Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 14 Jan 2009 17:11:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [PATCH 12/13] powerpc/ps3: printing fixups for l64 to ll64
	conversion: drivers/scsi
Message-Id: <20090114171144.ec449da3.sfr@canb.auug.org.au>
In-Reply-To: <20090114165450.ebbc11a7.sfr@canb.auug.org.au>
References: <20090114165450.ebbc11a7.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	ppc-dev <linuxppc-dev@ozlabs.org>, cbe-oss-dev@ozlabs.org,
	linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/scsi/ps3rom.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

James, if it is OK with you, this could go in via the PowerPC tree.

diff --git a/drivers/scsi/ps3rom.c b/drivers/scsi/ps3rom.c
index ce48e2d..ca0dd33 100644
--- a/drivers/scsi/ps3rom.c
+++ b/drivers/scsi/ps3rom.c
@@ -290,11 +290,11 @@ static irqreturn_t ps3rom_interrupt(int irq, void *data)
 
 	if (tag != dev->tag)
 		dev_err(&dev->sbd.core,
-			"%s:%u: tag mismatch, got %lx, expected %lx\n",
+			"%s:%u: tag mismatch, got %llx, expected %llx\n",
 			__func__, __LINE__, tag, dev->tag);
 
 	if (res) {
-		dev_err(&dev->sbd.core, "%s:%u: res=%d status=0x%lx\n",
+		dev_err(&dev->sbd.core, "%s:%u: res=%d status=0x%llx\n",
 			__func__, __LINE__, res, status);
 		return IRQ_HANDLED;
 	}
@@ -364,7 +364,7 @@ static int __devinit ps3rom_probe(struct ps3_system_bus_device *_dev)
 
 	if (dev->blk_size != CD_FRAMESIZE) {
 		dev_err(&dev->sbd.core,
-			"%s:%u: cannot handle block size %lu\n", __func__,
+			"%s:%u: cannot handle block size %llu\n", __func__,
 			__LINE__, dev->blk_size);
 		return -EINVAL;
 	}
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
