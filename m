Return-Path: <mostrows@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3B71567A76
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 06:42:12 +1000 (EST)
Received: from sp1n294en1.watson.ibm.com (sp1n294en1.watson.ibm.com
	[129.34.20.40])
	by igw2.watson.ibm.com (8.12.11.20060308/8.13.1/8.13.1-2005-04-25 igw)
	with ESMTP id k4TKggjj014934
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:42:42 -0400
Received: from sp1n294en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n294en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with
	ESMTP id k4TKg8H372798
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:42:08 -0400
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n294en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with
	ESMTP id k4TKg83361348
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:42:08 -0400
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id
	k4TLZrb9002612
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 17:35:53 -0400
Subject: [PATCH 6/8] Avoid use of ppc64_interrupt_controller.
In-Reply-To: <1148935262.25048.31.camel@brick>
Date: Mon, 29 May 2006 16:42:06 -0400
Message-Id: <11489353261424-git-send-email-mostrows@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linuxppc-dev@ozlabs.org
From: mostrows@watson.ibm.com
Reply-To: mostrows@watson.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Checking the pSeries_mpic pointer will tell us if we have an MPIC
(and if not we assume XICS).

--
Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>

---

 arch/powerpc/platforms/pseries/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

b8d30cee0f0257489bb79c3d36f0afc39b8e63e6
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 38bf976..4ff127b 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -536,7 +536,7 @@ static void pseries_kexec_cpu_down(int c
 		}
 	}
 
-	if (ppc64_interrupt_controller == IC_OPEN_PIC)
+	if (pSeries_mpic)
 		mpic_teardown_this_cpu(secondary);
 	else
 		xics_teardown_cpu(secondary);
-- 
1.1.4.g0b63-dirty
