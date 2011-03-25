Return-Path: <jkenisto@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2EDCAB6FB0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Mar 2011 09:48:04 +1100 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p2PMgdi0014882
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Mar 2011 16:42:39 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p2PMlwDZ077710
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Mar 2011 16:47:58 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p2PMqn3O007532
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Mar 2011 16:52:49 -0600
From: Jim Keniston <jkenisto@us.ibm.com>
Subject: [PATCH] nvram: Don't overwrite oops/panic report on normal shutdown
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 25 Mar 2011 15:47:58 -0700
Message-ID: <20110325224758.9413.58317.stgit@localhost.localdomain>
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

For normal halt, reboot, and poweroff events, refrain from overwriting
the lnx,oops-log partition.  Also, don't save the dmesg buffer on an
emergency-restart event if we've already saved it earlier in panic().

Signed-off-by: Jim Keniston <jkenisto@us.ibm.com>
---

 arch/powerpc/platforms/pseries/nvram.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 419707b..00cc3a0 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -480,8 +480,32 @@ static void oops_to_nvram(struct kmsg_dumper *dumper,
 		const char *new_msgs, unsigned long new_len)
 {
 	static unsigned int oops_count = 0;
+	static bool panicking = false;
 	size_t text_len;
 
+	switch (reason) {
+	case KMSG_DUMP_RESTART:
+	case KMSG_DUMP_HALT:
+	case KMSG_DUMP_POWEROFF:
+		/* These are almost always orderly shutdowns. */
+		return;
+	case KMSG_DUMP_OOPS:
+	case KMSG_DUMP_KEXEC:
+		break;
+	case KMSG_DUMP_PANIC:
+		panicking = true;
+		break;
+	case KMSG_DUMP_EMERG:
+		if (panicking)
+			/* Panic report already captured. */
+			return;
+		break;
+	default:
+		pr_err("%s: ignoring unrecognized KMSG_DUMP_* reason %d\n",
+						__FUNCTION__, (int) reason);
+		return;
+	}
+
 	if (clobbering_unread_rtas_event())
 		return;
 
