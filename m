Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id AE0DDDDFAD
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 10:33:18 +1000 (EST)
Date: Tue, 9 Oct 2007 19:38:24 -0500
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2] powerpc: don't enable cpu hotplug on mpic-based pseries
Message-ID: <20071010003824.GA8477@lixom.net>
References: <20071008180406.052382073@mini.kroah.org>
	<20071008180633.GJ7627@kroah.com>
	<20071009151702.GA19209@lixom.net>
	<20071009222003.GA21228@kroah.com>
	<alpine.LFD.0.9999.0710100120340.7766@localhost.localdomain>
	<alpine.LFD.0.999.0710091625520.3838@woody.linux-foundation.org>
	<20071010000815.GB7875@lixom.net>
	<20071010101826.186f1f24.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071010101826.186f1f24.sfr@canb.auug.org.au>
Cc: Greg KH <greg@kroah.com>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org,
	Chris Wedgwood <reviews@ml.cw.f00f.org>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, tgall.foo@gmail.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Don't allow cpu hotplug on systems lacking XICS interrupt controller,
since current code is hardcoded for it.


Signed-off-by: Olof Johansson <olof@lixom.net>

---

On Wed, Oct 10, 2007 at 10:18:26AM +1000, Stephen Rothwell wrote:

> > +	struct device_node *np;
> > +	const char *typep;
> > +
> > +	for (np = NULL; (np = of_find_node_by_name(np,
> > +						   "interrupt-controller"));) {
> > +		typep = of_get_property(np, "compatible", NULL);
> > +		if (strstr(typep, "open-pic")) {
> > +			printk(KERN_INFO "CPU Hotplug not supported on "
> > +				"systems using MPIC\n");
> 
> You need an of_node_put(np) here.

Grmbl, you're right.

pseries_discover_pic() doesn't have one, that's where I took the above
logic from. So we're obviously already leaking device node references.

Still, no reason to make it worse.


-Olof

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 9711eb0..ae85fc0 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -252,6 +252,21 @@ static struct notifier_block pseries_smp_nb = {
 
 static int __init pseries_cpu_hotplug_init(void)
 {
+	struct device_node *np;
+	const char *typep;
+
+	for (np = NULL; (np = of_find_node_by_name(np,
+						   "interrupt-controller"));) {
+		typep = of_get_property(np, "compatible", NULL);
+		if (strstr(typep, "open-pic")) {
+			of_node_put(np);
+
+			printk(KERN_INFO "CPU Hotplug not supported on "
+				"systems using MPIC\n");
+			return 0;
+		}
+	}
+
 	rtas_stop_self_args.token = rtas_token("stop-self");
 	qcss_tok = rtas_token("query-cpu-stopped-state");
 
