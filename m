Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2A3D7DDE49
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Nov 2007 13:28:37 +1100 (EST)
Date: Sun, 4 Nov 2007 13:28:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Fix link errors for allyesconfig
Message-Id: <20071104132839.ea04cf6b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

An allyesconfig build creates a .text section that is so big that the
.text.init.refok and .fixup sections are too far away for the relocations
to be fixed up correctly. This patch fixes that by linking all the
relevent text sections for each file together.

Suggested by Paul Mackerras.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/vmlinux.lds.S |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

This still leaves us with the problem that the TOC overflows.

Dave, would something like this help as an alternative to the .fixup
change you committed recently?

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 823a8cb..f66fa5d 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -37,11 +37,10 @@ SECTIONS
 		ALIGN_FUNCTION();
 		*(.text.head)
 		_text = .;
-		TEXT_TEXT
+		*(.text .fixup .text.init.refok .exit.text.refok)
 		SCHED_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
-		*(.fixup)
 
 #ifdef CONFIG_PPC32
 		*(.got1)
-- 
1.5.3.5
