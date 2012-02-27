Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8DF72B6FA2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2012 05:55:32 +1100 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 27 Feb 2012 11:55:29 -0700
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id D5DA4C40004
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2012 11:55:23 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1RItIe9108392
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2012 11:55:19 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1RItHfR001271
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2012 11:55:18 -0700
Date: Mon, 27 Feb 2012 10:55:15 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/prom: remove limit on maximum size of properties
Message-ID: <20120227185515.GB21796@linux.vnet.ibm.com>
References: <1330129422-2648-1-git-send-email-nacc@us.ibm.com>
 <1330298534.20389.53.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330298534.20389.53.camel@pasglop>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, Anton Blanchard <anton@au1.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Robert Jennings <rcj@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

On 27.02.2012 [10:22:14 +1100], Benjamin Herrenschmidt wrote:
> On Fri, 2012-02-24 at 16:23 -0800, Nishanth Aravamudan wrote:
> > On a 16TB system (using AMS/CMO), I get:
> > 
> > WARNING: ignoring large property [/ibm,dynamic-reconfiguration-memory] ibm,dynamic-memory length 0x000000000017ffec
> > 
> > and significantly less memory is thus shown to the partition. As far as
> > I can tell, the constant used is arbitrary, but bump it up to 2MB, which
> > covers the above property (approximately 1.5MB).
> > 
> > With this patch, the kernel does see all of the system memory on the
> > 16TB system.
> 
> Why not go all the way to either removing the limit, or setting it to
> something much bigger ? That's just asking to break again when we get an
> even bigger system.

Fair point -- sorry, was just trying to get something out the door that
I had tested, since I have limited access to the hardware in question.

> The limit was originally set because of Apple machines carrying ROM
> images in the device-tree, at a time where we were much more memory
> constrained than we are now.
> 
> But even then, it never represented such a large gain and in the end,
> was probably not -that- useful.
> 
> I'd say bump it to something really large like 16M or remove the limit
> alltogether.

So, in terms of removing the limit altogether, is that a literal
statement? I don't know this code particularly well, but only see
references to the constant, at least in prom_init.c:

powerpc/prom: remove limit on maximum size of properties
    
On a 16TB system (using AMS/CMO), I get:
    
WARNING: ignoring large property [/ibm,dynamic-reconfiguration-memory] ibm,dynamic-memory length 0x000000000017ffec
    
and significantly less memory is thus shown to the partition. As far as
I can tell, the constant used is arbitrary. Ben Herrenschmidt provided
additional background that
    
> The limit was originally set because of Apple machines carrying ROM
> images in the device-tree, at a time where we were much more memory
> constrained than we are now.
    
and that it is likely not very useful any longer.
    
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
    
---
With this patch, the kernel should see all of the system memory on the
16TB system, but I'm unable to test due to lack of hardware access. I'm
working on getting access again, but not confident that will happen
soon.

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index eca626e..e2d5990 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -48,14 +48,6 @@
 #include <linux/linux_logo.h>
 
 /*
- * Properties whose value is longer than this get excluded from our
- * copy of the device tree. This value does need to be big enough to
- * ensure that we don't lose things like the interrupt-map property
- * on a PCI-PCI bridge.
- */
-#define MAX_PROPERTY_LENGTH	(1UL * 1024 * 1024)
-
-/*
  * Eventually bump that one up
  */
 #define DEVTREE_CHUNK_SIZE	0x100000
@@ -2273,13 +2265,6 @@ static void __init scan_dt_build_struct(phandle node, unsigned long *mem_start,
 		/* sanity checks */
 		if (l == PROM_ERROR)
 			continue;
-		if (l > MAX_PROPERTY_LENGTH) {
-			prom_printf("WARNING: ignoring large property ");
-			/* It seems OF doesn't null-terminate the path :-( */
-			prom_printf("[%s] ", path);
-			prom_printf("%s length 0x%x\n", RELOC(pname), l);
-			continue;
-		}
 
 		/* push property head */
 		dt_push_token(OF_DT_PROP, mem_start, mem_end);

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
