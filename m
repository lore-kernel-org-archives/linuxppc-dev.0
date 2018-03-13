Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4013Qv2LhpzDr7r
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 05:33:59 +1100 (AEDT)
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Peter Zijlstra <peterz@infradead.org>, Michal Suchanek <msuchanek@suse.de>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Nicholas Piggin <npiggin@gmail.com>, "Tobin C. Harding" <me@tobin.cc>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Al Viro <viro@zeniv.linux.org.uk>, Michael Neuling <mikey@neuling.org>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Balbir Singh <bsingharora@gmail.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Russell Currey <ruscur@russell.cc>,
 Joe Perches <joe@perches.com>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH RFC 8/8] powerpc/64: barrier_nospec: Add commandline trigger
Date: Tue, 13 Mar 2018 19:33:06 +0100
Message-Id: <8639fc8cb02548d478b041c3a00ad9053fdd8bc4.1520965380.git.msuchanek@suse.de>
In-Reply-To: <cover.1520965380.git.msuchanek@suse.de>
References: <cover.1520965380.git.msuchanek@suse.de>
In-Reply-To: <cover.1520965380.git.msuchanek@suse.de>
References: <cover.1520965380.git.msuchanek@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Copypasta from rfi implementation

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/setup_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 4b67b7b877d9..257f0e6be107 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -840,6 +840,14 @@ static int __init handle_no_pti(char *p)
 }
 early_param("nopti", handle_no_pti);
 
+static int __init handle_no_nospec(char *p)
+{
+	pr_info("barrier_nospec: disabled on command line.");
+	no_nospec = true;
+	return 0;
+}
+early_param("no_nospec", handle_no_nospec);
+
 static void do_nothing(void *unused)
 {
 	/*
-- 
2.13.6
