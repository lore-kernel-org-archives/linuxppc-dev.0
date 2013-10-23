Return-Path: <joe@perches.com>
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] cell: Remove OOM message after input_allocate_device
Date: Wed, 23 Oct 2013 12:14:48 -0700
Message-Id: <d4dc0be1a19693fca1d8d6bbd3a7ee75163cc269.1382555436.git.joe@perches.com>
In-Reply-To: <cover.1382555436.git.joe@perches.com>
References: <cover.1382555436.git.joe@perches.com>
Cc: cbe-oss-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Emitting an OOM message isn't necessary after input_allocate_device
as there's a generic OOM and a dump_stack already done.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/powerpc/platforms/cell/cbe_powerbutton.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/cbe_powerbutton.c b/arch/powerpc/platforms/cell/cbe_powerbutton.c
index 2bb8031..8804dbd 100644
--- a/arch/powerpc/platforms/cell/cbe_powerbutton.c
+++ b/arch/powerpc/platforms/cell/cbe_powerbutton.c
@@ -58,7 +58,6 @@ static int __init cbe_powerbutton_init(void)
 	dev = input_allocate_device();
 	if (!dev) {
 		ret = -ENOMEM;
-		printk(KERN_ERR "%s: Not enough memory.\n", __func__);
 		goto out;
 	}
 
-- 
1.8.1.2.459.gbcd45b4.dirty
