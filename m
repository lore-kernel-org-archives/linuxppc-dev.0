Return-Path: <anton@samba.org>
Date: Mon, 23 Dec 2013 12:19:51 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Align p_end
Message-ID: <20131223121951.6309b31a@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


p_end is an 8 byte value embedded in the text section. This means it
is only 4 byte aligned when it should be 8 byte aligned. Fix this
by adding an explicit alignment.

This fixes an issue where POWER7 little endian builds with 
CONFIG_RELOCATABLE=y fail to boot.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 2ae41ab..fad2abd 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -470,6 +470,7 @@ _STATIC(__after_prom_start)
 	mtctr	r8
 	bctr
 
+.balign 8
 p_end:	.llong	_end - _stext
 
 4:	/* Now copy the rest of the kernel up to _end */
