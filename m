Return-Path: <ego@in.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0FAA2B6F09
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Dec 2009 22:19:42 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id nBABJfFp020776
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2009 22:19:41 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBABJfoT1851510
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2009 22:19:41 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBABJeAj024003
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2009 22:19:41 +1100
Subject: [PATCH 2/2] pseries: Make declarations of cpu_hotplug_driver_lock()
	ANSI compatible.
To: linuxppc-dev@lists.ozlabs.org
From: Gautham R Shenoy <ego@in.ibm.com>
Date: Thu, 10 Dec 2009 16:49:42 +0530
Message-ID: <20091210111942.18281.33401.stgit@sofia.in.ibm.com>
In-Reply-To: <20091210111937.18281.5146.stgit@sofia.in.ibm.com>
References: <20091210111937.18281.5146.stgit@sofia.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Benjamin Herrenschmidt <benh@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

And add the __acquires() and __releases() annotations, while at it.

Signed-off-by: Gautham R Shenoy <ego@in.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 12df9e8..67b7a10 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -346,12 +346,14 @@ int dlpar_release_drc(u32 drc_index)
 
 static DEFINE_MUTEX(pseries_cpu_hotplug_mutex);
 
-void cpu_hotplug_driver_lock()
+void cpu_hotplug_driver_lock(void)
+__acquires(pseries_cpu_hotplug_mutex)
 {
 	mutex_lock(&pseries_cpu_hotplug_mutex);
 }
 
-void cpu_hotplug_driver_unlock()
+void cpu_hotplug_driver_unlock(void)
+__releases(pseries_cpu_hotplug_mutex)
 {
 	mutex_unlock(&pseries_cpu_hotplug_mutex);
 }
