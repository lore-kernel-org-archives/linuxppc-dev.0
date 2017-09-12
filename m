Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xs8gp1KkjzDqjt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 02:02:13 +1000 (AEST)
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
Subject: [PATCH v8 2/6] powerpc/fadump: update documentation about
 'fadump_extra_args=' parameter
Date: Tue, 12 Sep 2017 18:01:40 +0200
Message-Id: <5db2fb2d68310ae455eaa5a713358de62ff398d9.1505231820.git.msuchanek@suse.de>
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
