Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CC2C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:43:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5141020823
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5141020823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43h6Fr3C1YzDr61
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 03:43:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=217.72.192.73; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h5m407cxzDr1g
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 03:21:07 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M4s8v-1glu2i4Ab9-0023hU; Fri, 18 Jan 2019 17:19:36 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 15/29] alpha: add standard statfs64/fstatfs64 syscalls
Date: Fri, 18 Jan 2019 17:18:21 +0100
Message-Id: <20190118161835.2259170-16-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rSakGMBaEBbAtQUcV3qv3NM7i+OWluASRZee787Xpo3/o23caVn
 QWs5OY5vh9opxy1/zCZ9LY9N9pIJScThNKTMUOE8nA6un262wDIq2Fjhg5yIiWEmn82x0g9
 8p3VeDjI0Rm19xjqPj0Z3FbT5slvuvHZtcUqZPj+gSCMB48TPbdYEEw4VLMKLx07SalqB3b
 h3OVH5LxVZJKnyB7bc21Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lg2Zcst79FI=:RjM/7u0hFuGHZ2BRfjTPMD
 8fbJ1Oqm5cIPC9GeaHvhUwxiy6Kjrm/A90avnT4gPYEGG3drhLEmcVMffAdNdtsLTT2kOQu/9
 9U1iqxCzfMtamHuo+Lvykvje1o1aTsd2rp+F0IR9Sf+vhzfs3Ry1952VDFu0nPS2jVP/yso/5
 /zohi1guOX5+PufGw5W40eWBbQtN7cydGZxEf3WMCnZ1zcVlXCx6sY9+1Rjbyvf1+k0f18R8K
 T2QJYu7012AdY16U6LfPR/21li2ADSjVByZ8E43b8tHba6P1U7dW1+DOogZ+wfBjkG0FW+22+
 hK/j1NbUyVDgs/0sAib43CUyRFQovnEdIJiz9ogsL8XY5ptvCVdCiXlgq8U4xBKgcba8zQ2zK
 zP7aq+pVaAWVNpRw9ucrV0CNZqVVkj6exO56AwQ7TSrWLv2er5omNVTKolhgh+K3vCud/MP3k
 QFUAdqHPpxJFDVWW0QclTKKiM+AqrHzrkW5L2rYyv0TKN+BltH3vLxKleH3bq4UKU3V9M54VY
 149cHyT5F0DL6qHinYu9NHirim1imOhLAhDnmiVl43A3WqSlfS3sTrd2jeYunrJrgAn5huc69
 rDrSDi5snBC3J6gkHsCqMxkqovxLuN0yASzWROjAAglW0rMvI5oSBu5kz+U6ziG7P0chho9G4
 NVjYAQ/GPHW1EJskkpatgeukn2lCfJ97qsSET1mX9q1QVgyHAWcBLswP9TPLd0jQA+/DMuOon
 r0AZp67Be14b8gSfAB9zm3btQOHXBPlWLDZnkQ==
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

As Joseph Myers points out, alpha has never had a standard statfs64
interface and instead returns only 32-bit numbers here.

While there is an old osf_statfs64 system call that returns additional
data, this has some other quirks and does not get used in glibc.

I considered making the stat64 structure layout compatible with
with the one used by the kernel on most other 64 bit architecture that
implement it (ia64, parisc, powerpc, and sparc), but in the end
decided to stay with the one that was traditionally defined in
the alpha headers but not used, since this is also what glibc
exposes to user space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/kernel/syscalls/syscall.tbl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 25b4a7e76943..0ebd59fdcb8b 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -456,3 +456,5 @@
 525	common	pkey_free			sys_pkey_free
 526	common	pkey_mprotect			sys_pkey_mprotect
 527	common	rseq				sys_rseq
+528	common	statfs64			sys_statfs64
+529	common	fstatfs64			sys_fstatfs64
-- 
2.20.0

