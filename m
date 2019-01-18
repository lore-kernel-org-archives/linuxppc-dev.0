Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEC7C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:35:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 451A620850
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451A620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43h64m1qCxzDr3B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 03:35:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=217.72.192.74; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h5lk4dQQzDr1q
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 03:20:50 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mzz6m-1h7x482Ucw-00x1wT; Fri, 18 Jan 2019 17:19:30 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 11/29] sparc64: fix sparc_ipc type conversion
Date: Fri, 18 Jan 2019 17:18:17 +0100
Message-Id: <20190118161835.2259170-12-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:E0WLVEaCcQzfD09xtrq4A5jWMomm7adRfer83EpRAVfp369asuy
 x3/FJ1daGxLmHv7isfyBmmw9CiTpRNTIZF5Gr3d8LXmER0Y68fJAFAfjaBn0f4G0BGnMaQx
 x2SRX/iEk+wXVeqe10GMRlxV+Tfz1UGHqVsgCFYxSmbS+xtCO7zPPuk3cos5G9lUpWYPzzZ
 Cd+cyB2Mh1kEIhZmabg+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U8fLlZM0o6k=:bhl6IpqDxoJ6kbMGE/L2Hc
 CzXueO2oa5jGlTL6WLnsLYPOBF2mZVhxD5AP4llrcKg4Do2nFrxENghqjFTLAbPL1QsxZXc/b
 LnpyH8IuA+uVRH8S8x50ONY5YeJxq+2QhNxaH/wLHtFKi7z8USTpeeVUZCXlul0nja0gF6rOO
 LL1USYrfYH8u14o6qjYuV81dwO272SuobC89RmEf5pmmulouyOUgkcp/shSJww4iWgefqz74u
 6U7B4Y+732hH50WeHW+jmK2UZNpQy29Zjoe2j/U7CTNx8BE+Gkr54u55/Lh2JunMk9s/og4TR
 dsMViyBx2kjJjkgEqxuWmHUTNlQu51BtfQLyRTAWbgOz01AACB59xRs8hgCJSfM1qdrhWxkWx
 b7Mf3ttpjFoH/yCzfhmqtBVJbePhcOvcZVDbx2TI+CZIobvf1sZQslNdYpNtm1VH178fbI+5B
 Ec2CtgMHKExKURICO74Kg//YVBx8XEU6LSNaZh7pucWUly+BVsVaNCdnU6hItAL/BM4GqJnT+
 w0oS45C/vBaPsuwz0142f3Y/62Xkn18OPu9YZUSlAzq7LM9Pe/9K5fmgYrLaC9FSDljZuydmq
 jykoWGCnNNUhJI5AYsoroGoYkVnN9Ec9lvj5OEb2n9u0Buc9VIYHXAq6knDPefHHxymWenmkD
 roYvKjwcBwNJpHKmEGmj7QZzsVbJDYDPSFwoNNBDl7fi9IWX3nVa1iRT0iAn7dyxgKUgZltdI
 hQ4oQT3HJwHWivAfkNceN5wG99AQRLWvlYiWXw==
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

__kernel_timespec and timespec are currently the same type, but once
they are different, the type cast has to be changed here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/kernel/sys_sparc_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 274ed0b9b3e0..1c079e7bab09 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -344,7 +344,7 @@ SYSCALL_DEFINE6(sparc_ipc, unsigned int, call, int, first, unsigned long, second
 			goto out;
 		case SEMTIMEDOP:
 			err = sys_semtimedop(first, ptr, (unsigned int)second,
-				(const struct timespec __user *)
+				(const struct __kernel_timespec __user *)
 					     (unsigned long) fifth);
 			goto out;
 		case SEMGET:
-- 
2.20.0

