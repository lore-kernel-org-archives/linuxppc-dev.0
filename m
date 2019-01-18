Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9884CC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:38:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A1B420883
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1B420883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43h68Z1Tb8zDr5L
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 03:38:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=212.227.17.13; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h5ls3QGVzDr2g
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 03:20:57 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MMXYH-1gUEfJ1zt9-00JaaK; Fri, 18 Jan 2019 17:19:26 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 08/29] m68k: assign syscall number for seccomp
Date: Fri, 18 Jan 2019 17:18:14 +0100
Message-Id: <20190118161835.2259170-9-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nRQkc5WHlS8oJboXGUt0vN+cwluUfd5b8wUsgIrzs+HYZ+pMf1e
 KlDPG6ImfC4yLsewd6iPI+rxWD///awveawa2T2cRrrteu+vOpqU7x36dzhwukK0qkhKGgi
 6o5FUnfGFritrX0fCrjK9/MfEMxotXN+yj5OkKo2LfCokW619AHEWExMDGl9I51wuC4xFe3
 CUjbSuA8/BCbHi/kqsH9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vBxfFgMxf5I=:aS8fZ2v0hh02AT1dmHdvFW
 lRyqKsurUZ7vVeMKEvTzUDZ8tFvvIkP51ZhaQ+RwNLeOqJEA1iPkl9luZhApypQ++UbQ3xqOa
 lvBreGoiZeF4Ice7paqarLxb2UlxHQCMz7JWmrDJ0B9h8pg5KuC0HqIbURXIWx7cSlHkDjJMP
 qfYls++cG8D1Xf3zo8+GZ+tW2uq0g+3dbOeDCIOBx0H3lGxsCKeg70Nd9SwTJ+HSl1XiqW6nn
 20yiZ0QfaiNkHwgFjRu+PY0rq4GW+K3rBep6m2HG1R51LvvieEN0cY1tKTw1/GaJm2e5PfnkR
 e5lJl3SpZMWIjzy9gROQblKMLJQfT6DAH07f0pwED+nCkZvXLn8FPESrhByXdKmXcOY4UVXSg
 E2JHYWnb2ZsjJsJs+zUdkYaxzwCd9yAYm6wPPQTerjBWnCWQxGjDI19HgvkxcX9DsM6Rirh4+
 esRABApRswGqjRWVQP1ythpoUfLFVdoXiIqofHjVyQOSTpMePzo5xo5aJFQ1px3+0MEOq6a1I
 +zcXXMgIfA2HvbPIsgO7GsePc9iL7v+U1u4KoePnArNvO/GrFdnffdMq12kkc9iwfyf5dnn84
 mxFdRAtGFF1vx1w1+dDhltYwOWJfph4V0BrbdHE7yLlNG1FEZGBHtZx3grnKdewiVh8NnrIlA
 hyjLVPvQuAjts/wBHOIEL0jvVLXD4J+x6G2ZHn/vP6A3+gssJ6CIN+wFiqQwCBjzOnAcbw8Bo
 WLUgq0iHMIFzke7PoXdi63gm9/beQ/Ri3hqeXA==
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

