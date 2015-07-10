Return-Path: <hidehiro.kawai.ez@hitachi.com>
Received: from mailx.hitachi.co.jp (fallback.hitachi.co.jp [133.145.228.49])
 by lists.ozlabs.org (Postfix) with ESMTP id 4CAF71A0DCE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 22:17:53 +1000 (AEST)
Received: from mail7.hitachi.co.jp (mail7.hitachi.co.jp [133.145.228.42])
 by mailx.hitachi.co.jp (Postfix) with ESMTP id 00FF52168087
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 20:39:56 +0900 (JST)
Subject: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump is
 not available
To: Andrew Morton <akpm@linux-foundation.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Vivek Goyal <vgoyal@redhat.com>
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>,
 linux-sh@vger.kernel.org, linux-s390@vger.kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>,
 HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 Daniel Walker <dwalker@fifo99.com>, linuxppc-dev@lists.ozlabs.org,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Fri, 10 Jul 2015 20:33:31 +0900
Message-ID: <20150710113331.4368.63745.stgit@softrs>
In-Reply-To: <20150710113331.4368.10495.stgit@softrs>
References: <20150710113331.4368.10495.stgit@softrs>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

You can call panic notifiers and kmsg dumpers before kdump by
specifying "crash_kexec_post_notifiers" as a boot parameter.
However, it doesn't make sense if kdump is not available.  In that
case, disable "crash_kexec_post_notifiers" boot parameter so that
you can't change the value of the parameter.

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
---
 kernel/panic.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 04e91ff..5252331 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -502,12 +502,14 @@ __visible void __stack_chk_fail(void)
 core_param(pause_on_oops, pause_on_oops, int, 0644);
 core_param(panic_on_warn, panic_on_warn, int, 0644);
 
+#ifdef CONFIG_CRASH_DUMP
 static int __init setup_crash_kexec_post_notifiers(char *s)
 {
 	crash_kexec_post_notifiers = true;
 	return 0;
 }
 early_param("crash_kexec_post_notifiers", setup_crash_kexec_post_notifiers);
+#endif
 
 static int __init oops_setup(char *s)
 {
