Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CFAE3DE508
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:36:17 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1aCST027760
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:36:13 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1aCBA001598
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:36:12 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1BVIM007995
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:11:31 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 3D94AAEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:36:11 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1aBo4015474
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:36:11 -0500
Date: Tue, 17 Jul 2007 20:36:11 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 53/61] 82xx: Set NOT_COHERENT_CACHE on 8272 with PCI.
Message-ID: <20070718013611.GY15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've seen significant network corruption on a PCI network
card (e1000) with the mpc8272ads; the corruption went away
when I set CONFIG_NOT_COHERENT_CACHE.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/Kconfig.cputype |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 0e865b8..3cf4af4 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -213,7 +213,7 @@ config NR_CPUS
 
 config NOT_COHERENT_CACHE
 	bool
-	depends on 4xx || 8xx || E200
+	depends on 4xx || 8xx || E200 || (8272 && PCI)
 	default y
 
 config CONFIG_CHECK_CACHE_COHERENCY
-- 
1.5.0.3
