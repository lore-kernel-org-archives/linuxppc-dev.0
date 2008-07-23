Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 13B90DDE08
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 10:45:00 +1000 (EST)
Date: Wed, 23 Jul 2008 10:44:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: [PATCH] powerpc: fallout from sysdev API changes
Message-Id: <20080723104458.0cca65d5.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Greg KH <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A struct sysdev_attribute * parameter was added to the show routine by
commit 4a0b2b4dbe1335b8b9886ba3dc85a145d5d938ed "sysdev: Pass the
attribute to the low level sysdev show/store function".

This eliminates a warning:

arch/powerpc/kernel/sysfs.c:538: warning: initialization from incompatible pointer type

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/sysfs.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

Greg, probably easiest for this to go via the powerpc tree - an Ack would
be nice, though.

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index aba0ba9..800e5e9 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -529,7 +529,8 @@ static void register_nodes(void)
 #endif
 
 /* Only valid if CPU is present. */
-static ssize_t show_physical_id(struct sys_device *dev, char *buf)
+static ssize_t show_physical_id(struct sys_device *dev,
+				struct sysdev_attribute *attr, char *buf)
 {
 	struct cpu *cpu = container_of(dev, struct cpu, sysdev);
 
-- 
1.5.6.3

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
