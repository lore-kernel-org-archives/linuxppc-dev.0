Return-Path: <rientjes@google.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id EF0341007DA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2011 09:46:42 +1100 (EST)
Received: by iacb35 with SMTP id b35so3164657iac.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Dec 2011 14:46:40 -0800 (PST)
Date: Thu, 8 Dec 2011 14:46:37 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [patch] powerpc, mm: fix section mismatch for read_n_cells
In-Reply-To: <alpine.DEB.2.00.1112081428290.28693@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.00.1112081443270.28693@chino.kir.corp.google.com>
References: <1323371433.23534.8.camel@subratamodak.linux.ibm.com>
 <alpine.DEB.2.00.1112081428290.28693@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Wizner <markwiz@us.ibm.com>, Naveed <naveedaus@in.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Manas k Nayak <maknayak@in.ibm.com>, Pavaman <pavsubra@in.ibm.com>,
 Anton Blanchard <anton@samba.org>, Vishu <svishuku@in.ibm.com>,
 Subrata Modak <subrata@linux.vnet.ibm.com>,
 "divya.vikas" <divya.vikas@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

read_n_cells() cannot be marked as .devinit.text since it is referenced 
from two functions that are not in that section: of_get_lmb_size() and 
hot_add_drconf_scn_to_nid().

Signed-off-by: David Rientjes <rientjes@google.com>
---
 arch/powerpc/mm/numa.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -406,7 +406,7 @@ static void __init get_n_mem_cells(int *n_addr_cells, int *n_size_cells)
 	of_node_put(memory);
 }
 
-static unsigned long __devinit read_n_cells(int n, const unsigned int **buf)
+static unsigned long read_n_cells(int n, const unsigned int **buf)
 {
 	unsigned long result = 0;
 
