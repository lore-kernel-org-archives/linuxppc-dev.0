Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C7C94DDFBB
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 10:03:09 +1000 (EST)
Date: Tue, 9 Oct 2007 19:08:15 -0500
From: Olof Johansson <olof@lixom.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] powerpc: don't enable cpu hotplug on mpic-based pseries
Message-ID: <20071010000815.GB7875@lixom.net>
References: <20071008180406.052382073@mini.kroah.org>
	<20071008180633.GJ7627@kroah.com>
	<20071009151702.GA19209@lixom.net>
	<20071009222003.GA21228@kroah.com>
	<alpine.LFD.0.9999.0710100120340.7766@localhost.localdomain>
	<alpine.LFD.0.999.0710091625520.3838@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.0.999.0710091625520.3838@woody.linux-foundation.org>
Cc: Greg KH <greg@kroah.com>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org,
	Chris Wedgwood <reviews@ml.cw.f00f.org>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, tgall.foo@gmail.com,
	Thomas Gleixner <tglx@linutronix.de>, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Don't allow cpu hotplug on systems lacking XICS interrupt controller,
since current platform code is hardcoded for it.


Signed-off-by: Olof Johansson <olof@lixom.net>


diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 9711eb0..e29b890 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -252,6 +252,19 @@ static struct notifier_block pseries_smp_nb = {
 
 static int __init pseries_cpu_hotplug_init(void)
 {
+	struct device_node *np;
+	const char *typep;
+
+	for (np = NULL; (np = of_find_node_by_name(np,
+						   "interrupt-controller"));) {
+		typep = of_get_property(np, "compatible", NULL);
+		if (strstr(typep, "open-pic")) {
+			printk(KERN_INFO "CPU Hotplug not supported on "
+				"systems using MPIC\n");
+			return 0;
+		}
+	}
+
 	rtas_stop_self_args.token = rtas_token("stop-self");
 	qcss_tok = rtas_token("query-cpu-stopped-state");
 
