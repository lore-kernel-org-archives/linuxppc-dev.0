Return-Path: <jkenisto@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 54972B74C2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Nov 2010 15:54:35 +1100 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAC4npMD030786
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 21:49:51 -0700
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAC4sBeF163792
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 21:54:13 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oAC4wDN7018790
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 21:58:13 -0700
Received: from localhost.localdomain (w-jimk.beaverton.ibm.com [9.47.28.66])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	oAC4wDaA018464
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 21:58:13 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
Subject: [PATCH 1/4] Fix powerpc nvram init order
To: linuxppc-dev@lists.ozlabs.org
Date: Thu, 11 Nov 2010 20:53:54 -0800
Message-ID: <20101112045353.4290.56384.stgit@localhost.localdomain>
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

Don't run pseries_nvram_init_log_partition() until after the partition
list has been initialized.  Fixes a boot-time crash.

Signed-off-by: Jim Keniston <jkenisto@us.ibm.com>
---

 arch/powerpc/platforms/pseries/nvram.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index e3acb0b..e1a43d9 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -318,7 +318,7 @@ static int __init pseries_nvram_init_log_partition(void)
 	
 	return 0;
 }
-machine_arch_initcall(pseries, pseries_nvram_init_log_partition);
+machine_late_initcall(pseries, pseries_nvram_init_log_partition);
 
 int __init pSeries_nvram_init(void)
 {
