Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-wm0-x230.google.com (mail-wm0-x230.google.com
 [IPv6:2a00:1450:400c:c09::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9076C1A023C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 01:19:52 +1100 (AEDT)
Received: by mail-wm0-x230.google.com with SMTP id u188so67703295wmu.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 06:19:52 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org, keescook@chromium.org,
 akpm@linux-foundation.org, mingo@kernel.org, hpa@zytor.com,
 heiko.carstens@de.ibm.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
 mmarek@suse.cz, rusty@rustcorp.com.au, arnd@arndb.de,
 linux-arch@vger.kernel.org, linux@roeck-us.net
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v4 1/3] x86: kallsyms: disable absolute percpu symbols on !SMP
Date: Mon, 25 Jan 2016 15:19:30 +0100
Message-Id: <1453731572-18448-2-git-send-email-ard.biesheuvel@linaro.org>
In-Reply-To: <1453731572-18448-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1453731572-18448-1-git-send-email-ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

scripts/kallsyms.c has a special --absolute-percpu command line
option which deals with the zero based per cpu offsets that are
used when building for SMP on x86_64. This means that the option
should only be passed in that case, so add a check for CONFIG_SMP.
Otherwise, per cpu variables are recorded as absolute quantities,
(which they are not under !CONFIG_SMP) and they are not relocated
under CONFIG_RELOCATABLE=y.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 scripts/link-vmlinux.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index ba6c34ea5429..b541c21072f2 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -86,7 +86,7 @@ kallsyms()
 		kallsymopt="${kallsymopt} --page-offset=$CONFIG_PAGE_OFFSET"
 	fi
 
-	if [ -n "${CONFIG_X86_64}" ]; then
+	if [ -n "${CONFIG_X86_64}" ] && [ -n "${CONFIG_SMP}" ]; then
 		kallsymopt="${kallsymopt} --absolute-percpu"
 	fi
 
-- 
2.5.0
