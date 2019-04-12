Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E3EC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 20:46:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C84F920850
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 20:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84F920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gqgD6qVGzDqW8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 06:46:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=jpoimboe@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gqWx1ZdjzDqTd
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Apr 2019 06:39:57 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 600CC308421A;
 Fri, 12 Apr 2019 20:39:55 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-231.rdu2.redhat.com [10.10.120.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B7AA2600C5;
 Fri, 12 Apr 2019 20:39:52 +0000 (UTC)
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] powerpc/speculation: Support 'mitigations=' cmdline
 option
Date: Fri, 12 Apr 2019 15:39:30 -0500
Message-Id: <245a606e1a42a558a310220312d9b6adb9159df6.1555085500.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1555085500.git.jpoimboe@redhat.com>
References: <cover.1555085500.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 12 Apr 2019 20:39:55 +0000 (UTC)
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
 Steven Price <steven.price@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Waiman Long <longman@redhat.com>,
 linux-arch@vger.kernel.org, Jon Masters <jcm@redhat.com>,
 Jiri Kosina <jikos@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Phil Auld <pauld@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Tyler Hicks <tyhicks@canonical.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Configure powerpc CPU runtime speculation bug mitigations in accordance
with the 'mitigations=' cmdline option.  This affects Meltdown, Spectre
v1, Spectre v2, and Speculative Store Bypass.

The default behavior is unchanged.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 9 +++++----
 arch/powerpc/kernel/security.c                  | 6 +++---
 arch/powerpc/kernel/setup_64.c                  | 2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3e33bd03441a..a03ab62b69af 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2545,7 +2545,7 @@
 			http://repo.or.cz/w/linux-2.6/mini2440.git
 
 	mitigations=
-			[X86] Control optional mitigations for CPU
+			[X86,PPC] Control optional mitigations for CPU
 			vulnerabilities.  This is a set of curated,
 			arch-independent options, each of which is an
 			aggregation of existing arch-specific options.
@@ -2554,10 +2554,11 @@
 				Disable all optional CPU mitigations.  This
 				improves system performance, but it may also
 				expose users to several CPU vulnerabilities.
-				Equivalent to: nopti [X86]
-					       nospectre_v2 [X86]
+				Equivalent to: nopti [X86,PPC]
+					       nospectre_v1 [PPC]
+					       nospectre_v2 [X86,PPC]
 					       spectre_v2_user=off [X86]
-					       spec_store_bypass_disable=off [X86]
+					       spec_store_bypass_disable=off [X86,PPC]
 					       l1tf=off [X86]
 
 			auto (default)
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index b33bafb8fcea..70568ccbd9fd 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -57,7 +57,7 @@ void setup_barrier_nospec(void)
 	enable = security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) &&
 		 security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR);
 
-	if (!no_nospec)
+	if (!no_nospec && !cpu_mitigations_off())
 		enable_barrier_nospec(enable);
 }
 
@@ -116,7 +116,7 @@ static int __init handle_nospectre_v2(char *p)
 early_param("nospectre_v2", handle_nospectre_v2);
 void setup_spectre_v2(void)
 {
-	if (no_spectrev2)
+	if (no_spectrev2 || cpu_mitigations_off())
 		do_btb_flush_fixups();
 	else
 		btb_flush_enabled = true;
@@ -300,7 +300,7 @@ void setup_stf_barrier(void)
 
 	stf_enabled_flush_types = type;
 
-	if (!no_stf_barrier)
+	if (!no_stf_barrier && !cpu_mitigations_off())
 		stf_barrier_enable(enable);
 }
 
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index ba404dd9ce1d..4f49e1a3594c 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -932,7 +932,7 @@ void setup_rfi_flush(enum l1d_flush_type types, bool enable)
 
 	enabled_flush_types = types;
 
-	if (!no_rfi_flush)
+	if (!no_rfi_flush && !cpu_mitigations_off())
 		rfi_flush_enable(enable);
 }
 
-- 
2.17.2

