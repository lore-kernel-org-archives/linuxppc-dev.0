Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYHWg52l8zDrJ5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 06:15:11 +1000 (AEST)
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
Subject: [PATCH v7 2/4] powerpc/fadump: update documentation about
 'fadump_extra_args=' parameter
Date: Thu, 17 Aug 2017 22:14:29 +0200
Message-Id: <c4158a55f2db61bd4cee158edb03526800fd491b.1503000577.git.msuchanek@suse.de>
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

From: Hari Bathini <hbathini@linux.vnet.ibm.com>

With the introduction of 'fadump_extra_args=' parameter to pass additional
parameters to fadump (capture) kernel, update documentation about it.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 Documentation/powerpc/firmware-assisted-dump.txt | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/powerpc/firmware-assisted-dump.txt b/Documentation/powerpc/firmware-assisted-dump.txt
index bdd344aa18d9..2df88524d2c7 100644
--- a/Documentation/powerpc/firmware-assisted-dump.txt
+++ b/Documentation/powerpc/firmware-assisted-dump.txt
@@ -162,7 +162,19 @@ How to enable firmware-assisted dump (fadump):
 
 1. Set config option CONFIG_FA_DUMP=y and build kernel.
 2. Boot into linux kernel with 'fadump=on' kernel cmdline option.
-3. Optionally, user can also set 'crashkernel=' kernel cmdline
+3. A user can pass additional command line parameters as a space
+   separated quoted list through 'fadump_extra_args=' parameter,
+   to be enforced when fadump is active. For example, parameter
+   'fadump_extra_args="nr_cpus=1 numa=off udev.children-max=2"'
+   will be changed to 'fadump_extra_args nr_cpus=1  numa=off
+   udev.children-max=2' in-place when fadump is active. This
+   parameter has no affect when fadump is not active. Multiple
+   instances of 'fadump_extra_args=' can be passed. This provision
+   can be used to reduce memory consumption during dump capture by
+   disabling unwarranted resources/subsystems like CPUs, NUMA
+   and such. Value with spaces can be passed as
+   'fadump_extra_args=""parameter="value with spaces"""'
+4. Optionally, user can also set 'crashkernel=' kernel cmdline
    to specify size of the memory to reserve for boot memory dump
    preservation.
 
@@ -172,6 +184,12 @@ NOTE: 1. 'fadump_reserve_mem=' parameter has been deprecated. Instead
       2. If firmware-assisted dump fails to reserve memory then it
          will fallback to existing kdump mechanism if 'crashkernel='
          option is set at kernel cmdline.
+      3. Special parameters like '--' passed inside fadump_extra_args are also
+         just left in-place. So, the user is advised to consider this while
+         specifying such parameters. It may be required to quote the argument
+         to fadump_extra_args when the bootloader uses double-quotes as
+         argument delimiter as well. eg
+        append = " fadump_extra_args=\"nr_cpus=1 numa=off udev.children-max=2\""
 
 Sysfs/debugfs files:
 ------------
-- 
2.10.2
