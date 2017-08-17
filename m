Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYHWj3WxGzDrJ5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 06:15:13 +1000 (AEST)
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
Subject: [PATCH v7 3/4] lib/cmdline.c Remove quotes symmetrically.
Date: Thu, 17 Aug 2017 22:14:30 +0200
Message-Id: <0e0a8ad11e2c9c7db02baa1bbb5a30f429586854.1503000577.git.msuchanek@suse.de>
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

Remove quotes from argument value only if there is qoute on both sides.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/fadump.c | 6 ++----
 lib/cmdline.c                | 7 ++-----
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index a1614d9b8a21..d7da4ce9f7ae 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -489,10 +489,8 @@ static void __init fadump_update_params(struct param_info *param_info,
 	*tgt++ = ' ';
 
 	/* next_arg removes one leading and one trailing '"' */
-	if (*tgt == '"')
-		shortening += 1;
-	if (*(tgt + vallen + shortening) == '"')
-		shortening += 1;
+	if ((*tgt == '"') && (*(tgt + vallen + shortening) == '"'))
+		shortening += 2;
 
 	/* remove one leading and one trailing quote if both are present */
 	if ((val[0] == '"') && (val[vallen - 1] == '"')) {
diff --git a/lib/cmdline.c b/lib/cmdline.c
index 4c0888c4a68d..01e701b2afe8 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -227,14 +227,11 @@ char *next_arg(char *args, char **param, char **val)
 		*val = args + equals + 1;
 
 		/* Don't include quotes in value. */
-		if (**val == '"') {
+		if ((**val == '"') && (args[i-1] == '"')) {
 			(*val)++;
-			if (args[i-1] == '"')
-				args[i-1] = '\0';
+			args[i-1] = '\0';
 		}
 	}
-	if (quoted && args[i-1] == '"')
-		args[i-1] = '\0';
 
 	if (args[i]) {
 		args[i] = '\0';
-- 
2.10.2
