Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34DDC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:26:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B1B620850
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1B620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43h5tW2MVHzDr4r
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 03:26:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=217.72.192.75; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h5ld1gg4zDr1j
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 03:20:44 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MxmBc-1hA8vX10n8-00zDnp; Fri, 18 Jan 2019 17:19:29 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 10/29] sh: add statx system call
Date: Fri, 18 Jan 2019 17:18:16 +0100
Message-Id: <20190118161835.2259170-11-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:t6R82Z8zvFPH8uWQ6By1AD6aeG6e8KS2PY2/czpxmB8Es3E26cv
 3dhBYAef9afhAuL29iHi03NhT3UhsVoPZnZgPwDSWRTBENn7w6vYQa04n0JEgelAV4AcQV4
 niYmWNSNREOQA7PmgEZSP8TTUvUovupTfoOkrCAgtXj1/eWPuXUVXUAbdG11E5Dzakhmw3B
 pcwXh5016l/gnps966ABw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K/830N4fOkA=:yN6pOj/X6AddYs3f+eMAIX
 KZAXszxGKZpxuZdFdqWqDpVCdiq7BDlsKw5Zlv3n5jTwNsq1pS7SY/hlDdh1ADT1cb5xsCgET
 Gb4r4HL1nl/9ZSl1wjr94ugJZp+q6Em6x9V1hItbA3T9OZ3/zX78SQoF69CITLB4KKWknfok0
 TJOMxaojmcDtEdRmxh0tBzQXNxtPyV45u4zhDAK4/qJk4Fo9usCEZjT1W0mkVwVHYTfKwLSIf
 HbIj8UKQPvMwOGeLhsnrXZA4dgFFmrDJ4/9M8+UG+tzMakmVh+YLibDaUM19QCE81rxIlw9T7
 p/zg75cru2OhVCX8iZ6bq3O+jwVsqqyIA/U5RJjjIJzr1EuN4IQLAd77WCJG6v/uc64+wnBWM
 7FLDGmYFLengqH3ZTPAKfuApbWgGoFtgkZZ6Pg4UtmLFbpOI2JTTPlSe9plOwagBizOzFsSEX
 ZAhC3O9XT2DutmKSKdV5rQTGRQKzBk/FlzWUP5/P5IKoHgKjXjXcLOjjPmQxEawiUNDcZg0kZ
 bZQMQZdNRpio44pggQSPFl6vkB/UQDTJ7EyCzjn+qHq09wFoF+HjbB1SSUO8j9Cuv9Gi2pI53
 10zJ/kIT6LsnKordXwiWo06lPR7ZnvRSnvaWbI14kQwXtODJiJyjPiinoFMZxqSJJXq5Qp/YP
 M7X0SSEku5AAmTelT8L5LGrCy9KOXPvV0ux6a9PVGXvk/IA7FOUywhhMyLCYnJwc3Dw/KEybT
 VbS5ECidR7DDExAyvQNUJmwmbhphorFSJQSrhQ==
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

statx is available on almost all other architectures but
got missed on sh, so add it now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/kernel/syscalls/syscall.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 21ec75288562..a70db013dbc7 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -390,3 +390,4 @@
 380	common	copy_file_range			sys_copy_file_range
 381	common	preadv2				sys_preadv2
 382	common	pwritev2			sys_pwritev2
+383	common	statx				sys_statx
-- 
2.20.0

