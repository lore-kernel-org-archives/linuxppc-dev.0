Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 27FE12C00BC
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Oct 2013 10:15:35 +1000 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 1 Oct 2013 18:15:33 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 91EB53E4003E
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Oct 2013 18:15:31 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r920FVHo293694
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Oct 2013 18:15:31 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r920IaSF028270
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Oct 2013 18:18:36 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: [PATCH 9/9][v5] powerpc/perf: Update perf-mem man page for Power
Date: Tue,  1 Oct 2013 17:15:10 -0700
Message-Id: <1380672911-12812-10-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1380672911-12812-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1380672911-12812-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a few lines to the perf-mem man page to indicate:

	- its dependence on the mem-loads and mem-stores events

	- how to use the feature on Power architecture.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/perf/Documentation/perf-mem.txt |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index 888d511..f4881a0 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -18,6 +18,17 @@ from it, into perf.data. Perf record options are accepted and are passed through
 "perf mem -t <TYPE> report" displays the result. It invokes perf report with the
 right set of options to display a memory access profile.
 
+This command works on architectures that implement *mem-loads* and *mem-stores*
+perf events.
+
+The PowerPC architecture does not implement *mem-loads* and *mem-stores*
+events.  To get the memory hierarchy information for samples involving
+memory loads and stores, use a marked event like PM_MRK_GRP_CMPL.
+
+	perf record -d -e 'cpu/PM_MRK_GRP_CMPL/' <application>
+
+	perf report -n --mem-mode
+
 OPTIONS
 -------
 <command>...::
-- 
1.7.9.5
