Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xs8gx0N09zDrFq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 02:02:21 +1000 (AEST)
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
Subject: [PATCH v8 6/6] powerpc/fadump: use the new parse_args callback
 arguments
Date: Tue, 12 Sep 2017 18:01:44 +0200
Message-Id: <4fabdf584ad18d6aae61e331f783a5020567f634.1505231820.git.msuchanek@suse.de>
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

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/fadump.c | 47 ++++++++++++--------------------------------
 1 file changed, 13 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 8778e1cc0380..1678d99ea835 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -481,33 +481,19 @@ struct param_info {
 };
 
 static void __init fadump_update_params(struct param_info *param_info,
-					char *param, char *val)
+					char *param, char *val,
+					char *currant, char *next)
 {
-	ptrdiff_t param_offset = param - param_info->tmp_cmdline;
+	ptrdiff_t param_offset = currant - param_info->tmp_cmdline;
 	size_t vallen = val ? strlen(val) : 0;
 	char *tgt = param_info->cmdline + param_offset
 				- param_info->shortening;
-	int shortening = 0;
-	int quoted = 0;
+	int shortening = ((next - 1) - (currant))
+		- (FADUMP_EXTRA_ARGS_LEN + 1 + vallen);
 
 	if (!val)
 		return;
 
-	/* leading '"' removed from parameter */
-	if ((param > param_info->tmp_cmdline) && *(param - 1) == '"') {
-		quoted = 1;
-		shortening += 1;
-		tgt--;
-	}
-
-	/* next_arg removes one leading and one trailing '"' */
-	if ((*(tgt + FADUMP_EXTRA_ARGS_LEN + 1 + vallen + shortening) == '"') &&
-	    (quoted || (*(tgt + FADUMP_EXTRA_ARGS_LEN + 1) == '"'))) {
-		shortening += 1;
-		if (!quoted)
-			shortening += 1;
-	}
-
 	/* remove one leading and one trailing quote if both are present */
 	if ((val[0] == '"') && (val[vallen - 1] == '"')) {
 		shortening += 2;
@@ -515,22 +501,15 @@ static void __init fadump_update_params(struct param_info *param_info,
 		val++;
 	}
 
-	/* some characters were removed - move the trailing part of cmdline */
-	if (shortening) {
-		char *src;
+	strncpy(tgt, FADUMP_EXTRA_ARGS_PARAM, FADUMP_EXTRA_ARGS_LEN);
+	tgt += FADUMP_EXTRA_ARGS_LEN;
+	*tgt++ = ' ';
+	strncpy(tgt, val, vallen);
+	tgt += vallen;
 
-		strncpy(tgt, FADUMP_EXTRA_ARGS_PARAM, FADUMP_EXTRA_ARGS_LEN);
-		tgt += FADUMP_EXTRA_ARGS_LEN;
-		*tgt++ = ' ';
-
-		strncpy(tgt, val, vallen);
-		tgt += vallen;
-
-		src = tgt + shortening;
+	if (shortening) {
+		char *src = tgt + shortening;
 		memmove(tgt, src, strlen(src) + 1);
-	} else {
-		/* remove the '=' */
-		*(tgt + FADUMP_EXTRA_ARGS_LEN) = ' ';
 	}
 
 	param_info->shortening += shortening;
@@ -550,7 +529,7 @@ static int __init fadump_rework_cmdline_params(char *param, char *val,
 		     strlen(FADUMP_EXTRA_ARGS_PARAM) - 1))
 		return 0;
 
-	fadump_update_params(param_info, param, val);
+	fadump_update_params(param_info, param, val, currant, next);
 
 	return 0;
 }
-- 
2.10.2
