Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y79X55MnPzDr6B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 22:29:09 +1100 (AEDT)
From: Michal Suchanek <msuchanek@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] bootwrapper: mspsc.c: fix pointer-to-int-cast warnings
Date: Thu,  5 Oct 2017 13:28:54 +0200
Message-Id: <20171005112854.28115-1-msuchanek@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I get these warnings:

../arch/powerpc/boot/mpsc.c: In function 'mpsc_get_virtreg_of_phandle':
../arch/powerpc/boot/mpsc.c:113:35: warning: cast from pointer to
integer of different size [-Wpointer-to-int-cast]

../arch/powerpc/boot/mpsc.c: In function 'mpsc_console_init':
../arch/powerpc/boot/mpsc.c:147:12: warning: cast from pointer to
integer of different size [-Wpointer-to-int-cast]

Presumably the patch below fixes these, and presumably the DT defines
that pointes and integers have the same size in the DT so this is fine
regardless of 32bit/64bit target. I have not found a DT definition for
PowerPC, howewer. So any bugs in the property sizing and resulting
failures to read the properties are left as before.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/boot/mpsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/mpsc.c b/arch/powerpc/boot/mpsc.c
index 425ad88cce8d..ea740493277a 100644
--- a/arch/powerpc/boot/mpsc.c
+++ b/arch/powerpc/boot/mpsc.c
@@ -110,7 +110,7 @@ static volatile char *mpsc_get_virtreg_of_phandle(void *devp, char *prop)
 	if (n != sizeof(v))
 		goto err_out;
 
-	devp = find_node_by_linuxphandle((u32)v);
+	devp = find_node_by_linuxphandle((intptr_t)v);
 	if (devp == NULL)
 		goto err_out;
 
@@ -144,7 +144,7 @@ int mpsc_console_init(void *devp, struct serial_console_data *scdp)
 	n = getprop(devp, "cell-index", &v, sizeof(v));
 	if (n != sizeof(v))
 		goto err_out;
-	reg_set = (int)v;
+	reg_set = (intptr_t)v;
 
 	mpscintr_base += (reg_set == 0) ? 0x4 : 0xc;
 
-- 
2.10.2
