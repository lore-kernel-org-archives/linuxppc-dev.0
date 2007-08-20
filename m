Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CEB30DDE27
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 02:37:07 +1000 (EST)
Date: Mon, 20 Aug 2007 11:36:59 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 3/4] Use strcasecmp() rather than strncasecmp() when
	determining device node compatibility.
Message-ID: <20070820163659.GB29912@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070820163619.GA29889@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The current code assumes "foo-bar" must always be compatible with a node
compatible with "foo", which breaks device trees where this is not so.

The "case" part is also wrong according to Open Firmware, but it's more
likely to have drivers and/or device trees depending on it, and thus
needs to be handled more carefully.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 include/asm-powerpc/prom.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 6720837..b5dd101 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -24,7 +24,7 @@
 #define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	1
 #define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
 
-#define of_compat_cmp(s1, s2, l)	strncasecmp((s1), (s2), (l))
+#define of_compat_cmp(s1, s2, l)	strcasecmp((s1), (s2))
 #define of_prop_cmp(s1, s2)		strcmp((s1), (s2))
 #define of_node_cmp(s1, s2)		strcasecmp((s1), (s2))
 
-- 
1.5.0.3
