Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4EEC4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 16:50:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D18D3206DF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 16:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18D3206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZppX61tnzDqDm
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 03:50:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=jpoimboe@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Zphp0r7zzDqFB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 03:45:11 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D8CB93078AAE;
 Thu,  4 Apr 2019 16:45:08 +0000 (UTC)
Received: from treble.redhat.com (ovpn-125-158.rdu2.redhat.com [10.10.125.158])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1ED53608E5;
 Thu,  4 Apr 2019 16:45:06 +0000 (UTC)
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/5] cpu/speculation: Add 'cpu_spec_mitigations=' cmdline
 options
Date: Thu,  4 Apr 2019 11:44:11 -0500
Message-Id: <f0bd17358ab478eaca52f3b1da8305c150911b40.1554396090.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1554396090.git.jpoimboe@redhat.com>
References: <cover.1554396090.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 04 Apr 2019 16:45:09 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org,
 x86@kernel.org, Will Deacon <will.deacon@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Waiman Long <longman@redhat.com>,
 linux-arch@vger.kernel.org, Jon Masters <jcm@redhat.com>,
 Jiri Kosina <jikos@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tyler Hicks <tyhicks@canonical.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Keeping track of the number of mitigations for all the CPU speculation
bugs has become overwhelming for many users.  It's getting more and more
complicated to decide which mitigations are needed for a given
architecture.  Complicating matters is the fact that each arch tends to
their own custom way to mitigate the same vulnerability.

Most users fall into a few basic categories:

a) they want all mitigations off;

b) they want all reasonable mitigations on, with SMT enabled even if
   it's vulnerable; or

c) they want all reasonable mitigations on, with SMT disabled if
   vulnerable.

Define a set of curated, arch-independent options, each of which is an
aggregation of existing options:

- cpu_spec_mitigations=off: Disable all mitigations.

- cpu_spec_mitigations=auto: [default] Enable all the default
  mitigations, but leave SMT enabled, even if it's vulnerable.

- cpu_spec_mitigations=auto,nosmt: Enable all the default mitigations,
  disabling SMT if needed by a mitigation.

Currently, these options are placeholders which don't actually do
anything.  They will be fleshed out in upcoming patches.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 .../admin-guide/kernel-parameters.txt         | 23 +++++++++++++++++++
 include/linux/cpu.h                           |  8 +++++++
 kernel/cpu.c                                  | 15 ++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c4d830003b21..ac42e510bd6e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2544,6 +2544,29 @@
 			in the "bleeding edge" mini2440 support kernel at
 			http://repo.or.cz/w/linux-2.6/mini2440.git
 
+	cpu_spec_mitigations=
+			[KNL] Control mitigations for CPU speculation
+			vulnerabilities on affected CPUs.  This is a set of
+			curated, arch-independent options, each of which is an
+			aggregation of existing options.
+
+			off
+				Disable all speculative CPU mitigations.
+
+			auto (default)
+				Mitigate all speculative CPU vulnerabilities,
+				but leave SMT enabled, even if it's vulnerable.
+				This is useful for users who don't want to be
+				surprised by SMT getting disabled across kernel
+				upgrades, or who have other ways of avoiding
+				SMT-based attacks.
+
+			auto,nosmt
+				Mitigate all speculative CPU vulnerabilities,
+				disabling SMT if needed.  This is for users who
+				always want to be fully mitigated, even if it
+				means losing SMT.
+
 	mminit_loglevel=
 			[KNL] When CONFIG_DEBUG_MEMORY_INIT is set, this
 			parameter allows control of the logging verbosity for
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 5041357d0297..3a1740fda2e2 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -187,4 +187,12 @@ static inline void cpu_smt_disable(bool force) { }
 static inline void cpu_smt_check_topology(void) { }
 #endif
 
+enum cpu_spec_mitigations {
+	CPU_SPEC_MITIGATIONS_OFF,
+	CPU_SPEC_MITIGATIONS_AUTO,
+	CPU_SPEC_MITIGATIONS_AUTO_NOSMT,
+};
+
+extern enum cpu_spec_mitigations cpu_spec_mitigations;
+
 #endif /* _LINUX_CPU_H_ */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6c959aea0f9e..0a9d66b90a00 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2306,3 +2306,18 @@ void __init boot_cpu_hotplug_init(void)
 #endif
 	this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
 }
+
+enum cpu_spec_mitigations cpu_spec_mitigations __ro_after_init = CPU_SPEC_MITIGATIONS_AUTO;
+
+static int __init cpu_spec_mitigations_setup(char *arg)
+{
+	if (!strcmp(arg, "off"))
+		cpu_spec_mitigations = CPU_SPEC_MITIGATIONS_OFF;
+	else if (!strcmp(arg, "auto"))
+		cpu_spec_mitigations = CPU_SPEC_MITIGATIONS_AUTO;
+	else if (!strcmp(arg, "auto,nosmt"))
+		cpu_spec_mitigations = CPU_SPEC_MITIGATIONS_AUTO_NOSMT;
+
+	return 0;
+}
+early_param("cpu_spec_mitigations", cpu_spec_mitigations_setup);
-- 
2.17.2

