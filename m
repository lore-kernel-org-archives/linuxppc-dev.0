Return-Path: <rickard_strandqvist@spectrumdigital.se>
Received: from mail-ee0-f42.google.com (mail-ee0-f42.google.com [74.125.83.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E83C1A054B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 08:02:29 +1000 (EST)
Received: by mail-ee0-f42.google.com with SMTP id d49so3111503eek.29
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 15:02:25 -0700 (PDT)
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH] arch: powerpc: kernel: fadump.c: Cleaning up inconsistent
 NULL checks
Date: Fri, 23 May 2014 00:03:16 +0200
Message-Id: <1400796196-12974-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cleaning up inconsistent NULL checks.
There is otherwise a risk of a possible null pointer dereference.

Was largely found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/powerpc/kernel/fadump.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 2230fd0..a76e7a4 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -645,7 +645,7 @@ static int __init fadump_build_cpu_notes(const struct fadump_mem_struct *fdm)
 		}
 		/* Lower 4 bytes of reg_value contains logical cpu id */
 		cpu = reg_entry->reg_value & FADUMP_CPU_ID_MASK;
-		if (!cpumask_test_cpu(cpu, &fdh->cpu_online_mask)) {
+		if (fdh && !cpumask_test_cpu(cpu, &fdh->cpu_online_mask)) {
 			SKIP_TO_NEXT_CPU(reg_entry);
 			continue;
 		}
@@ -662,9 +662,11 @@ static int __init fadump_build_cpu_notes(const struct fadump_mem_struct *fdm)
 	}
 	fadump_final_note(note_buf);
 
-	pr_debug("Updating elfcore header (%llx) with cpu notes\n",
+	if (fdh) {
+		pr_debug("Updating elfcore header (%llx) with cpu notes\n",
 							fdh->elfcorehdr_addr);
-	fadump_update_elfcore_header((char *)__va(fdh->elfcorehdr_addr));
+		fadump_update_elfcore_header((char *)__va(fdh->elfcorehdr_addr));
+	}
 	return 0;
 
 error_out:
-- 
1.7.10.4
