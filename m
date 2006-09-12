Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 386FD67A3E
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Sep 2006 01:04:31 +1000 (EST)
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id
	k8CF4UM1020005
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Sep 2006 11:04:30 -0400
Received: from pobox.surrey.redhat.com (pobox.surrey.redhat.com [172.16.10.17])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id
	k8CF4TCX015372
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Sep 2006 11:04:30 -0400
Received: from warthog.cambridge.redhat.com (warthog.cambridge.redhat.com
	[172.16.18.73])
	by pobox.surrey.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id
	k8CF4Rwd010828
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Sep 2006 16:04:27 +0100
Received: from warthog.cambridge.redhat.com (localhost.localdomain [127.0.0.1])
	by warthog.cambridge.redhat.com (8.13.7/8.13.4) with ESMTP id
	k8CF4Pd6027129
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Sep 2006 16:04:25 +0100
From: David Howells <dhowells@redhat.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Export copy_4K_page()
Date: Tue, 12 Sep 2006 16:04:25 +0100
Message-ID: <27128.1158073465@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Export copy_4K_page() for use by modules via copy_page() (such as CacheFiles).

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/powerpc/kernel/ppc_ksyms.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 39d3bfc..b2edac8 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -91,6 +91,9 @@ EXPORT_SYMBOL(__copy_tofrom_user);
 EXPORT_SYMBOL(__clear_user);
 EXPORT_SYMBOL(__strncpy_from_user);
 EXPORT_SYMBOL(__strnlen_user);
+#ifdef CONFIG_PPC64
+EXPORT_SYMBOL(copy_4K_page);
+#endif
 
 #ifndef  __powerpc64__
 EXPORT_SYMBOL(__ide_mm_insl);
