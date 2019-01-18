Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B138C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:59:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 999072086D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999072086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43h6cn531ZzDr6l
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 03:59:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=217.72.192.74; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h5mk6zpWzDr1f
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 03:21:42 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Moex5-1hYebH2yzJ-00p534; Fri, 18 Jan 2019 17:19:42 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 20/29] time: fix sys_timer_settime prototype
Date: Fri, 18 Jan 2019 17:18:26 +0100
Message-Id: <20190118161835.2259170-21-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:r9zYRN1bn3jR2apA4gH3kpzMsx6Z1jHN7Z6MVMR9SqgauRuwsGW
 g3AmYvhN48u7jGc9XyjbvqlEZyc2h5boSgVfbDl8HeTDSZJ7+36lDncKb0n8beoPpyVukaj
 I9WNJZ4OTm1Rgh/HwlzJTCDaYv/uB9ZvTrwC0JiXRRAA8+HE+ofgv2cP5P9nOGaG6S/KU8p
 4ViaO2EbrciAIgouxqIxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XASFSNdrSgg=:32sZlMVf4NdP/xRX5FSGsS
 1hID4IEHQyAvdyxeMVrUXuJ+NLrCJ5uDZE7FzjkhtHtfx/SENRonZqNBSFj7g2GBc6UcqbiYC
 4y0jx7WV8+9rDgN4Xnu6qMhTRFef+AdfgNDekGoN42LaT+CSo3SDr1bnE423lcTizBLhs7zyN
 24zAC1s+Tfpd8KRGJDPXFwoaKKr+rz3J+FdnX2yHY7NLpGcBbBRTUzqtT2wSP5aYdH8mO5eNd
 8kseNM2Pn7nHdd5nlCRV6RbmORl+zSQligYu1x5aZeuQne0SAotmLENDMqidJetBLTFCUDL0Z
 3h9iy6002wHYr9AAb5Ja4LmZ7NrJ8sHnnShepAP6/cvb9hQRSqAv9OKi2BNGx+kYUtUXaoUB4
 LfLbaI+YEEyJxsf84pqG5FUT76vOIUTMH7CCDWJvEdRNKA5ZkNsI1+bSk4XqCGy/cOVvmpxeu
 nGxza1i8A+ACBnz0IH7AqpEV60bzcx8rrlOVuX73nsGvgCJLaKzzcLxDe9T/LwSLvuwPmfDDY
 V8hDNOLQeyPO7rK7V2YnmtGE/Q2S6odeUtznHsJefZy8VlgA0H4l4W/YVHfpoxOiqq2JmpNrE
 l10cLnzMxgSLcVHJdMMAPcY49WQfbo9aSPXl0CyX6i1vTMTPaOwDRL94bv0rOfl38+ea8x4Iz
 b7ArQdZVUEWmatIdXq25G2pktwQtICJR0s577+vznODrG5wDttLBMXvHeGtrU72aZWSQ64ghA
 jxdzIhiv6Z/liKFKlOc2lyxLatu/RdmJblr4rQ==
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

A small typo has crept into the y2038 conversion of the timer_settime
system call. So far this was completely harmless, but once we start
using the new version, this has to be fixed.

Fixes: 6ff847350702 ("time: Change types to new y2038 safe __kernel_itimerspec")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/syscalls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 938d8908b9e0..baa4b70b02d3 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -591,7 +591,7 @@ asmlinkage long sys_timer_gettime(timer_t timer_id,
 asmlinkage long sys_timer_getoverrun(timer_t timer_id);
 asmlinkage long sys_timer_settime(timer_t timer_id, int flags,
 				const struct __kernel_itimerspec __user *new_setting,
-				struct itimerspec __user *old_setting);
+				struct __kernel_itimerspec __user *old_setting);
 asmlinkage long sys_timer_delete(timer_t timer_id);
 asmlinkage long sys_clock_settime(clockid_t which_clock,
 				const struct __kernel_timespec __user *tp);
-- 
2.20.0

