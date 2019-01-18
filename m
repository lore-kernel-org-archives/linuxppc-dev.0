Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A52C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:33:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C14C20850
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C14C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43h62W0JbrzDr3Z
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 03:33:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=217.72.192.74; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h5lf1qtnzDr27
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 03:20:45 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M8QNy-1gouaL0Udc-004VsZ; Fri, 18 Jan 2019 17:19:25 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 07/29] ARM: add kexec_file_load system call number
Date: Fri, 18 Jan 2019 17:18:13 +0100
Message-Id: <20190118161835.2259170-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8ym37e+lD/lgSGacCaoLSHBwvMbYSdoq935/+50m0n+e2+nfjyl
 Uc3eCCUqAr3iiX9tp3dh/UjTnNU1TWM344t7SmBQecjF8G3qbieGmrEuRnYfdVzVTXxlNMn
 1F6pSIpGD86JSkJzsxanqoPTEb+l+XA5OO3U0pzk6a/S0BMyuhTWrH4HTr95PQFlXgEL4sD
 b/smjhXtOquSiUivlB38g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hPFjMXC73D8=:yIT7bb4MDFSWj86wHD5l4c
 Dw71KKy4lEMciOZt+W7BOiEuK2mNuN+kh5N3AiCr4vfMUFyOd0gUpMGVvzlD5ys8kVC8UFHy1
 GF3XDa3FhTBMA3K+9JRQ8rmAsDSolTFqDYWCMPAT63yZzygeYo+H4Gb28+uNbUdwlsZqY9gO8
 6lK6+sEIXt8TvMB4ddTaGomaNQPmxg4p1hEhaovZAfReP98dH5330uzzrgeqRsnqM2eHkKNHE
 IPPBPHtvsyz2uSE81DXrtfxuBWnljymZkblHoH/MPVnSr/2bCgJGktCOvWDoVamsF7nbJsafo
 2OignWTVnOttBAtdSjEfSQ6CDTNo9IioOYs6f/rgrWALcLtl8cQBqMMcwSuRSeg7LAk4hc7Oj
 vKqxXzmE6UzScOdNEzF+a+2KnoI+oavrpydZ3aezYjXL9WJt6eh/9b1NMWLoLioZhktu7kZ6b
 mZh1EEbibQK8F64O6oN3sLL4qqNGDpvKpnMdtyBo2RHlZhWm2ACWT6TJIaGxLHEQjzxZGToRN
 IFf4ybmEY0PVOn3IHZu/nuvhVYHTeILnajyNYSzLFJ3VZ9kru5A/DCKSsLyoeKTCUNnQHigs5
 2bl5d22j1GPBmdXFJiXmupqH8HXQEkhm2IhAGe2JkhUkSAvGLFP1YeJ1fCfrGDG34cx2/LUcp
 JcCpam5vxV5OOFiQEFF/gbY/veubTMQIf5uhL2znlb1HwTgwa3y+NgPSsmX9zdfo3Hj9Ix3G5
 AQJldjI7SaGcXfDZb0CIJB58fi1O6B6dUcSGIQ==
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
Cc: dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, jcmvbkbc@gmail.com,
 deepa.kernel@gmail.com, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, deller@gmx.de, x86@kernel.org,
 linux@armlinux.org.uk, mingo@redhat.com, geert@linux-m68k.org,
 firoz.khan@linaro.org, mattst88@gmail.com, fenghua.yu@intel.com,
 Arnd Bergmann <arnd@arndb.de>, heiko.carstens@de.ibm.com,
 linux-fsdevel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 luto@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 monstr@monstr.eu, tony.luck@intel.com, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, linux-mips@vger.kernel.org, paul.burton@mips.com,
 ebiederm@xmission.com, linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

A couple of architectures including arm64 already implement the
kexec_file_load system call, on many others we have assigned a system
call number for it, but not implemented it yet.

Adding the number in arch/arm/ lets us use the system call on arm64
systems in compat mode, and also reduces the number of differences
between architectures. If we want to implement kexec_file_load on ARM
in the future, the number assignment means that kexec tools can already
be built with the now current set of kernel headers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/tools/syscall.tbl        | 1 +
 arch/arm64/include/asm/unistd.h   | 2 +-
 arch/arm64/include/asm/unistd32.h | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 86de9eb34296..20ed7e026723 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -415,3 +415,4 @@
 398	common	rseq			sys_rseq
 399	common	io_pgetevents		sys_io_pgetevents
 400	common	migrate_pages		sys_migrate_pages
+401	common	kexec_file_load		sys_kexec_file_load
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 261216c3336e..2c30e6f145ff 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -44,7 +44,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		401
+#define __NR_compat_syscalls		402
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index f15bcbacb8f6..8ca1d4c304f4 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -823,6 +823,8 @@ __SYSCALL(__NR_rseq, sys_rseq)
 __SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
 #define __NR_migrate_pages 400
 __SYSCALL(__NR_migrate_pages, compat_sys_migrate_pages)
+#define __NR_kexec_file_load 401
+__SYSCALL(__NR_kexec_file_load, sys_kexec_file_load)
 
 /*
  * Please add new compat syscalls above this comment and update
-- 
2.20.0

