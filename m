Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1937C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 17:04:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C39B2086D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 17:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C39B2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43h6jV5NW1zDr5s
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 04:03:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=217.72.192.73; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h5n30HxxzDr2y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 03:21:58 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Macay-1hMKfG0Vje-00cCjZ; Fri, 18 Jan 2019 17:19:48 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 24/29] x86/x32: use time64 versions of sigtimedwait and
 recvmmsg
Date: Fri, 18 Jan 2019 17:18:30 +0100
Message-Id: <20190118161835.2259170-25-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bjQ71ntGniqBqrHuJ7nhcM56lXeeQkbnuYFrI+Mn+AONKiu8hm3
 ZfdgXFhiGNnHO//AoluNzCeO0kL22YQqbQi2edF+nGFhQKlnAM/wFiwMct2rm/oTbQw/dfG
 NW0sAWRGPprfVUER8dgBX8W4nNi71voW7ClXKpr6DLa2bdedfAUlZPkAvfVw5mQVYt4bn+U
 9SZ+sG+tOw97WshAsE8Lw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f7vyNs/hjFE=:E5JYxrKYfXSvspqvYDThi2
 zRdSFKHKhBC95XRLLIotBJDFxRWr8YE9hRuVm5cixnR2Fat15uciTsUrb3Nee+8V/9jkdsp7S
 7WQMM6z4Rx8tQmY/ttpZhsD/obv2S33VJQhYwjv8ByKaOYStUY1Y9Caq1E6j8nODtLwNPc+AO
 MYhQEB5zgWu/X+w7nncFL2M+sWivBIQgy2ZHTbQYaUvsaBNUBb3znK61r6tod2EiA1Xq8ZtNx
 7trJlzqoshtQNs+l4LuQRLbI9vW0d0dyGGaiOHosMtJZhdeq6RRD8lc4zL2wgZ9/ly5GiNwpk
 AMoTJv2+3lrX7qJRkmPRvAVO6DQcibJPGHlmcXioT/AaRWC5ZIbDBDePtYofOW7vFfoqCyNOQ
 072BSrqwXTzKiU5zn+zO2AI0UL9lPLChurlNcEiH0C+VvNgvI4CHjkDe//ntGe27GCCnH1Dr6
 M4yjGrMJu+6aeFMcJo4w1UQHuEk+tkPXVC5exxExIV2SGo7/uArDS6u7ynjcFwosWZnfhzJJg
 bu861G0bv4iR2J8ABEMMvocoGN1fdydxMJvzB+vPbuRYBvmajg4bWH3Vesl9pCNRLGcb5Dl4M
 TICdFyVBNbKDvw0KF+9aOvpQDltHGoXNTnsHKd1AMNWQkP0W4NSJ242NO6hZzGvKuC3YniV8g
 Bptn5bsjlGFQqXFY2de7WXKnd6mrxFJcDg7t5q+EChvral9mavvP3PSWDyFO8CPtHHMIarTDn
 UBFzp4GLcnISS7CrL8RcfhB+mANlkmqu671lFQ==
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

x32 has always followed the time64 calling conventions of these
syscalls, which required a special hack in compat_get_timespec
aka get_old_timespec32 to continue working.

Since we now have the time64 syscalls, use those explicitly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/entry/syscalls/syscall_64.tbl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f0b1709a5ffb..43a622aec07e 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -361,7 +361,7 @@
 520	x32	execve			__x32_compat_sys_execve/ptregs
 521	x32	ptrace			__x32_compat_sys_ptrace
 522	x32	rt_sigpending		__x32_compat_sys_rt_sigpending
-523	x32	rt_sigtimedwait		__x32_compat_sys_rt_sigtimedwait
+523	x32	rt_sigtimedwait		__x32_compat_sys_rt_sigtimedwait_time64
 524	x32	rt_sigqueueinfo		__x32_compat_sys_rt_sigqueueinfo
 525	x32	sigaltstack		__x32_compat_sys_sigaltstack
 526	x32	timer_create		__x32_compat_sys_timer_create
@@ -375,7 +375,7 @@
 534	x32	preadv			__x32_compat_sys_preadv64
 535	x32	pwritev			__x32_compat_sys_pwritev64
 536	x32	rt_tgsigqueueinfo	__x32_compat_sys_rt_tgsigqueueinfo
-537	x32	recvmmsg		__x32_compat_sys_recvmmsg
+537	x32	recvmmsg		__x32_compat_sys_recvmmsg_time64
 538	x32	sendmmsg		__x32_compat_sys_sendmmsg
 539	x32	process_vm_readv	__x32_compat_sys_process_vm_readv
 540	x32	process_vm_writev	__x32_compat_sys_process_vm_writev
-- 
2.20.0

