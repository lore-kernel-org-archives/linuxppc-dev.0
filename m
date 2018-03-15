Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402JH10f8JzF1C5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 06:16:29 +1100 (AEDT)
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Michael Neuling <mikey@neuling.org>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Nicholas Piggin <npiggin@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>,
 David Gibson <david@gibson.dropbear.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Joe Perches <joe@perches.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Tobin C. Harding" <me@tobin.cc>, Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH RFC rebase 9/9] powerpc/64: barrier_nospec: Add commandline
 trigger
Date: Thu, 15 Mar 2018 20:15:58 +0100
Message-Id: <1dcf7403042daddcdb8109f6b852b9bb9d768f89.1521141122.git.msuchanek@suse.de>
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
 <cover.1521141122.git.msuchanek@suse.de>
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <cover.1521141122.git.msuchanek@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add commandline options spectre_v2 and nospectre_v2

These are named same as similar x86 options regardless of actual effect
to not require platform-specific configuration.

Supported options:
nospectre_v2 or spectre_v2=off - speculation barrier not used
spectre_v2=on or spectre_v2=auto - speculation barrier used

Changing the settings after boot is not supported and VM migration may
change requirements so auto is same as on.

Based on s390 implementation

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/setup_64.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index f6678a7b6114..c74e656265df 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -840,6 +840,28 @@ static int __init handle_no_pti(char *p)
 }
 early_param("nopti", handle_no_pti);
 
+static int __init nospectre_v2_setup_early(char *str)
+{
+	no_nospec = true;
+	return 0;
+}
+early_param("nospectre_v2", nospectre_v2_setup_early);
+
+static int __init spectre_v2_setup_early(char *str)
+{
+	if (str && !strncmp(str, "on", 2))
+		no_nospec = false;
+
+	if (str && !strncmp(str, "off", 3))
+		no_nospec = true;
+
+	if (str && !strncmp(str, "auto", 4))
+		no_nospec = false;
+
+	return 0;
+}
+early_param("spectre_v2", spectre_v2_setup_early);
+
 static void do_nothing(void *unused)
 {
 	/*
-- 
2.13.6
