Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC799C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:30:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F06D20850
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F06D20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43h5yM0znYzDqCY
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 03:30:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=217.72.192.74; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h5ld5gmvzDr1x
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 03:20:45 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N5VPg-1hHoRO3rPm-016smX; Fri, 18 Jan 2019 17:19:21 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 04/29] alpha: wire up io_pgetevents system call
Date: Fri, 18 Jan 2019 17:18:10 +0100
Message-Id: <20190118161835.2259170-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kflSL09LUig5PrGqhrkajxoK0SeWp2U4JIIMcfjCGVSWg5iIrgA
 J5hv9soxVYSFR49SvlQMaZXIAO1p6EUEeltN0pngVIpqcfTLf3sWXn2IBnJQaQLzGZJ3q+Q
 ACD8kJOssOub6MuDS3QPNehTEgd/CCZtDjgODFWU+Gy7sWZ+HJNEkrOPxOfu05RgPwNPDqD
 aoZ6iSR7CX2gKXzv0VMBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CeyxGSCiaRY=:qpuIHbxy3A65/sCKEAE7D3
 ddepm1c6+m4oaC3wmX+/hUYOk+vtmAFnZ6Kd4BzrkF9gMlYL4J6KSefBBWheOLiMOzxEfHcGr
 Rus23XiyxSkQFRafe/srQUUgUIDlP2ZeFaHMw40pc/zl4LWUSZrX2WoDQcgTfj6VtksN/V4Yj
 SJJpsRVSLQp8ey6pe8MYBxW1o3Ega++JZLlMnSDaQHDqYNK+im42pC2RWqjA/sdEhFR8js0a8
 Vd58EZ6ZXTX+niqnqnR0rRlayZMDJUP5TooxbiFskhhE97TltTJcOw4T8sSlsDWdU3pFOEFN2
 TVqzgi0d1Gq4y6eVCU1KwNyzY4q1xFzBNST+Lqc9CfbVdyr3JIMdTGDT2XhxcuVmpGFnBHyNp
 J24nQxFlSbrn3htY51QpZcB2Sg1XdIvAydyRtpeUZQUT+B+/smpxh3V/MNhPfmM+psB3wPlnc
 Rx1IoK/nFb3JbVFKWwxmu5Aal8w06mXFYc5ajI0zj4RLvkX1HLiOifKHsEaAD9iyZ1B/0bHrm
 7A0FbmbqpqfeHa8xppNwFJDhdgMDuaeo44n4OO6mSjxmpMQiJoCgqb9jOSaoIf47Jj8mtlWyL
 lqn2pZFDHLWvq7L10oDp3J1e6pKAQMpvs/913pfWja4VPOxHweNPo6KrPUJLgT3algq6owiZx
 zd+TvvExdx1OitYhrhMXYY+ayhXjg6hRKsMKsa1pHOMeIRxDBz3Bucx6iiIZwIBncfLKSdpzN
 WcHZC4slp6nRdjtDeg1mVNWkkyuERWfVPiWJag==
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
 netdev@vger.kernel.org, linux-mips@vger.kernel.org, stable@vger.kernel.org,
 paul.burton@mips.com, ebiederm@xmission.com, linux-alpha@vger.kernel.org,
 schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The io_pgetevents system call was added in linux-4.18 but has
no entry for alpha:

warning: #warning syscall io_pgetevents not implemented [-Wcpp]

Assign a the next system call number here.

Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/kernel/syscalls/syscall.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 7b56a53be5e3..e09558edae73 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -451,3 +451,4 @@
 520	common	preadv2				sys_preadv2
 521	common	pwritev2			sys_pwritev2
 522	common	statx				sys_statx
+523	common	io_pgetevents			sys_io_pgetevents
-- 
2.20.0

