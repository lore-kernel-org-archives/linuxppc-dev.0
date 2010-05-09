Return-Path: <lists@nerdbynature.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 09AF9B7D1A
	for <linuxppc-dev@ozlabs.org>; Mon, 10 May 2010 08:33:29 +1000 (EST)
Date: Sun, 9 May 2010 15:27:29 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bug #15589] 2.6.34-rc1: Badness at fs/proc/generic.c:316
In-Reply-To: <HqroMXsT-CJ.A.DnG.m_y5LB@chimera>
Message-ID: <alpine.DEB.2.01.1005091519130.3067@bogon.housecafe.de>
References: <10aqDnTJcLO.A.mLE.48y5LB@chimera>
	<HqroMXsT-CJ.A.DnG.m_y5LB@chimera>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, schwab@linux-m68k.org,
	Kernel Testers List <kernel-testers@vger.kernel.org>,
	adobriyan@gmail.com, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 9 May 2010 at 23:17, Rafael J. Wysocki wrote:
> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=15589
> Subject		: 2.6.34-rc1: Badness at fs/proc/generic.c:316
> Submitter	: Christian Kujau <lists@nerdbynature.de>
> Date		: 2010-03-13 23:53 (58 days old)
> Message-ID	: <<alpine.DEB.2.01.1003131544340.5493@bogon.housecafe.de>>
> References	: http://marc.info/?l=linux-kernel&m=126852442903680&w=2

The bug is still present in -rc6, but Michael Ellerman has a patch[0] 
which made the warning go away.

@Michael: will you post your patch with a Sign-Off, so that it can be 
          pushed into mainline?

Thanks,
Christian.

[0] http://patchwork.ozlabs.org/patch/50557/

diff --git a/fs/proc/proc_devtree.c b/fs/proc/proc_devtree.c
index ce94801..019581d 100644
--- a/fs/proc/proc_devtree.c
+++ b/fs/proc/proc_devtree.c
@@ -176,6 +176,24 @@ retry:
 	return fixed_name;
 }
 
+static const char *unslash_name(const char *name)
+{
+	char *p, *fixed_name;
+
+	fixed_name = kstrdup(name, GFP_KERNEL);
+	if (!fixed_name) {
+		printk(KERN_ERR "device-tree: Out of memory trying to unslash "
+				"name \"%s\"\n", name);
+	return name;
+	}
+
+	p = fixed_name;
+	while ((p = strstr(p, "/")))
+		*p++ = '_';
+
+	return fixed_name;
+}
+
 /*
  * Process a node, adding entries for its children and its properties.
  */
@@ -212,6 +230,9 @@ void proc_device_tree_add_node(struct device_node *np,
 		if (duplicate_name(de, p))
 			p = fixup_name(np, de, p);
 
+		if (strstr(p, "/"))
+			p = unslash_name(p);
+
 		ent = __proc_device_tree_add_prop(de, pp, p);
 		if (ent == NULL)
 			break;
-- 
BOFH excuse #188:

..disk or the processor is on fire.
