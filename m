Return-Path: <grant.likely@secretlab.ca>
Received: from mail-wi0-x22b.google.com (mail-wi0-x22b.google.com
 [IPv6:2a00:1450:400c:c05::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C49682C02B9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 21:48:31 +1000 (EST)
Received: by mail-wi0-f171.google.com with SMTP id hq7so602443wib.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 04:48:27 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: DTB build failure due to preproccessing
To: Ian Campbell <Ian.Campbell@citrix.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1369996170.5199.68.camel@zakaz.uk.xensource.com>
References: <1369996170.5199.68.camel@zakaz.uk.xensource.com>
Date: Fri, 31 May 2013 12:48:24 +0100
Message-Id: <20130531114824.60D223E0901@localhost>
Cc: Michal Marek <mmarek@suse.cz>, JonLoeliger <jdl@jdl.com>,
 Stephen Warren <swarren@nvidia.com>, linux-kbuild@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 31 May 2013 11:29:30 +0100, Ian Campbell <Ian.Campbell@citrix.com> wrote:
> This affects arch/powerpc/boot/dts/virtex440-ml510.dts but I think it is
> actually a more general issue:
> 
>         $ make ARCH=powerpc CROSS_COMPILE=powerpc-linux- virtex440-ml510.dtb 
>           CC      scripts/mod/devicetable-offsets.s
>           GEN     scripts/mod/devicetable-offsets.h
>           HOSTCC  scripts/mod/file2alias.o
>           HOSTLD  scripts/mod/modpost
>           DTC     arch/powerpc/boot/virtex440-ml510.dtb
>         Error: arch/powerpc/boot/dts/virtex440-ml510.dts:374.6-7 syntax error
>         FATAL ERROR: Unable to parse input tree
>         make[1]: *** [arch/powerpc/boot/virtex440-ml510.dtb] Error 1
>         make: *** [virtex440-ml510.dtb] Error 2
>         
> Line 374 is the "IDSEL 0x16..." line here:
> 			interrupt-map = <
> 				/* IRQ mapping for pci slots and ALI M1533
> 				 ...
> 				 * management core also isn't used.
> 				 */
> 
> 				/* IDSEL 0x16 / dev=6, bus=0 / PCI slot 3 */
> 				0x3000 0 0 1 &xps_intc_0 3 2
> 				0x3000 0 0 2 &xps_intc_0 2 2
> 				0x3000 0 0 3 &xps_intc_0 5 2
> 				0x3000 0 0 4 &xps_intc_0 4 2
> 
> Which gets preprocessed into:
>            interrupt-map = <
>         # 375 "arch/powerpc/boot/dts/virtex440-ml510.dts"
>             0x3000 0 0 1 &xps_intc_0 3 2
>             0x3000 0 0 2 &xps_intc_0 2 2
>             0x3000 0 0 3 &xps_intc_0 5 2
>             0x3000 0 0 4 &xps_intc_0 4 2
> 
> If I manually remove the "# 375 " line then that fixes the error
> (although there is then a subsequent one of the same type).
> 
> I suppose this is a bug in dtc? It appears to have at least some
> awareness of these preprocessor line number comments since it manages to
> report the original source line number.

dtc is only able to track line numbers when the native /include/
directive is used. The #include directive doesn't help it. It should be
added, but until it is the following patch solves the problem:

I've got this patch in my tree. Either Rob or I will push it to Linus in
the next few days.

g.

---
commit d01dccdcb3ea8233b09efb9c24db9f057fbd3b37
Author: Grant Likely <grant.likely@linaro.org>
Date:   Fri May 31 12:45:18 2013 +0100

    dtc: Suppress cpp linemarker annotations
    
    DTC isn't able to parse cpp linemarker annotations, so suppress them in
    the cpp output by adding the -P flag to the cpp options.
    
    Signed-off-by: Grant Likely <grant.likely@linaro.org>

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 51bb3de..fc08a2b 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -149,7 +149,7 @@ cpp_flags      = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
 
 ld_flags       = $(LDFLAGS) $(ldflags-y)
 
-dtc_cpp_flags  = -Wp,-MD,$(depfile).pre -nostdinc                        \
+dtc_cpp_flags  = -Wp,-MD,$(depfile).pre -nostdinc -P                     \
 		 -I$(srctree)/arch/$(SRCARCH)/boot/dts                   \
 		 -I$(srctree)/arch/$(SRCARCH)/boot/dts/include           \
 		 -undef -D__DTS__
