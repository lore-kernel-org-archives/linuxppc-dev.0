Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYHWl1mFYzDrJ7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 06:15:15 +1000 (AEST)
From: Michal Suchanek <msuchanek@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>,
 Rusty Russell <rusty@rustcorp.com.au>, Jason Baron <jbaron@akamai.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Andrew Morton <akpm@linux-foundation.org>,
 Michal Suchanek <msuchanek@suse.de>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Neuling <mikey@neuling.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Scott Wood <oss@buserror.net>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 David Howells <dhowells@redhat.com>,
 "Sylvain 'ythier' Hitier" <sylvain.hitier@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: "Steven Rostedt," <rostedt@goodmis.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Tejun Heo <tj@kernel.org>,
 Lokesh Vutla <lokeshvutla@ti.com>, Baoquan He <bhe@redhat.com>,
 Ilya Matveychikov <matvejchikov@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/4] boot/param: add pointer to next argument to unknown
 parameter callback
Date: Thu, 17 Aug 2017 22:14:31 +0200
Message-Id: <6378df7aed5bb23863d7762d7dc2babdd5e32a45.1503000577.git.msuchanek@suse.de>
In-Reply-To: <78655b3689f6cd0c76b787b8ef2c824ef75a99a5.1503000577.git.msuchanek@suse.de>
References: <78655b3689f6cd0c76b787b8ef2c824ef75a99a5.1503000577.git.msuchanek@suse.de>
In-Reply-To: <78655b3689f6cd0c76b787b8ef2c824ef75a99a5.1503000577.git.msuchanek@suse.de>
References: <78655b3689f6cd0c76b787b8ef2c824ef75a99a5.1503000577.git.msuchanek@suse.de>
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
next argument instead to make this more robust.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/fadump.c  | 13 +++++--------
 arch/powerpc/mm/hugetlbpage.c |  4 ++--
 include/linux/moduleparam.h   |  2 +-
 init/main.c                   | 12 ++++++------
 kernel/module.c               |  4 ++--
 kernel/params.c               | 19 +++++++++++--------
 lib/dynamic_debug.c           |  2 +-
 7 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index d7da4ce9f7ae..6ef96711ee9a 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -474,13 +474,14 @@ struct param_info {
 };
 
 static void __init fadump_update_params(struct param_info *param_info,
-					char *param, char *val)
+					char *param, char *val, char *next)
 {
 	ptrdiff_t param_offset = param - param_info->tmp_cmdline;
 	size_t vallen = val ? strlen(val) : 0;
 	char *tgt = param_info->cmdline + param_offset +
 		FADUMP_EXTRA_ARGS_LEN - param_info->shortening;
-	int shortening = 0;
+	int shortening = ((next - 1) - (param))
+		- (FADUMP_EXTRA_ARGS_LEN + 1 + vallen);
 
 	if (!val)
 		return;
@@ -488,10 +489,6 @@ static void __init fadump_update_params(struct param_info *param_info,
 	/* remove '=' */
 	*tgt++ = ' ';
 
-	/* next_arg removes one leading and one trailing '"' */
-	if ((*tgt == '"') && (*(tgt + vallen + shortening) == '"'))
-		shortening += 2;
-
 	/* remove one leading and one trailing quote if both are present */
 	if ((val[0] == '"') && (val[vallen - 1] == '"')) {
 		shortening += 2;
@@ -517,7 +514,7 @@ static void __init fadump_update_params(struct param_info *param_info,
  * to enforce the parameters passed through it
  */
 static int __init fadump_rework_cmdline_params(char *param, char *val,
-					       const char *unused, void *arg)
+				char *next, const char *unused, void *arg)
 {
 	struct param_info *param_info = (struct param_info *)arg;
 
@@ -525,7 +522,7 @@ static int __init fadump_rework_cmdline_params(char *param, char *val,
 		     strlen(FADUMP_EXTRA_ARGS_PARAM) - 1))
 		return 0;
 
-	fadump_update_params(param_info, param, val);
+	fadump_update_params(param_info, param, val, next);
 
 	return 0;
 }
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index e1bf5ca397fe..3a4cce552906 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -268,8 +268,8 @@ int alloc_bootmem_huge_page(struct hstate *hstate)
 
 unsigned long gpage_npages[MMU_PAGE_COUNT];
 
-static int __init do_gpage_early_setup(char *param, char *val,
-				       const char *unused, void *arg)
+static int __init do_gpage_early_setup(char *param, char *val, char *unused1,
+				       const char *unused2, void *arg)
 {
 	static phys_addr_t size;
 	unsigned long npages;
diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 1ee7b30dafec..fec05a186c08 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -326,7 +326,7 @@ extern char *parse_args(const char *name,
 		      s16 level_min,
 		      s16 level_max,
 		      void *arg,
-		      int (*unknown)(char *param, char *val,
+		      int (*unknown)(char *param, char *val, char *next,
 				     const char *doing, void *arg));
 
 /* Called by module remove. */
diff --git a/init/main.c b/init/main.c
index 052481fbe363..920c3564b2f0 100644
--- a/init/main.c
+++ b/init/main.c
@@ -239,7 +239,7 @@ static int __init loglevel(char *str)
 early_param("loglevel", loglevel);
 
 /* Change NUL term back to "=", to make "param" the whole string. */
-static int __init repair_env_string(char *param, char *val,
+static int __init repair_env_string(char *param, char *val, char *unused2,
 				    const char *unused, void *arg)
 {
 	if (val) {
@@ -257,7 +257,7 @@ static int __init repair_env_string(char *param, char *val,
 }
 
 /* Anything after -- gets handed straight to init. */
-static int __init set_init_arg(char *param, char *val,
+static int __init set_init_arg(char *param, char *val, char *unused2,
 			       const char *unused, void *arg)
 {
 	unsigned int i;
@@ -265,7 +265,7 @@ static int __init set_init_arg(char *param, char *val,
 	if (panic_later)
 		return 0;
 
-	repair_env_string(param, val, unused, NULL);
+	repair_env_string(param, val, unused2, unused, NULL);
 
 	for (i = 0; argv_init[i]; i++) {
 		if (i == MAX_INIT_ARGS) {
@@ -282,10 +282,10 @@ static int __init set_init_arg(char *param, char *val,
  * Unknown boot options get handed to init, unless they look like
  * unused parameters (modprobe will find them in /proc/cmdline).
  */
-static int __init unknown_bootoption(char *param, char *val,
+static int __init unknown_bootoption(char *param, char *val, char *unused2,
 				     const char *unused, void *arg)
 {
-	repair_env_string(param, val, unused, NULL);
+	repair_env_string(param, val, unused2, unused, NULL);
 
 	/* Handle obsolete-style parameters */
 	if (obsolete_checksetup(param))
@@ -437,7 +437,7 @@ static noinline void __ref rest_init(void)
 }
 
 /* Check for early params. */
-static int __init do_early_param(char *param, char *val,
+static int __init do_early_param(char *param, char *val, char *unused2,
 				 const char *unused, void *arg)
 {
 	const struct obs_kernel_param *p;
diff --git a/kernel/module.c b/kernel/module.c
index 40f983cbea81..5e241ba95a91 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3609,8 +3609,8 @@ static int prepare_coming_module(struct module *mod)
 	return 0;
 }
 
-static int unknown_module_param_cb(char *param, char *val, const char *modname,
-				   void *arg)
+static int unknown_module_param_cb(char *param, char *val, char *next,
+					const char *modname, void *arg)
 {
 	struct module *mod = arg;
 	int ret;
diff --git a/kernel/params.c b/kernel/params.c
index 60b2d8101355..9f568fbf5287 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -119,13 +119,14 @@ static void param_check_unsafe(const struct kernel_param *kp)
 
 static int parse_one(char *param,
 		     char *val,
+		     char *next,
 		     const char *doing,
 		     const struct kernel_param *params,
 		     unsigned num_params,
 		     s16 min_level,
 		     s16 max_level,
 		     void *arg,
-		     int (*handle_unknown)(char *param, char *val,
+		     int (*handle_unknown)(char *param, char *val, char *next,
 				     const char *doing, void *arg))
 {
 	unsigned int i;
@@ -153,7 +154,7 @@ static int parse_one(char *param,
 
 	if (handle_unknown) {
 		pr_debug("doing %s: %s='%s'\n", doing, param, val);
-		return handle_unknown(param, val, doing, arg);
+		return handle_unknown(param, val, next, doing, arg);
 	}
 
 	pr_debug("Unknown argument '%s'\n", param);
@@ -168,10 +169,10 @@ char *parse_args(const char *doing,
 		 s16 min_level,
 		 s16 max_level,
 		 void *arg,
-		 int (*unknown)(char *param, char *val,
+		 int (*unknown)(char *param, char *val, char *next,
 				const char *doing, void *arg))
 {
-	char *param, *val, *err = NULL;
+	char *param, *val, *next, *err = NULL;
 
 	/* Chew leading spaces */
 	args = skip_spaces(args);
@@ -179,16 +180,18 @@ char *parse_args(const char *doing,
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
+		ret = parse_one(param, val, next, doing, params, num,
 				min_level, max_level, arg, unknown);
 		if (irq_was_disabled && !irqs_disabled())
 			pr_warn("%s: option '%s' enabled irq's!\n",
@@ -211,7 +214,7 @@ char *parse_args(const char *doing,
 		}
 
 		err = ERR_PTR(ret);
-	}
+	} while (*next);
 
 	return err;
 }
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index da796e2dc4f5..bdedc1ca5bf6 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -888,7 +888,7 @@ static int ddebug_dyndbg_param_cb(char *param, char *val,
 }
 
 /* handle both dyndbg and $module.dyndbg params at boot */
-static int ddebug_dyndbg_boot_param_cb(char *param, char *val,
+static int ddebug_dyndbg_boot_param_cb(char *param, char *val, char *unused2,
 				const char *unused, void *arg)
 {
 	vpr_info("%s=\"%s\"\n", param, val);
-- 
2.10.2
