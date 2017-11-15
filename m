Return-Path: <srs0=fjvl=cn=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ycSfd1MgbzDql8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 02:17:29 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3ycSfc6fJ2z8t1V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 02:17:28 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3ycSfc11Shz9s7C
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2017 02:17:27 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAFFFnJM084415
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2017 10:17:26 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e8qxbrr8k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2017 10:17:24 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 15 Nov 2017 15:17:21 -0000
Subject: [PATCH v9 2/8] boot/param: add pointer to current and next argument
 to unknown parameter callback
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 lkml <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Ankit Kumar <ankit@linux.vnet.ibm.com>,
 Michal =?utf-8?b?U3VjaMOhbmVr?= <msuchanek@suse.de>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 15 Nov 2017 20:47:14 +0530
In-Reply-To: <151075897205.14434.9005256552409420263.stgit@hbathini.in.ibm.com>
References: <151075897205.14434.9005256552409420263.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <151075902585.14434.14102853902713018755.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michal Suchanek <msuchanek@suse.de>

Add pointer to current and next argument to make parameter processing
more robust. This can make parameter processing easier and less error
prone in cases where the parameters need to be enforced/ignored based
on firmware/system state.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---

Changes in v9:
* Fixed messages like below observed while loading modules with no parameters.
    - iptable_filter: unknown parameter '' ignored
    - ip_tables: unknown parameter '' ignored


 include/linux/moduleparam.h |    1 +
 init/main.c                 |    8 ++++++--
 kernel/module.c             |    5 +++--
 kernel/params.c             |   18 ++++++++++++------
 lib/dynamic_debug.c         |    1 +
 5 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 1d7140f..50a19e6 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -328,6 +328,7 @@ extern char *parse_args(const char *name,
 		      s16 level_max,
 		      void *arg,
 		      int (*unknown)(char *param, char *val,
+				     char *currant, char *next,
 				     const char *doing, void *arg));
 
 /* Called by module remove. */
diff --git a/init/main.c b/init/main.c
index 3bdd8da..3ba3eed 100644
--- a/init/main.c
+++ b/init/main.c
@@ -241,6 +241,7 @@ early_param("loglevel", loglevel);
 
 /* Change NUL term back to "=", to make "param" the whole string. */
 static int __init repair_env_string(char *param, char *val,
+				    char *unused3, char *unused2,
 				    const char *unused, void *arg)
 {
 	if (val) {
@@ -259,6 +260,7 @@ static int __init repair_env_string(char *param, char *val,
 
 /* Anything after -- gets handed straight to init. */
 static int __init set_init_arg(char *param, char *val,
+			       char *unused3, char *unused2,
 			       const char *unused, void *arg)
 {
 	unsigned int i;
@@ -266,7 +268,7 @@ static int __init set_init_arg(char *param, char *val,
 	if (panic_later)
 		return 0;
 
-	repair_env_string(param, val, unused, NULL);
+	repair_env_string(param, val, unused3, unused2, unused, NULL);
 
 	for (i = 0; argv_init[i]; i++) {
 		if (i == MAX_INIT_ARGS) {
@@ -284,9 +286,10 @@ static int __init set_init_arg(char *param, char *val,
  * unused parameters (modprobe will find them in /proc/cmdline).
  */
 static int __init unknown_bootoption(char *param, char *val,
+				     char *unused3, char *unused2,
 				     const char *unused, void *arg)
 {
-	repair_env_string(param, val, unused, NULL);
+	repair_env_string(param, val, unused3, unused2, unused, NULL);
 
 	/* Handle obsolete-style parameters */
 	if (obsolete_checksetup(param))
@@ -438,6 +441,7 @@ static noinline void __ref rest_init(void)
 
 /* Check for early params. */
 static int __init do_early_param(char *param, char *val,
+				 char *unused3, char *unused2,
 				 const char *unused, void *arg)
 {
 	const struct obs_kernel_param *p;
diff --git a/kernel/module.c b/kernel/module.c
index 32c2cda..ffe7520 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3619,8 +3619,9 @@ static int prepare_coming_module(struct module *mod)
 	return 0;
 }
 
-static int unknown_module_param_cb(char *param, char *val, const char *modname,
-				   void *arg)
+static int unknown_module_param_cb(char *param, char *val,
+				   char *unused, char *unused2,
+				   const char *modname, void *arg)
 {
 	struct module *mod = arg;
 	int ret;
diff --git a/kernel/params.c b/kernel/params.c
index cc9108c..69ff58e 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -119,6 +119,8 @@ static void param_check_unsafe(const struct kernel_param *kp)
 
 static int parse_one(char *param,
 		     char *val,
+		     char *currant,
+		     char *next,
 		     const char *doing,
 		     const struct kernel_param *params,
 		     unsigned num_params,
@@ -126,7 +128,8 @@ static int parse_one(char *param,
 		     s16 max_level,
 		     void *arg,
 		     int (*handle_unknown)(char *param, char *val,
-				     const char *doing, void *arg))
+					   char *currant, char *next,
+					   const char *doing, void *arg))
 {
 	unsigned int i;
 	int err;
@@ -153,7 +156,7 @@ static int parse_one(char *param,
 
 	if (handle_unknown) {
 		pr_debug("doing %s: %s='%s'\n", doing, param, val);
-		return handle_unknown(param, val, doing, arg);
+		return handle_unknown(param, val, currant, next, doing, arg);
 	}
 
 	pr_debug("Unknown argument '%s'\n", param);
@@ -169,9 +172,10 @@ char *parse_args(const char *doing,
 		 s16 max_level,
 		 void *arg,
 		 int (*unknown)(char *param, char *val,
+				char *currant, char *next,
 				const char *doing, void *arg))
 {
-	char *param, *val, *err = NULL;
+	char *param, *val, *next, *err = NULL;
 
 	/* Chew leading spaces */
 	args = skip_spaces(args);
@@ -179,16 +183,18 @@ char *parse_args(const char *doing,
 	if (*args)
 		pr_debug("doing %s, parsing ARGS: '%s'\n", doing, args);
 
-	while (*args) {
+	next = next_arg(args, &param, &val);
+	while (*next) {
 		int ret;
 		int irq_was_disabled;
 
-		args = next_arg(args, &param, &val);
+		args = next;
+		next = next_arg(args, &param, &val);
 		/* Stop at -- */
 		if (!val && strcmp(param, "--") == 0)
 			return err ?: args;
 		irq_was_disabled = irqs_disabled();
-		ret = parse_one(param, val, doing, params, num,
+		ret = parse_one(param, val, args, next, doing, params, num,
 				min_level, max_level, arg, unknown);
 		if (irq_was_disabled && !irqs_disabled())
 			pr_warn("%s: option '%s' enabled irq's!\n",
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index da796e2..dec7f40 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -889,6 +889,7 @@ static int ddebug_dyndbg_param_cb(char *param, char *val,
 
 /* handle both dyndbg and $module.dyndbg params at boot */
 static int ddebug_dyndbg_boot_param_cb(char *param, char *val,
+				char *unused3, char *unused2,
 				const char *unused, void *arg)
 {
 	vpr_info("%s=\"%s\"\n", param, val);
