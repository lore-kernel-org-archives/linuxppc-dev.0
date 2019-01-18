Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBACC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:24:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E299E20883
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E299E20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43h5qN1RzJzDr3D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 03:24:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=212.227.17.13; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h5ld1d8PzDr1g
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 03:20:44 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N4i3d-1hC3o90g59-011gmK; Fri, 18 Jan 2019 17:19:18 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 02/29] ia64: add statx and io_pgetevents syscalls
Date: Fri, 18 Jan 2019 17:18:08 +0100
Message-Id: <20190118161835.2259170-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iIDCS1VFnyKTHSdfnANmJaXoeSIZjJNeoIeNpmRgK3i74OpuB4O
 eJR7+B640nWU7cI5HbePKVHdmMw6Q9RnL4odwsk7keaOXE1tspGbmTjF+YVFfrsjlCz+8Pk
 c6LKkZNxB5SmFLtBapr7yXQckqoFa5ZTM5Ot72QtiDtCW3tiyH5ohmtPxlTlupzyYoxAsvM
 0njQaJNBq+N6Kmwm2u2RA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QhW8nqZCixw=:FEDmad82yIffa62QsVqnWE
 uz1Wrim1T8l4l2nNLg7tI/QVN0sQNBVXDYm/NnsKLv7zs8LehTf6t5+qBRKo/0rh35CYACfnh
 HyaRp8O9EjgYHn8q5sfTDpNC1EA1qlL2VgJV7uFhKZ42rkCb/kvXDCLTj6e4eLqMiLLHwkYgA
 tg/kcev5qJ7IM9ob7D3yzCAq8ni94r1+4puI+m2IXISBpGYQAycFdcpnkAdl25Fp/ndfEZBg4
 YXNQwxFdDSigpL4BqDznMEklcUn0WDgyBJuTIe9s/D6zDgeIZoI7nU3riAsN/dWuWcnbkNnyz
 IId+DwROqDXieCnpGuBiZvOiLBS+urH6rgeCYekmDL8q7krWCyjHp4rvWFx7xcHD1o2VXsGot
 1a/8zGhBF+fqq58MrSp3TEn+6DOva3zIrSvk4tNapXtZZZprR8T75kOgPOvix1rgRrHk4ck8Q
 XG9VJB2f13nJVdtAIWsqENy/zAmWNP8RmLku761b6Sj8zHabwSrP59tSyG90YiRFFrAcrZcBy
 KgsrDJFq33B6rFnPLS6k8KrAwUkLaKXZp2tEwUEl7UxeFy3EamT5ORoeoTGvhxuO3ffTTWGuB
 YHr09kc6nvgYBKaTNvTlODeNk5KwBw66kFtJmW65s3rJj0voBCtwT73q7zm1gdOPRYk7r4ur3
 pOK6QqhYKoWR7gOjVF2r0tazZFTLqGupgU0ddYnvBi9U45R/Ja3Ea+uhLN5Vzw87BFZJr0JNI
 ctK94+FmLls+QETWW952oM3gGqZ4wEKj7crFiQ==
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

All architectures should implement these two, so assign numbers
and hook them up on ia64.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/kernel/syscalls/syscall.tbl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index e97caf51be42..52585281205b 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -335,3 +335,5 @@
 323	common	copy_file_range			sys_copy_file_range
 324	common	preadv2				sys_preadv2
 325	common	pwritev2			sys_pwritev2
+326	common	statx				sys_statx
+327	common	io_pgetevents			sys_io_pgetevents
-- 
2.20.0

