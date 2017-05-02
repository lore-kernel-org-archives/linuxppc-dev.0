Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wHQsJ22shzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 May 2017 01:57:08 +1000 (AEST)
From: Michal Suchanek <msuchanek@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jonathan Corbet <corbet@lwn.net>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
 Michal Hocko <mhocko@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 RFT 2/2] powerpc/fadump: update documentation about
 'fadump_append=' parameter
Date: Tue,  2 May 2017 17:56:11 +0200
Message-Id: <20170502155611.6789-2-msuchanek@suse.de>
In-Reply-To: <20170502155611.6789-1-msuchanek@suse.de>
References: <20170502155611.6789-1-msuchanek@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the introduction of 'fadump_append=' parameter to pass additional
parameters to fadump (capture) kernel, update documentation about it.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 Documentation/powerpc/firmware-assisted-dump.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/powerpc/firmware-assisted-dump.txt b/Documentation/powerpc/firmware-assisted-dump.txt
index 9cabaf8..99ab8f4 100644
--- a/Documentation/powerpc/firmware-assisted-dump.txt
+++ b/Documentation/powerpc/firmware-assisted-dump.txt
@@ -162,7 +162,11 @@ How to enable firmware-assisted dump (fadump):
 
 1. Set config option CONFIG_FA_DUMP=y and build kernel.
 2. Boot into linux kernel with 'fadump=on' kernel cmdline option.
-3. Optionally, user can also set 'crashkernel=' kernel cmdline
+3. A user can pass additional kernel parameters as a comma separated list
+   through 'fadump_append=' parameter, to be be appended when fadump is active.
+   This can be used to pass parameters like nr_cpus=1, numa=off to reduce
+   memory consumption during dump capture.
+4. Optionally, user can also set 'fadump_reserve_mem=' kernel cmdline
    to specify size of the memory to reserve for boot memory dump
    preservation.
 
@@ -172,6 +176,8 @@ NOTE: 1. 'fadump_reserve_mem=' parameter has been deprecated. Instead
       2. If firmware-assisted dump fails to reserve memory then it
          will fallback to existing kdump mechanism if 'crashkernel='
          option is set at kernel cmdline.
+      3. 'fadump_append=' parameter con be quoted to append multiple arguments
+         as in 'fadump_append="nr_cpus=8 numa=off"'
 
 Sysfs/debugfs files:
 ------------
-- 
2.10.2
