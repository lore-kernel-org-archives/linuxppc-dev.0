Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCC6C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 16:35:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70621206B7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 16:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70621206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bBSF1MvqzDqmR
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 03:35:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=217.72.192.73; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bBG20zpxzDqHR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 03:26:33 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mlf8e-1h7aDx3tBq-00ik97; Thu, 10 Jan 2019 17:25:16 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] m68k: assign syscall number for seccomp
Date: Thu, 10 Jan 2019 17:24:28 +0100
Message-Id: <20190110162435.309262-9-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cAxqL4Pr32LfUICErQXLweOdeKXEeQmVpfR3EH9HEknl3Rx7o7E
 3gUWhnJXo/Ubf1H9GjN7gL/hmeHLUh13G8skhoZVYIlxTGcXEAJWfHMK5fqwDp3C4mE6U0X
 qU5L8eRnhl276oNgVKUTHhKQsmD41xIQYhIiHkfU/+doRmo4DFVRig7b6U0yHHq8by33NdZ
 hcAmBJVorlGuA9B3ZJvMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bDCus6IHYZs=:59ePj81cYO3U2E3eiWHh1M
 sBYu+VjNywqUwFg/ihKW68e09BYM+B9wyJRztaakMTQXqRhqdEmvZ1ojdiFn0PboHSl1sg6Jz
 lktVPIRNjSHV++3RcDapX5ekI8ig/J0IvxH1f4+g6djzOk81uQeI5fVOD5R8OO0yszdfBId8u
 bb2KyOJqmuC0e+cXrMswmdkk/j+BBIteI5Mmb3mP+1uYhOF+TfOtsnOry98sXfwt5ZUPA9G11
 6Bq2Pyf8idFvfkqnomphG6qXjz59WU2R1Q9Rx7kZwVitLUrtIW2RRr7yq1n7ODZWZGQ2z8AoO
 z24C7F3FN6OHu0pcfqceGVVVuzVusmsWJwQG+I6qPtgtEzJ98nxKoDWen8bapo4VdUefswZ8o
 6W9+k1MDORiZpzr2jtSy9Ndat8iO6D+3zwTqbLUBoNqQtCgrmkHlAGhalt1LHHGyNhOW148bV
 PpMR+nZk7cIlmB54DRwSnuFmOUO6LDwN1o+g/il93UIM6NlbxyI/DWUKjWVYBGVdQ3s6Ic1Zf
 0vSKAXuuihlQy5+pZqwaU8DXbOPv4HafkS3SIDPs2yD4d38mWQptPnqKD/bHDpvp4VJ5b/kNU
 aQ+nkmqzQ/IA01YkCZdy/qpBVvRyBS9YoP7Bz5rdcT7rE/Pq4hpkFgqLOPRpxbuJBNTSr2VaF
 icl78Ty7oQCbEHsFAET4OGF8IzhdbEX4J989KHwG97wdV3IRjqDo/uOxwU7z25q/vFvVzTku/
 IOt8wsJUD0b10sFcR6in2Nc/TFY9E3NMoaCyBQ==
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

Most architectures have assigned a numbers for the seccomp syscall
even when they do not implement it.

m68k is an exception here, so for consistency lets add the number.
Unless CONFIG_SECCOMP is implemented, the system call just
returns -ENOSYS.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/kernel/syscalls/syscall.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 1a95c4a1bc0d..85779d6ef935 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -387,3 +387,4 @@
 377	common	preadv2				sys_preadv2
 378	common	pwritev2			sys_pwritev2
 379	common	statx				sys_statx
+380	common	seccomp				sys_seccomp
-- 
2.20.0

