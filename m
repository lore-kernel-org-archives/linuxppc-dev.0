Return-Path: <galak@freescale.com>
Date: Mon, 10 Oct 2005 14:51:12 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0510101449420.1572@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] powerpc: zero out BSS for all platforms 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We need to ensure that the BSS is zeroed out for all platforms.
Currently only prom_init.c was clearlying out the BSS which only works
for PPC_OF platforms.

Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>

---
commit 56381a9f0765ba3ffa5f21a4cdcb93ac0279eeea
tree 9f0f353b0776129626082a46b578d637fb79dad1
parent dfc32a358c961c3fbfa94942ecb06da2e895ffe7
author Kumar K. Gala <kumar.gala@freescale.com> Mon, 10 Oct 2005 14:48:36 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Mon, 10 Oct 2005 14:48:36 -0500

 arch/powerpc/kernel/setup.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/setup.c b/arch/powerpc/kernel/setup.c
--- a/arch/powerpc/kernel/setup.c
+++ b/arch/powerpc/kernel/setup.c
@@ -293,6 +293,10 @@ unsigned long __init early_init(unsigned
 
 	reloc_got2(offset);
 
+	/* First zero the BSS -- use memset, some arches don't have
+	 * caches on yet */
+	memset_io(PTRRELOC(&__bss_start), 0, _end - __bss_start);
+
 	/*
 	 * Identify the CPU type and fix up code sections
 	 * that depend on which cpu we have.
