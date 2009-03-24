Return-Path: <jk@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 551D7DDEE8
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 13:56:25 +1100 (EST)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] powerpc: Add write barrier before enabling DTL flags
Message-Id: <1237863308.620048.912148989400.1.gpush@pingu>
In-Reply-To: <<1236830152.729279.468331899806.3.gpush@pingu>>
To: Ben Herrenschmidt <benh@kernel.crashing.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Tue, 24 Mar 2009 13:55:08 +1100
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, we don't enforce any ordering for updates to the lppaca
when enabling dtl logging, so we may end up enabling logging before the
index fields have been established.

This change adds a smp_wmb() before doing the actual enable.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/platforms/pseries/dtl.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index dc9b0f8..fafcaa0 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -107,6 +107,10 @@ static int dtl_enable(struct dtl *dtl)
 	/* set our initial buffer indices */
 	dtl->last_idx = lppaca[dtl->cpu].dtl_idx = 0;
 
+	/* ensure that our updates to the lppaca fields have occurred before
+	 * we actually enable the logging */
+	smp_wmb();
+
 	/* enable event logging */
 	lppaca[dtl->cpu].dtl_enable_mask = dtl_event_mask;
 
