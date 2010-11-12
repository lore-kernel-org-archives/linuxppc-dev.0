Return-Path: <jkenisto@us.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F0F2CB7129
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Nov 2010 15:54:45 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAC4qBSw014609
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 21:52:11 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAC4sHg6132344
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 21:54:24 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oAC4sGJD000375
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 21:54:16 -0700
Received: from localhost.localdomain (w-jimk.beaverton.ibm.com [9.47.28.66])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	oAC4sGRY000352
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 21:54:16 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
Subject: [PATCH 2/4] Fix nvram_create_partition() arg order
To: linuxppc-dev@lists.ozlabs.org
Date: Thu, 11 Nov 2010 20:54:16 -0800
Message-ID: <20101112045415.4290.21690.stgit@localhost.localdomain>
In-Reply-To: <20101112045346.4290.43739.stgit@localhost.localdomain>
References: <20101112045346.4290.43739.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the correct arg order when calling nvram_create_partition().

Signed-off-by: Jim Keniston <jkenisto@us.ibm.com>
---

 arch/powerpc/platforms/pseries/nvram.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index e1a43d9..4b705dc 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -292,7 +292,7 @@ static int __init pseries_nvram_init_log_partition(void)
 	/* Create one if we didn't find */
 	if (!p) {
 		p = nvram_create_partition(NVRAM_LOG_PART_NAME, NVRAM_SIG_OS,
-					   NVRAM_MIN_REQ, NVRAM_MAX_REQ);
+					   NVRAM_MAX_REQ, NVRAM_MIN_REQ);
 		/* No room for it, try to get rid of any OS partition
 		 * and try again
 		 */
@@ -301,8 +301,8 @@ static int __init pseries_nvram_init_log_partition(void)
 				" partition, deleting all OS partitions...");
 			nvram_remove_partition(NULL, NVRAM_SIG_OS);
 			p = nvram_create_partition(NVRAM_LOG_PART_NAME,
-						   NVRAM_SIG_OS, NVRAM_MIN_REQ,
-						   NVRAM_MAX_REQ);
+						   NVRAM_SIG_OS, NVRAM_MAX_REQ,
+						   NVRAM_MIN_REQ);
 		}
 	}
 
