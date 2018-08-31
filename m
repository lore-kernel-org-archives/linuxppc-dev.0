Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 422G3Z5rCpzF38g
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Sep 2018 09:36:58 +1000 (AEST)
Date: Sat, 1 Sep 2018 09:36:54 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Mac User <userm57@yahoo.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frank.rowand@sony.com>,
 Chintan Pandya <cpandya@codeaurora.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: v4.17 regression: PowerMac G3 won't boot, was Re: [PATCH v5 1/3]
 of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
In-Reply-To: <d3f5a177-10ee-1696-1ddf-41b7db62de6c@yahoo.com>
Message-ID: <alpine.LNX.2.21.1809010929350.228@nippy.intranet>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
 <1520208889-3908-2-git-send-email-frowand.list@gmail.com>
 <alpine.LNX.2.21.1808301025480.73@nippy.intranet>
 <CAL_JsqLJ9QMHCMqGKpCouP1rTEO+cMGA1es94qAH+ukLsR31jg@mail.gmail.com>
 <569e4bc3-2149-4b2d-562f-e400dd05a8a8@yahoo.com>
 <84f13bded54eda0817f9134f355d518d5b3a5f77.camel@kernel.crashing.org>
 <a825ebf4c01f862075006370f418e0b7ab4626ad.camel@kernel.crashing.org>
 <d3f5a177-10ee-1696-1ddf-41b7db62de6c@yahoo.com>
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

On Fri, 31 Aug 2018, Mac User wrote:

> On 8/30/18 10:49 PM, Benjamin Herrenschmidt wrote:
> 
> > On Fri, 2018-08-31 at 14:35 +1000, Benjamin Herrenschmidt wrote:
> >
> > ...
> > Assuming you are using BootX (or miBoot), can you try this patch ?
> 
> Yes, I'm using BootX.
> 
> Thanks to Finn for applying the patch (I wouldn't have been sure which 
> source tree to apply it to).
> 
> The patched kernel (Finn's vmlinux-4.18.0-00001-gd44cf7e41c19) boots 
> normally on my Beige G3 Desktop using BootX.
> 

Ben sent two patches, so I picked the most recent one and applied it by 
hand due to corrupted whitespace.

The patch you tested was the one below.

> Thanks for working on this!
> 

Thanks for testing!

> -Stan
> 

diff --git a/arch/powerpc/platforms/powermac/bootx_init.c b/arch/powerpc/platforms/powermac/bootx_init.c
index 3b3b0b9b3577..7fb1c7bb5835 100644
--- a/arch/powerpc/platforms/powermac/bootx_init.c
+++ b/arch/powerpc/platforms/powermac/bootx_init.c
@@ -37,6 +37,7 @@ static unsigned long __initdata bootx_dt_strend;
 static unsigned long __initdata bootx_node_chosen;
 static boot_infos_t * __initdata bootx_info;
 static char __initdata bootx_disp_path[256];
+static int __initdata bootx_phandle;
 
 /* Is boot-info compatible ? */
 #define BOOT_INFO_IS_COMPATIBLE(bi) \
@@ -258,6 +259,8 @@ static void __init bootx_scan_dt_build_strings(unsigned long base,
 		namep = pp->name ? (char *)(base + pp->name) : NULL;
  		if (namep == NULL || strcmp(namep, "name") == 0)
  			goto next;
+		if (!strcmp(namep, "phandle") || !strcmp(namep, "linux,phandle"))
+			bootx_phandle = -1;
 		/* get/create string entry */
 		soff = bootx_dt_find_string(namep);
 		if (soff == 0)
@@ -330,6 +333,12 @@ static void __init bootx_scan_dt_build_struct(unsigned long base,
 		ppp = &pp->next;
 	}
 
+	/* add a phandle */
+	if (bootx_phandle > 0) {
+		bootx_dt_add_prop("phandle", &bootx_phandle, 4, mem_end);
+		bootx_phandle++;
+	}
+
 	if (node == bootx_node_chosen) {
 		bootx_add_chosen_props(base, mem_end);
 		if (bootx_info->dispDeviceRegEntryOffset == 0)
@@ -385,6 +394,8 @@ static unsigned long __init bootx_flatten_dt(unsigned long start)
 	bootx_dt_add_string("linux,bootx-height", &mem_end);
 	bootx_dt_add_string("linux,bootx-linebytes", &mem_end);
 	bootx_dt_add_string("linux,bootx-addr", &mem_end);
+	if (bootx_phandle > 0)
+		bootx_dt_add_string("phandle", &mem_end);
 	/* Wrap up strings */
 	hdr->off_dt_strings = bootx_dt_strbase - mem_start;
 	hdr->dt_strings_size = bootx_dt_strend - bootx_dt_strbase;
@@ -482,6 +493,7 @@ void __init bootx_init(unsigned long r3, unsigned long r4)
 	bootx_dt_strbase = bootx_dt_strend = 0;
 	bootx_node_chosen = 0;
 	bootx_disp_path[0] = 0;
+	bootx_phandle = 1;
 
 	if (!BOOT_INFO_IS_V2_COMPATIBLE(bi))
 		bi->logicalDisplayBase = bi->dispDeviceBase;

-- 
