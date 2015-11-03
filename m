Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 283F21A0250
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 21:39:54 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: mmarek@suse.com
Cc: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] scripts/tags.sh: Teach tags about more powerpc macros
Date: Tue,  3 Nov 2015 21:39:52 +1100
Message-Id: <1446547192-22777-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Teach tags.sh about the powerpc PCI macros, eg. readl/writel etc.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 scripts/tags.sh | 1 +
 1 file changed, 1 insertion(+)

Sorry to send another of these, I had a nagging feeling I'd missed some macros
when I sent the last one.

This applies on top of linux-next.

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 262889046703..f69fa0c87312 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -200,6 +200,7 @@ exuberant()
 	--regex-c++='/TASK_PFA_CLEAR\([^,]*,\s*([^)]*)\)/task_clear_\1/'\
 	--regex-c++='/DEF_MMIO_(IN|OUT)_(X|D)\(([^,]*),\s*[^)]*\)/\3/'	\
 	--regex-c++='/DEBUGGER_BOILERPLATE\(([^,]*)\)/\1/'		\
+	--regex-c++='/DEF_PCI_AC_(NO)?RET\(([^,]*),.*/\2/'		\
 	--regex-c='/PCI_OP_READ\((\w*).*[1-4]\)/pci_bus_read_config_\1/' \
 	--regex-c='/PCI_OP_WRITE\((\w*).*[1-4]\)/pci_bus_write_config_\1/' \
 	--regex-c='/DEFINE_(MUTEX|SEMAPHORE|SPINLOCK)\((\w*)/\2/v/'	\
-- 
2.5.0
