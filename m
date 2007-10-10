Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5FBB4DDF90
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 20:09:26 +1000 (EST)
Date: Wed, 10 Oct 2007 05:08:44 -0500 (CDT)
Message-Id: <200710101008.l9AA8hIG084068@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@samba.org>,
	Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH v2] powerpc: don't enable cpu hotplug on mpic-based pseries
In-Reply-To: <20071010003824.GA8477@lixom.net>
References: <20071008180406.052382073@mini.kroah.org>,
	<20071008180633.GJ7627@kroah.com>,
	<20071009151702.GA19209@lixom.net>,
	<20071009222003.GA21228@kroah.com>,
	<alpine.LFD.0.9999.0710100120340.7766@localhost.localdomain>,
	<alpine.LFD.0.999.0710091625520.3838@woody.linux%foundation.org>,
	<20071010000815.GB7875@lixom.net>,
	<20071010101826.186f1f24.sfr@canb.auug.org.au>,
	<20071010003824.GA8477@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Don't allow cpu hotplug on pSeries systems lacking XICS interrupt controller,
since current code is hardcoded to call xics routines.

Signed-off-by: Milton Miller <miltonm@bga.com>
--

Olof's patch searched the device-tree again, looking for an mpic.   This
code instead checks that we found an xics the first time by checking the
init function.

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 9711eb0..20f010a 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -262,6 +262,12 @@ static int __init pseries_cpu_hotplug_init(void)
 		return 0;
 	}
 
+	if (ppc_md.init_IRQ != xics_init_IRQ) {
+		printk(KERN_INFO "pSeries CPU Hotplug only supported on xics "
+				"interrupt controllers - disabling");
+		return 0;
+	}
+
 	ppc_md.cpu_die = pseries_mach_cpu_die;
 	smp_ops->cpu_disable = pseries_cpu_disable;
 	smp_ops->cpu_die = pseries_cpu_die;
