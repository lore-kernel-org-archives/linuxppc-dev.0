Return-Path: <pebolle@tiscali.nl>
Received: from lb3-smtp-cloud3.xs4all.net (lb3-smtp-cloud3.xs4all.net
 [194.109.24.30])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 131D61A0023
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 22:12:24 +1000 (AEST)
Message-ID: <1438344740.13223.12.camel@tiscali.nl>
Subject: [PATCH] windfarm: make wf_critical_overtemp() static
From: Paul Bolle <pebolle@tiscali.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Fri, 31 Jul 2015 14:12:20 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

wf_critical_overtemp() is exported. But nothing uses that export.
That's unsurprising because there's no header that defines it. Stop
exporting that function and make it static.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Cross compiled only.

(And I really hope evolution didn't mangle this patch.)

 drivers/macintosh/windfarm_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/macintosh/windfarm_core.c b/drivers/macintosh/windfarm_core.c
index cc7ece1712b5..681e5b4d4b6a 100644
--- a/drivers/macintosh/windfarm_core.c
+++ b/drivers/macintosh/windfarm_core.c
@@ -72,7 +72,7 @@ static inline void wf_notify(int event, void *param)
 	blocking_notifier_call_chain(&wf_client_list, event, param);
 }
 
-int wf_critical_overtemp(void)
+static int wf_critical_overtemp(void)
 {
 	static char * critical_overtemp_path = "/sbin/critical_overtemp";
 	char *argv[] = { critical_overtemp_path, NULL };
@@ -84,7 +84,6 @@ int wf_critical_overtemp(void)
 	return call_usermodehelper(critical_overtemp_path,
 				   argv, envp, UMH_WAIT_EXEC);
 }
-EXPORT_SYMBOL_GPL(wf_critical_overtemp);
 
 static int wf_thread_func(void *data)
 {
-- 
2.4.3
