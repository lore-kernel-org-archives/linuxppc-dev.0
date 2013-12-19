Return-Path: <ilevex.linux@gmail.com>
Sender: Levente Kurusa <ilevex.linux@gmail.com>
From: Levente Kurusa <levex@linux.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/38] powerpc: cell: add missing put_device call
Date: Thu, 19 Dec 2013 16:03:14 +0100
Message-Id: <1387465429-3568-4-git-send-email-levex@linux.com>
In-Reply-To: <1387465429-3568-2-git-send-email-levex@linux.com>
References: <1387465429-3568-2-git-send-email-levex@linux.com>
Cc: cbe-oss-dev@lists.ozlabs.org, Levente Kurusa <levex@linux.com>,
 Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is required so that we give up the last reference to the device.

Signed-off-by: Levente Kurusa <levex@linux.com>
---
 arch/powerpc/platforms/cell/spu_base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
index f85db3a..f7fb0d9 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -597,6 +597,7 @@ static int spu_create_dev(struct spu *spu)
 	if (ret) {
 		printk(KERN_ERR "Can't register SPU %d with sysfs\n",
 				spu->number);
+		put_device(&spu->dev);
 		return ret;
 	}
 
-- 
1.8.3.1
