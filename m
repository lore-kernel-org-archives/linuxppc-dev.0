Return-Path: <galak@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 3862867A62
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Jun 2005 00:14:11 +1000 (EST)
Date: Sun, 26 Jun 2005 09:14:01 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0506260912530.9741@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, tony.Li@freescale.com,
	linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [RESEND][PATCH] ppc32: Fix MPC83xx IPIC external interrupt pending
 register offset
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

(I think this got lost by linus in the shuffle)

The pending registers for IRQ1-IRQ7 were pointing to the interrupt pending
register instead of the external one.

Signed-off-by: Tony Li <Tony.Li@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 7ada9b1e61d5af4c75f32bfc1f7aabca435024ed
tree 44de45c386a0f22584344494bfe1eb453dffa16c
parent e3f1d172ca1cfd1ac2dd907c31fb2521bfe21689
author Kumar K. Gala <kumar.gala@freescale.com> Thu, 23 Jun 2005 22:49:39 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 23 Jun 2005 22:49:39 -0500

 arch/ppc/syslib/ipic.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/ppc/syslib/ipic.c b/arch/ppc/syslib/ipic.c
--- a/arch/ppc/syslib/ipic.c
+++ b/arch/ppc/syslib/ipic.c
@@ -79,7 +79,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 7,
 	},
 	[17] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SEFCR,
@@ -87,7 +87,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 5,
 	},
 	[18] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SEFCR,
@@ -95,7 +95,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 6,
 	},
 	[19] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SEFCR,
@@ -103,7 +103,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 7,
 	},
 	[20] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SEFCR,
@@ -111,7 +111,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 4,
 	},
 	[21] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SEFCR,
@@ -119,7 +119,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 5,
 	},
 	[22] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SEFCR,
@@ -127,7 +127,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 6,
 	},
 	[23] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SEFCR,
