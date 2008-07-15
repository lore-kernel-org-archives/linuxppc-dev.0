Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4690DDEBCA
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 07:20:30 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6FLKPE7014648
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 17:20:25 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6FLKLxs143460
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 15:20:22 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6FLKLjq005462
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 15:20:21 -0600
Date: Tue, 15 Jul 2008 16:20:08 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
	linuxppc-dev@ozlabs.org, Brian King <brking@linux.vnet.ibm.com>,
	Nathan Fontenot <nfont@austin.ibm.com>,
	David Darrington <ddarring@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: correct CMO feature flag enablement
Message-ID: <20080715212008.GA25230@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Correct string conversion for rtas value being read for CMO configuration.
A value of -1 in the string indicates that CMO is not enabled and we
had used simple_strtoul rather than simple_strtol which caused problems.

Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---

This patch applies on top of the CMO patchset sent to the list.

---
 arch/powerpc/platforms/pseries/setup.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -366,9 +366,9 @@ void pSeries_cmo_feature_init(void)
 			}
 
 			if (0 == strcmp(key, "PrPSP"))
-				PrPSP = simple_strtoul(value, NULL, 10);
+				PrPSP = simple_strtol(value, NULL, 10);
 			else if (0 == strcmp(key, "SecPSP"))
-				SecPSP = simple_strtoul(value, NULL, 10);
+				SecPSP = simple_strtol(value, NULL, 10);
 			value = key = ptr + 1;
 		}
 		ptr++;
