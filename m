Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C83BA67B5E
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 15:24:35 +1000 (EST)
Date: Wed, 16 Aug 2006 15:24:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iseries: remove const warning
Message-Id: <20060816152428.46183e42.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Just one bit of fallout from the constification of the get_property
return value.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/viopath.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/arch/powerpc/platforms/iseries/viopath.c b/arch/powerpc/platforms/iseries/viopath.c
index efeb6ae..9baa4ee 100644
--- a/arch/powerpc/platforms/iseries/viopath.c
+++ b/arch/powerpc/platforms/iseries/viopath.c
@@ -117,6 +117,7 @@ static int proc_viopath_show(struct seq_
 	HvLpEvent_Rc hvrc;
 	DECLARE_MUTEX_LOCKED(Semaphore);
 	struct device_node *node;
+	const char *sysid;
 
 	buf = kmalloc(HW_PAGE_SIZE, GFP_KERNEL);
 	if (!buf)
@@ -152,15 +153,15 @@ static int proc_viopath_show(struct seq_
 	seq_printf(m, "AVAILABLE_VETH=%x\n", vlanMap);
 
 	node = of_find_node_by_path("/");
-	buf = NULL;
+	sysid = NULL;
 	if (node != NULL)
-		buf = get_property(node, "system-id", NULL);
+		sysid = get_property(node, "system-id", NULL);
 
-	if (buf == NULL)
+	if (sysid == NULL)
 		seq_printf(m, "SRLNBR=<UNKNOWN>\n");
 	else
 		/* Skip "IBM," on front of serial number, see dt.c */
-		seq_printf(m, "SRLNBR=%s\n", buf + 4);
+		seq_printf(m, "SRLNBR=%s\n", sysid + 4);
 
 	of_node_put(node);
 
-- 
1.4.1.1
