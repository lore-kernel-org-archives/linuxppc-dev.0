Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0C85D2C05B6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:47:29 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 22 Jan 2013 17:43:29 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8DC622BB004A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:47:24 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0M7lOD353215356
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:47:24 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0M7lMxZ032615
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:47:24 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v5 44/45] CPU hotplug,
 stop_machine: Decouple CPU hotplug from stop_machine() in Kconfig
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org
Date: Tue, 22 Jan 2013 13:15:22 +0530
Message-ID: <20130122074518.13822.86992.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu,
 wangyun@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

... and also cleanup a comment that refers to CPU hotplug being dependent on
stop_machine().

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
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
index be8b7f5..048a0c5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1711,7 +1711,7 @@ config INIT_ALL_POSSIBLE
 config STOP_MACHINE
 	bool
 	default y
-	depends on (SMP && MODULE_UNLOAD) || HOTPLUG_CPU
+	depends on (SMP && MODULE_UNLOAD)
 	help
 	  Need stop_machine() primitive.
 
