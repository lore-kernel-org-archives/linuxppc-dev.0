Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C8670B7D88
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Mar 2010 10:33:33 +1100 (EST)
Date: Tue, 16 Mar 2010 10:33:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Subject: [PATCH] sysdev: the cpu probe/release attributes should be
	sysdev_class_attributes
Message-Id: <20100316103332.ade0b5d9.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Andi Kleen <andi@firstfloor.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes these warnings:

drivers/base/cpu.c:264: warning: initialization from incompatible pointer type
drivers/base/cpu.c:265: warning: initialization from incompatible pointer type

Cc: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/base/cpu.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

Hi Greg,

Could you pleas send this on to Linuse as this is now a bug in mainline.

Thanks.

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 7036e8e..b5242e1 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -79,24 +79,24 @@ void unregister_cpu(struct cpu *cpu)
 }
 
 #ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
-static ssize_t cpu_probe_store(struct sys_device *dev,
-				struct sysdev_attribute *attr,
-				const char *buf,
+static ssize_t cpu_probe_store(struct sysdev_class *class,
+			       struct sysdev_class_attribute *attr,
+			       const char *buf,
 			       size_t count)
 {
 	return arch_cpu_probe(buf, count);
 }
 
-static ssize_t cpu_release_store(struct sys_device *dev,
-				struct sysdev_attribute *attr,
-				const char *buf,
+static ssize_t cpu_release_store(struct sysdev_class *class,
+				 struct sysdev_class_attribute *attr,
+				 const char *buf,
 				 size_t count)
 {
 	return arch_cpu_release(buf, count);
 }
 
-static SYSDEV_ATTR(probe, S_IWUSR, NULL, cpu_probe_store);
-static SYSDEV_ATTR(release, S_IWUSR, NULL, cpu_release_store);
+static SYSDEV_CLASS_ATTR(probe, S_IWUSR, NULL, cpu_probe_store);
+static SYSDEV_CLASS_ATTR(release, S_IWUSR, NULL, cpu_release_store);
 #endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
 
 #else /* ... !CONFIG_HOTPLUG_CPU */
-- 
1.7.0

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
