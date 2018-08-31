Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421n2m5Sb4zF37g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 14:49:36 +1000 (AEST)
Message-ID: <a825ebf4c01f862075006370f418e0b7ab4626ad.camel@kernel.crashing.org>
Subject: Re: v4.17 regression: PowerMac G3 won't boot, was Re: [PATCH v5
 1/3] of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mac User <userm57@yahoo.com>, Rob Herring <robh+dt@kernel.org>
Cc: fthain@telegraphics.com.au, Frank Rowand <frank.rowand@sony.com>,
 Chintan Pandya <cpandya@codeaurora.org>, devicetree@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 31 Aug 2018 14:49:21 +1000
In-Reply-To: <84f13bded54eda0817f9134f355d518d5b3a5f77.camel@kernel.crashing.org>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
 <1520208889-3908-2-git-send-email-frowand.list@gmail.com>
 <alpine.LNX.2.21.1808301025480.73@nippy.intranet>
 <CAL_JsqLJ9QMHCMqGKpCouP1rTEO+cMGA1es94qAH+ukLsR31jg@mail.gmail.com>
 <569e4bc3-2149-4b2d-562f-e400dd05a8a8@yahoo.com>
 <84f13bded54eda0817f9134f355d518d5b3a5f77.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-08-31 at 14:35 +1000, Benjamin Herrenschmidt wrote:
> 
> > If I force output with "-f", the resulting file has no occurrences 
> > of "phandle".
> 
> Are you booting with BootX or Open Firmware ?

Assuming you are using BootX (or miBoot), can you try this patch ?

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
+               if (!strcmp(namep, "phandle") || !strcmp(namep, "linux,phandle"))
+                       bootx_phandle = -1;
                /* get/create string entry */
                soff = bootx_dt_find_string(namep);
                if (soff == 0)
@@ -310,6 +313,7 @@ static void __init bootx_scan_dt_build_struct(unsigned long base,
        *mem_end = _ALIGN_UP((unsigned long)lp + 1, 4);
 
        /* get and store all properties */
+       has_phandle = false;
        while (*ppp) {
                struct bootx_dt_prop *pp =
                        (struct bootx_dt_prop *)(base + *ppp);
@@ -330,6 +334,12 @@ static void __init bootx_scan_dt_build_struct(unsigned long base,
                ppp = &pp->next;
        }
 
+       /* add a phandle */
+       if (bootx_phandle > 0) {
+               bootx_dt_add_prop("phandle", &bootx_phandle, 4, mem_end);
+               bootx_phandle++;
+       }
+
        if (node == bootx_node_chosen) {
                bootx_add_chosen_props(base, mem_end);
                if (bootx_info->dispDeviceRegEntryOffset == 0)
@@ -385,6 +395,8 @@ static unsigned long __init bootx_flatten_dt(unsigned long start)
        bootx_dt_add_string("linux,bootx-height", &mem_end);
        bootx_dt_add_string("linux,bootx-linebytes", &mem_end);
        bootx_dt_add_string("linux,bootx-addr", &mem_end);
+       if (bootx_phandle > 0)
+               bootx_dt_add_string("phandle", &mem_end);
        /* Wrap up strings */
        hdr->off_dt_strings = bootx_dt_strbase - mem_start;
        hdr->dt_strings_size = bootx_dt_strend - bootx_dt_strbase;
@@ -482,6 +494,7 @@ void __init bootx_init(unsigned long r3, unsigned long r4)
        bootx_dt_strbase = bootx_dt_strend = 0;
        bootx_node_chosen = 0;
        bootx_disp_path[0] = 0;
+       bootx_phandle = 1;
 
        if (!BOOT_INFO_IS_V2_COMPATIBLE(bi))
                bi->logicalDisplayBase = bi->dispDeviceBase;
