Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C37C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 16:37:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13D1120874
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 16:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D1120874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bBVB0lCzzDqrM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 03:37:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=217.72.192.75; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bBG33ycKzDqkj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 03:26:35 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M26n9-1gjYwt2XdZ-002VJW; Thu, 10 Jan 2019 17:25:14 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] ARM: add kexec_file_load system call number
Date: Thu, 10 Jan 2019 17:24:27 +0100
Message-Id: <20190110162435.309262-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bbQTa8+RVq8uOU5pbxDK+0/4n2oFwdb20J9rbCJvp69tR6LbpUE
 BGw9PvuvotSd1z/CxUlN3LgFpu8c2eaVfhJU913d+y+4OuiKFe0x+5pUiPKr+A8JyoqUNYl
 +HzTAqMZP6muHMdLv1v6FLhgS7jrtc4eJiWfRbo6++zUEUKkS/plrzdPDX4N3ebSRZ82vdU
 29ipN8xprnY8eaAdBUF1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KcIkOw8POYU=:PlPoKFpPERWmgM//oISQHu
 FSulXma/Pg8PEBbrHXiPuKmqgQPSJjkYE+IphJVFUZAY6EDeu6AtFVVptEDSdANsrovpTXcAL
 b/AS9w9/SN/itOc8+uv+gP7/lQwmYzvDK1BbwMZpnXwYFjfMvbHPoKh9HcCWPXrhFDSGmw+8y
 5noFZR9dcb/SHixiXSpF1Uzzrt/1D05eMzRme6bDd6MQ8vzxvH9RxaowXKWyPsrHShPT5Yns3
 RvFMOs0GUK3O83DVUX7KxpyabIrqW2LWJqx+aQ/5s1+2NDh5iBfmAYGenrjOjg1Dw7D3x2DO6
 CbwGY7gKDYkp0Xv059QhC7u7F1tqgEzxTdrIb4K+LJQWNhFWZE6dFMlppU8my+3kMD+cIT6a4
 /lKUb9S1bXaWBFRozDTYAQ/dWsNDdcosUEbHB8AsA5zHlOClTE881gOj7PkZjhSIyEpiIEioD
 iBQFivwkpvXegsxBX3XNPos5ITLYPP00OJlLDCNuDqXAAMqMGQWMyaOHiSPo+J0RuYfofVFUk
 +ZA+taJ3UVicsNsNzgjrOb/MA1fkK79L0NYP12Nqoq7c8R8vhby74mvgU8cyLD8zYnzaa6jLH
 4nGKiLGdIzNVujVY6D9aWQawS+VNaFBXbqJ55jmmne047urmDt0vQV5Lg53Yze4OpTMtc1ZKL
 bEcAVanw4q5TBWN6nFcFgDqVzMcE+qwbf76mZR1JQw1kZojx200VU6Wc77Ggq+t14WHPxEt3u
 fc4ZKBNefarvA8bAMh25iORuVAYJ+Kk4mxSxzQ==
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
 catalin.marinas@arm.com, will.deacon@arm.com, linux@dominikbrodowski.net,
 jcmvbkbc@gmail.com, deepa.kernel@gmail.com, hpa@zytor.com,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, dave@stgolabs.net,
 deller@gmx.de, x86@kernel.org, linux@armlinux.org.uk, mingo@redhat.com,
 geert@linux-m68k.org, firoz.khan@linaro.org, mattst88@gmail.com,
 fenghua.yu@intel.com, Arnd Bergmann <arnd@arndb.de>, heiko.carstens@de.ibm.com,
 linux-m68k@lists.linux-m68k.org, ink@jurassic.park.msu.ru, luto@kernel.org,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, monstr@monstr.eu,
 tony.luck@intel.com, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
 paul.burton@mips.com, ebiederm@xmission.com, linux-alpha@vger.kernel.org,
 schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
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
index 355fe2bc035b..19f3f58b6146 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -823,6 +823,8 @@ __SYSCALL(__NR_rseq, sys_rseq)
 __SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
 #define __NR_migrate_pages 400
 __SYSCALL(__NR_migrate_pages, sys_migrate_pages)
+#define __NR_kexec_file_load 401
+__SYSCALL(__NR_kexec_file_load, sys_kexec_file_load)
 
 /*
  * Please add new compat syscalls above this comment and update
-- 
2.20.0

