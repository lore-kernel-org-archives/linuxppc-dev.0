Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F01BC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 16:50:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC668206B7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 16:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC668206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bBn25qyVzDqm9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 03:49:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=212.227.17.24; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
X-Greylist: delayed 379 seconds by postgrey-1.36 at bilbo;
 Fri, 11 Jan 2019 03:32:50 AEDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bBPG3clyzDqmK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 03:32:50 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MXGzQ-1gmTTU2Mc2-00YlJB; Thu, 10 Jan 2019 17:25:10 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] alpha: wire up io_pgetevents system call
Date: Thu, 10 Jan 2019 17:24:24 +0100
Message-Id: <20190110162435.309262-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IuTdScJNFP/vlVpLiekPy1ow4ZHjUHd9bBQuCDC76YNBRibrohQ
 xe4PTU5B3/2nsf++H4PdApUdmfw+lrf+m4akyCZLHyYTCLErcx0kRCUeA5fx2pSYrXhfboI
 TGcpRPLubhe7ITv+g8HM3hG2m2F8x+f0mihrQflNCCgZKTCoOQI1SPWgWNjeYt2eQffohnL
 2+S4SOm3O/NYGRyHFCqnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U3iesWYZzys=:EPUggX3Twse/mW3ahVv4R3
 asD21t9mRLc+daKohkB4tbHkQwvD0fzsyTP4uLqikQ8OCxTsXjAvIUHwY98rgkTgOOa8/IBTg
 6vb9Ct/TcEEd2Gx2i0fPjSMFCgNpQuBhQrOyya/NgKp50ePz0/lq6i9wPGabWtMgCkL1xtGhu
 paOH2rBF8zZJnpezo/Yp3qCamOUC5DKvdLqV5pCUn4ATE4zRovY/YAFKJAkOVT5d7jzGYosvo
 UP7AuGuQCfuNXfyOA6TFSRAbopDZ+UaiD6qcYLJiSk6nOq2ZS8DppcOlMra0PV+FzoxJE2nbi
 suhmFSwWwHd8qPWRqEClc+M9A8gJ/x10gD0U0cODMPNK7Ku6vsKMVn/BFFDsQhmqGUJjbaMZW
 oWod3Gz61CUXy5PxFqgqZAeu8WmRrbt0RwE/n9bXzVsU09D2n4iXepbg6zwURy24dllMog3QD
 a05otXDpbP0EaiK3mdhpqw+afs9cNm8vAfutL2thPU5VlV6AaJulKfpoA+f+4LAFx49OTPN02
 lO8mTn1v29GPPmNxRUguOu74rx2TlXt2G8sA/yDcMb1VK/7l1HeKJTmByeamyJ/7TVcxRnoma
 TdgN9Uay7TBlTWae906J80XekhAiQdv1LgsaoEkr+MuRPrpQJeTgvpjxHWAnsQ9My1mA2lfgE
 uGDP/bG6Kv2Gf7IOWdh7t6v0Q4SCBS/aJHupibeZTF+YmJJpgkL+H3NLes5n8vr7QDSJk29zO
 5pu276Osc6RSqQowYrcTHCqglYGV5xwcY5TS4A==
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
 stable@vger.kernel.org, paul.burton@mips.com, ebiederm@xmission.com,
 linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org,
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

