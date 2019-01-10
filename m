Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2CCC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 16:38:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5EFC206B7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 16:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5EFC206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bBWx1zwQzDqlZ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 03:38:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=217.72.192.74; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bBG82kK8zDqm9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 03:26:39 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mate1-1hILjh2T0d-00cOMW; Thu, 10 Jan 2019 17:25:18 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] sh: add statx system call
Date: Thu, 10 Jan 2019 17:24:30 +0100
Message-Id: <20190110162435.309262-11-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:h4QdAifLam4g7JZ0RiA7Sql/9EWtvVpzCJaWohLb5+jRFokClhv
 9v/OjTvK3x5DsjX1gTUQ6lOp7C5GYphXGZen1IMAu02YPxTyzAdMYoowsG7kkmc/YQOjJPa
 jX7UfF8kf4eGDgsrm8Xa/J/plh2QibVg882GQ9cXpVBd0jyXZ9nSdMk2p9qn1fiHurxOKS9
 El2e2jM1xOn8YE19u03AA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QmoIGFVpQPw=:Im57Cbx4QWOknyrADQIk10
 YM4vWHeQCwjtn0jwZHdKXuu65dc+gaH7qoFXIP9/jTL7Xmkc8qqGah6zY5QwkzYmllqQCQ8nv
 qxVuB5lOZZ243zGZAD4TCC+mNRwozDE1BG5o+FnPx+k9o4/LQeYDEn//OPYHs41he9YPOzojY
 90Wcv9veGVctFFVCWIpGv1I+NXVFM+psFPwrFIie5V8H32GUKuL1A4C99y8LVnGmL/OcVBXaO
 J3lno/p8+ma5DQVHA/u3syk2vOThkzDuPVlh2V7MpiZHgIDh4u4VNzM4wzJfRN6aXTjqJ+3lW
 aIRmD099eDt/fDvex11MwxqqjBmatpxug5DVTjgs9DDx0wujr9F7YaBgDckfCKPL/1rLBhPFo
 I2JOPMYGJL95GLRjM4fnE2uOj3RCAg0T7ueBv6Rt2zMHXYqKiEHB+/f4dO2ipScwwM7MbU8i4
 bfY7nnwl+iv7QWTJpdnAX0VOH2ysB1uBv3766MdzVV0JrlTUoBY3FPEaRkzZhiNAvuXdsHD4t
 C9iRTot2FGphsMYModOYHaTrG8HctbzPaCM4OXfA/MfWcZHXsT4VzLKNnK5kvw3ga9rNqwxR0
 f4j3VHuAPYnaiQy4j5/jP3CPhsxrx3vUojaNCAEL/h9zwVUCYlK6OfXfxEJlFfDoNIMaUPVks
 IShmqkYzYphYWX5a882YE2ZFKPo02u/v0S7HbljQbFS5Ut5kCiGvEysl8tFvAHLSFdaUpJ7+y
 CQYKGG6ugXm0Kr9fk5qKrem+LcN4rqj3srtwlg==
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

