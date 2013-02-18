Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CF34A2C095E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:46:47 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 18:14:56 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 6C9AAE0050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 18:17:39 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1ICkdFn35848332
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 18:16:39 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1ICkeRk031392
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:46:42 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v6 45/46] CPU hotplug,
 stop_machine: Decouple CPU hotplug from stop_machine() in Kconfig
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org
Date: Mon, 18 Feb 2013 18:14:43 +0530
Message-ID: <20130218124443.26245.34919.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu,
 wangyun@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 netdev@vger.kernel.org, vincent.guittot@linaro.org, walken@google.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Simply dropping HOTPLUG_CPU from the dependency list of STOP_MACHINE will
lead to the following kconfig issue, reported by Fengguang Wu:

"warning: (HAVE_TEXT_POKE_SMP) selects STOP_MACHINE which has unmet direct
dependencies (SMP && MODULE_UNLOAD)"

So drop HOTPLUG_CPU and add HAVE_TEXT_POKE_SMP to the dependency list of
STOP_MACHINE.

And while at it, also cleanup a comment that refers to CPU hotplug being
dependent on stop_machine().

Cc: David Howells <dhowells@redhat.com>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Suggested-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---

 include/linux/stop_machine.h |    2 +-
 init/Kconfig                 |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index 3b5e910..ce2d3c4 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -120,7 +120,7 @@ int stop_machine(int (*fn)(void *), void *data, const struct cpumask *cpus);
  * @cpus: the cpus to run the @fn() on (NULL = any online cpu)
  *
  * Description: This is a special version of the above, which assumes cpus
- * won't come or go while it's being called.  Used by hotplug cpu.
+ * won't come or go while it's being called.
  */
 int __stop_machine(int (*fn)(void *), void *data, const struct cpumask *cpus);
 
diff --git a/init/Kconfig b/init/Kconfig
index be8b7f5..f4f79af 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1711,7 +1711,7 @@ config INIT_ALL_POSSIBLE
 config STOP_MACHINE
 	bool
 	default y
-	depends on (SMP && MODULE_UNLOAD) || HOTPLUG_CPU
+	depends on (SMP && (MODULE_UNLOAD || HAVE_TEXT_POKE_SMP))
 	help
 	  Need stop_machine() primitive.
 
