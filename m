Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D49831A1A38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 09:18:55 +1000 (AEST)
Date: Wed, 22 Jul 2015 09:18:44 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ian Munsie <imunsie@au1.ibm.com>, Benjamin Herrenschmidt
 <benh@au1.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Neuling
 <michael.neuling@au1.ibm.com>, "sonal.santan" <sonal.santan@xilinx.com>,
 Jeremy Kerr <jk@ozlabs.org>, Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
Subject: Re: [PATCH] Fix crash due to processing "memory-controller" nodes
 as "memory"
Message-ID: <20150722091844.114ea023@kryten>
In-Reply-To: <1437447984.30722.3.camel@ellerman.id.au>
References: <1437380450-25555-1-git-send-email-imunsie@au.ibm.com>
 <20150721124554.332dd228@kryten>
 <1437447984.30722.3.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

> > Nice catch! I wonder if we should be checking for device_type
> > "memory". Ben?
> 
> Yes. That's what Linux does.

Ian: I made that change, and slightly modified your commit message.
Look ok?

Anton
--

[PATCH] Fix crash due to processing "memory-controller" nodes as "memory"

If the system has a PCI device with a memory-controller device node,
kexec-lite would spew hundreds of double free warnings and eventually
segfault. This would result in a "kexec load failed" message from
petitboot.

This was due to kexec_memory_map() searching for "memory" nodes, but
actually matching any node that started with "memory", including these
"memory-controller" nodes. This patch changes the search to look for
nodes with a device_type of "memory", which should only match memory
nodes.

An example of a device tree that can trigger this bug is as follows:

{
	pciex@3fffe40000000 {
		...
		pci@0 {
			#address-cells = <0x3>;
			#size-cells = <0x2>;
			...
			memory-controller@0 {
				reg = <0x10000 0x0 0x0 0x0 0x0>;
				...
			};
		};
	};
};

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 kexec_memory_map.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kexec_memory_map.c b/kexec_memory_map.c
index fc1b7af..6103590 100644
--- a/kexec_memory_map.c
+++ b/kexec_memory_map.c
@@ -182,7 +182,7 @@ void kexec_memory_map(void *fdt, int reserve_initrd)
 	}
 
 	while (1) {
-		const char *name;
+		const char *type;
 		int len;
 		const fdt64_t *reg;
 
@@ -190,9 +190,9 @@ void kexec_memory_map(void *fdt, int reserve_initrd)
 		if (nodeoffset < 0)
 			break;
 
-		name = fdt_get_name(fdt, nodeoffset, NULL);
+		type = fdt_getprop(fdt, nodeoffset, "device_type", NULL);
 
-		if (!name || strncmp(name, "memory", strlen("memory")))
+		if (!type || strcmp(type, "memory"))
 			continue;
 
 		reg = fdt_getprop(fdt, nodeoffset, "reg", &len);
-- 
2.1.0
