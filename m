Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <d44faed85b5e101743bcb1a5e8a0df8487830654.1263366655.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/1] powerpc/iseries: Initialise on-stack completion
Date: Wed, 13 Jan 2010 18:10:56 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

get_viotape_info() declares a vio_waitevent on the stack, which
contains a completion, but never initialises the completion.

I have no idea how this ever worked, and on recent kernels it causes
an oops in handle_tape_event() when we access the non-initialised
completion.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/iseries/vio.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/vio.c b/arch/powerpc/platforms/iseries/vio.c
index 657b72f..2aa8b56 100644
--- a/arch/powerpc/platforms/iseries/vio.c
+++ b/arch/powerpc/platforms/iseries/vio.c
@@ -474,6 +474,8 @@ static void __init get_viotape_info(struct device_node *vio_root)
 	struct vio_waitevent we;
 	int ret;
 
+	init_completion(&we.com);
+
 	ret = viopath_open(viopath_hostLp, viomajorsubtype_tape, 2);
 	if (ret) {
 		printk(KERN_WARNING "get_viotape_info: "
-- 
1.6.3.3
