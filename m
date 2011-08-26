Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e24smtp05.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 63B53B6FD1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Aug 2011 06:36:50 +1000 (EST)
Received: from /spool/local by br.ibm.com with XMail ESMTP
	for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
	Fri, 26 Aug 2011 17:36:40 -0300
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
	by mailhub1.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7QKdSH01745118
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2011 17:39:28 -0300
Received: from d24av03.br.ibm.com (loopback [127.0.0.1])
	by d24av03.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7QKaj9j000443
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2011 17:36:45 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/eeh: fix /proc/ppc64/eeh creation
Date: Fri, 26 Aug 2011 17:36:31 -0300
Message-Id: <1314390991-27223-1-git-send-email-cascardo@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Breno Leitao <leitao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since commit 188917e183cf9ad0374b571006d0fc6d48a7f447, /proc/ppc64 is a
symlink to /proc/powerpc/. That means that creating /proc/ppc64/eeh will
end up with a unaccessible file, that is not listed under /proc/powerpc/
and, then, not listed under /proc/ppc64/.

Creating /proc/powerpc/eeh fixes that problem and maintain the
compatibility intended with the ppc64 symlink.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index ada6e07..d42f37d 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -1338,7 +1338,7 @@ static const struct file_operations proc_eeh_operations = {
 static int __init eeh_init_proc(void)
 {
 	if (machine_is(pseries))
-		proc_create("ppc64/eeh", 0, NULL, &proc_eeh_operations);
+		proc_create("powerpc/eeh", 0, NULL, &proc_eeh_operations);
 	return 0;
 }
 __initcall(eeh_init_proc);
-- 
1.7.4.4
