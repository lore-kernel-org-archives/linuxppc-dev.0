Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xs8gv3mVczDrFJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 02:02:19 +1000 (AEST)
From: Michal Suchanek <msuchanek@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>,
 Rusty Russell <rusty@rustcorp.com.au>, Jason Baron <jbaron@akamai.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.de>, Daniel Axtens <dja@axtens.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Neuling <mikey@neuling.org>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 "Sylvain 'ythier' Hitier" <sylvain.hitier@gmail.com>,
 David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Steven Rostedt," <rostedt@goodmis.org>, Michal Hocko <mhocko@suse.com>,
 Laura Abbott <lauraa@codeaurora.org>, Tejun Heo <tj@kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Lokesh Vutla <lokeshvutla@ti.com>,
 Baoquan He <bhe@redhat.com>, Ilya Matveychikov <matvejchikov@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v8 5/6] boot/param: add pointer to current and next argument
 to unknown parameter callback
Date: Tue, 12 Sep 2017 18:01:43 +0200
Message-Id: <bcee14a3a9415569a554b200144c54f3ced5d0f3.1505231820.git.msuchanek@suse.de>
In-Reply-To: <ee9b1eefc4057e45c5c8ec56c10513a21802543b.1505231820.git.msuchanek@suse.de>
References: <ee9b1eefc4057e45c5c8ec56c10513a21802543b.1505231820.git.msuchanek@suse.de>
In-Reply-To: <ee9b1eefc4057e45c5c8ec56c10513a21802543b.1505231820.git.msuchanek@suse.de>
References: <ee9b1eefc4057e45c5c8ec56c10513a21802543b.1505231820.git.msuchanek@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The fadump parameter processing re-does the logic of next_arg quote
stripping to determine where the argument ends. Pass pointer to the
current and next argument instead to make this more robust.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
rebase on master
split off changes to fadump.c
add pointer to current argument to detect shortening of the parameterer name
---
 arch/powerpc/kernel/fadump.c |  1 +
 include/linux/moduleparam.h  |  1 +
 init/main.c                  |  8 ++++++--
 kernel/module.c              |  5 +++--
 kernel/params.c              | 20 +++++++++++++-------
 lib/dynamic_debug.c          |  1 +
 6 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index b214c1e333dd..8778e1cc0380 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -541,6 +541,7 @@ static void __init fadump_update_params(struct param_info *param_info,
  * to enforce the parameters passed through it
  */
 static int __init fadump_rework_cmdline_params(char *param, char *val,
+					       char *currant, char *next,
 					       const char *unused, void *arg)
 {
 	struct param_info *param_info = (struct param_info *)arg;
diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 1ee7b30dafec..e86f3f830a7f 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -327,6 +327,7 @@ extern char *parse_args(const char *name,
 		      s16 level_max,
 		      void *arg,
 		      int (*unknown)(char *param, char *val,
+				     char *currant, char *next,
 				     const char *doing, void *arg));
 
 /* Called by module remove. */
diff --git a/init/main.c b/init/main.c
index 0ee9c6866ada..9381aa24bca7 100644
--- a/init/main.c
+++ b/init/main.c
@@ -240,6 +240,7 @@ early_param("loglevel", loglevel);
 
 /* Change NUL term back to "=", to make "param" the whole string. */
 static int __init repair_env_string(char *param, char *val,
+				    char *unused3, char *unused2,
 				    const char *unused, void *arg)
 {
 	if (val) {
@@ -258,6 +259,7 @@ static int __init repair_env_string(char *param, char *val,
 
 /* Anything after -- gets handed straight to init. */
 static int __init set_init_arg(char *param, char *val,
+			       char *unused3, char *unused2,
 			       const char *unused, void *arg)
 {
 	unsigned int i;
@@ -265,7 +267,7 @@ static int __init set_init_arg(char *param, char *val,
 	if (panic_later)
 		return 0;
 
-	repair_env_string(param, val, unused, NULL);
+	repair_env_string(param, val, unused3, unused2, unused, NULL);
 
 	for (i = 0; argv_init[i]; i++) {
 		if (i == MAX_INIT_ARGS) {
@@ -283,9 +285,10 @@ static int __init set_init_arg(char *param, char *val,
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
@@ -437,6 +440,7 @@ static noinline void __ref rest_init(void)
 
 /* Check for early params. */
 static int __init do_early_param(char *param, char *val,
+				 char *unused3, char *unused2,
 				 const char *unused, void *arg)
 {
 	const struct obs_kernel_param *p;
diff --git a/kernel/module.c b/kernel/module.c
index 40f983cbea81..0f74718f8934 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3609,8 +3609,9 @@ static int prepare_coming_module(struct module *mod)
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
index 60b2d8101355..c0e0c65f460b 100644
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
+	do {
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
@@ -211,7 +217,7 @@ char *parse_args(const char *doing,
 		}
 
 		err = ERR_PTR(ret);
-	}
+	} while (*next);
 
 	return err;
 }
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index da796e2dc4f5..dec7f40c3f47 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -889,6 +889,7 @@ static int ddebug_dyndbg_param_cb(char *param, char *val,
 
 /* handle both dyndbg and $module.dyndbg params at boot */
 static int ddebug_dyndbg_boot_param_cb(char *param, char *val,
+				char *unused3, char *unused2,
 				const char *unused, void *arg)
 {
 	vpr_info("%s=\"%s\"\n", param, val);
-- 
2.10.2
