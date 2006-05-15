Return-Path: <mostrows@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9DFC6679F4
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 22:49:22 +1000 (EST)
Subject: [PATCH] Create /proc/rtas,/proc/ppc64/rtas if RTAS exists.
In-Reply-To: 
Date: Mon, 15 May 2006 08:51:07 -0400
Message-Id: <11476974671035-git-send-email-mostrows@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: paulus@samba.org, benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
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

Use the existence of RTAS device tree node to determine if
/proc/rtas. /proc/ppc64/rtas are to be created.  Using machine type
is not reliable (i.e. Maple-like machines may have RTAS).

--
Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>

---

 arch/powerpc/kernel/proc_ppc64.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

d8054b07bbf12e0178ec5ad7ce6a750a3af53064
diff --git a/arch/powerpc/kernel/proc_ppc64.c b/arch/powerpc/kernel/proc_ppc64.c
index 3c2cf66..2b87f82 100644
--- a/arch/powerpc/kernel/proc_ppc64.c
+++ b/arch/powerpc/kernel/proc_ppc64.c
@@ -52,7 +52,7 @@ static int __init proc_ppc64_create(void
 	if (!root)
 		return 1;
 
-	if (!machine_is(pseries) && !machine_is(cell))
+	if (!of_find_node_by_path("/rtas"))
 		return 0;
 
 	if (!proc_mkdir("rtas", root))
-- 
1.1.4.g0b63-dirty
