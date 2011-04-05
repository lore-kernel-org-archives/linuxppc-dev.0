Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0627CB6FBA
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 16:14:20 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id p3569D1O021507
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:09:13 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p356EKXq2248770
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:20 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p356EKIq024376
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:20 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/15] powerpc/rtas: Check RTAS presence when testing
	indicators
Date: Tue,  5 Apr 2011 16:13:58 +1000
Message-Id: <1301984051-18413-3-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
References: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/rtas.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 2097f2b..c2bfc4d 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -591,6 +591,8 @@ bool rtas_indicator_present(int token, int *maxindex)
 		u32 maxindex;
 	} *indicators;
 
+	if (!rtas.dev)
+		return false;
 	indicators = of_get_property(rtas.dev, "rtas-indicators", &proplen);
 	if (!indicators)
 		return false;
-- 
1.7.1
