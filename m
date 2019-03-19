Return-Path: <SRS0=MfaX=RW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B8AC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 19:00:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E9B20693
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 19:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="coJnZfB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E9B20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44P2Sh1sq8zDqJc
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 06:00:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=cisco.com
 (client-ip=173.37.86.75; helo=rcdn-iport-4.cisco.com;
 envelope-from=danielwa@cisco.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=cisco.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=cisco.com header.i=@cisco.com header.b="coJnZfB/"; 
 dkim-atps=neutral
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44P2QZ5t5WzDqHj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 05:59:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=5762; q=dns/txt; s=iport;
 t=1553021943; x=1554231543;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=D0ic8t9YQG0FE69Ze9uqsg8+HQwii9+DcwRCgK6ja1s=;
 b=coJnZfB/62Yzj16r/Z1N6U1kZeuiz6JHL8B1I6IipkAOWwnFIGObHdHW
 15DbvZu9OG09gfpMexjbXFCu71D61b1bd+2bl/PLjfjwtAHKbEs/6IHeI
 5hZYMGZFCo/SDUyuH8ZZG1YpSe42I2pQDfhmF8rMW4uNs07c8Q+Pz+BDP 8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AHAADCO5Fc/4gNJK1jGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAQGBUwIBAQEBAQsBghBoUDMnl1OCDY4/iXOBewsBASOERAM?=
 =?us-ascii?q?CAoRrIjYHDQEBAwEBCQEDAm0cDIVLAQUyAUYQCxIGCSUPLQ0OBoM2gXUPrAS?=
 =?us-ascii?q?KLxQOgQ0BizEXgUA/gRGDEoMeBBiHKAOKHIIahWaSTQmCS4USi0MlDIFwhXK?=
 =?us-ascii?q?LcIwjhGSNCAIEBgUCFYFNATGBVjMaCBsVO4JsCYINF4hfhV8fAzCNFCqCIwE?=
 =?us-ascii?q?B?=
X-IronPort-AV: E=Sophos;i="5.60,245,1549929600"; d="scan'208";a="537168065"
Received: from alln-core-3.cisco.com ([173.36.13.136])
 by rcdn-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA;
 19 Mar 2019 18:58:56 +0000
Received: from zorba ([10.41.50.85])
 by alln-core-3.cisco.com (8.15.2/8.15.2) with ESMTPS id x2JIws9T032440
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 19 Mar 2019 18:58:56 GMT
Date: Tue, 19 Mar 2019 11:58:56 -0700
From: Daniel Walker <danielwa@cisco.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 2/3] powerpc: convert to generic builtin command line
Message-ID: <20190319185856.zncq3f7naymoeobu@zorba>
References: <1551469472-53043-3-git-send-email-danielwa@cisco.com>
 <e6dc6500-0e33-da0c-c975-0d9125e38c0e@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6dc6500-0e33-da0c-c975-0d9125e38c0e@c-s.fr>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.41.50.85, [10.41.50.85]
X-Outbound-Node: alln-core-3.cisco.com
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: xe-linux-external@cisco.com, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 Maksym Kokhan <maksym.kokhan@globallogic.com>,
 Daniel Walker <dwalker@fifo99.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 04, 2019 at 03:26:59PM +0100, Christophe Leroy wrote:
> 
> 
> Le 01/03/2019 à 20:44, Daniel Walker a écrit :
> > This updates the powerpc code to use the CONFIG_GENERIC_CMDLINE
> > option.
> 
> Please explain more in details how each powerpc option is replaced by one of
> the generic options.

CMDLINE is replace by two options to either which allow static options to either
be appended or prepended to the boot loader arguemnts. If you wanted a lateral
changes you would only fill in CONFIG_CMDLINE_PREPEND. CONFIG_CMDLINE_OVERRIDE
does the same as CMDLINE_FORCE, only with the append and prepend arguemnts
merged without the boot loader arguments.

> > --- a/arch/powerpc/kernel/prom.c
> > +++ b/arch/powerpc/kernel/prom.c
> > @@ -34,6 +34,7 @@
> >   #include <linux/of_fdt.h>
> >   #include <linux/libfdt.h>
> >   #include <linux/cpu.h>
> > +#include <linux/cmdline.h>
> >   #include <asm/prom.h>
> >   #include <asm/rtas.h>
> > @@ -716,6 +717,9 @@ void __init early_init_devtree(void *params)
> >   	 */
> >   	of_scan_flat_dt(early_init_dt_scan_chosen_ppc, boot_command_line);
> > +	/* append and prepend any arguments built into the kernel. */
> > +	cmdline_add_builtin(boot_command_line, NULL, COMMAND_LINE_SIZE);
> > +
> 
> I don't think it is worth an implementation as complex as in the previous
> patch just for the above line.
> Could easily define the temporary buffer in this file directely, then just
> locally do:
> 
> strlcpy(temp_buff, CONFIG_CMDLINE_PREPEND, COMMAND_LINE_SIZE);
> strlcat(temp_buff, boot_command_line, COMMAND_LINE_SIZE);
> strlcat(temp_buff, CONFIG_CMDLINE_APPEND, COMMAND_LINE_SIZE);
> strlcpy(boot_command_line, temp_buff, COMMAND_LINE_SIZE);
 
The point of the code is to have an implementation that other architecture can
use. If we open code it in powerpc we're no better off.

> 
> 
> >   	/* Scan memory nodes and rebuild MEMBLOCKs */
> >   	of_scan_flat_dt(early_init_dt_scan_root, NULL);
> >   	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
> > diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> > index f33ff4163a51..e8e9fca22470 100644
> > --- a/arch/powerpc/kernel/prom_init.c
> > +++ b/arch/powerpc/kernel/prom_init.c
> > @@ -30,6 +30,7 @@
> >   #include <linux/delay.h>
> >   #include <linux/initrd.h>
> >   #include <linux/bitops.h>
> > +#include <linux/cmdline.h>
> >   #include <asm/prom.h>
> >   #include <asm/rtas.h>
> >   #include <asm/page.h>
> > @@ -637,11 +638,10 @@ static void __init early_cmdline_parse(void)
> >   	p = prom_cmd_line;
> >   	if ((long)prom.chosen > 0)
> >   		l = prom_getprop(prom.chosen, "bootargs", p, COMMAND_LINE_SIZE-1);
> > -#ifdef CONFIG_CMDLINE
> > +
> >   	if (l <= 0 || p[0] == '\0') /* dbl check */
> > -		strlcpy(prom_cmd_line,
> > -			CONFIG_CMDLINE, sizeof(prom_cmd_line));
> > -#endif /* CONFIG_CMDLINE */
> > +		cmdline_add_builtin_section(prom_cmd_line, NULL, sizeof(prom_cmd_line), __prombss);
> > +
> 
> You don't need something as complex as what your generic code does for that.
> It could be done with the following simple line:
> 
> strlcpy(prom_cmd_line, CONFIG_CMDLINE_PREPEND " " CONFIG_CMDLINE_APPEND,
> sizeof(prom_cmd_line));
> 
> >   	prom_printf("command line: %s\n", prom_cmd_line);
> >   #ifdef CONFIG_PPC64
> > diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
> > index 667df97d2595..ab2acc8d8b5a 100644
> > --- a/arch/powerpc/kernel/prom_init_check.sh
> > +++ b/arch/powerpc/kernel/prom_init_check.sh
> > @@ -18,7 +18,7 @@
> >   WHITELIST="add_reloc_offset __bss_start __bss_stop copy_and_flush
> >   _end enter_prom memcpy memset reloc_offset __secondary_hold
> > -__secondary_hold_acknowledge __secondary_hold_spinloop __start
> > +__secondary_hold_acknowledge __secondary_hold_spinloop __start strlcat
> 
> The above is a big issue. In the scope of KASAN implementation, we are
> getting rid of generic string functions from prom_init because they are
> KASAN instrumented and that's far too early for prom_init. See series
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=94949 and
> especially patch [v9,03/11] powerpc/prom_init: don't use string functions
> from lib/

You already re-implemented a number of string functions, seem easy enough to add
another one.

What your doing here is exactly what I'm trying to prevent in my implementation.
Say there is a small, but horrific defect in one of the string functions. Some
other architecture fixes it in lib/strings.c , woops , you just missed it and
now prom_init.c is stuck with it unless powerpc maintainers are watching closely
to keep up with the fixes to the string functions.

You could move these functions into the include/linux/string.h as static
inlines, then use them in lib/strings.c and in prom_init.c. Then you have a
unified implementation. I assume you would regard that as ugly tho.

Something else you would regard as ugly , your not adding an #ifdef on KASAN in
prom_init.c for the string functions. If you have that then any buggy string
functions which you may add (or forget to update) would only cause problems
if you had KASAN enabled. That then isolates any problems you cause to only
debug kernels with KASAN enabled, instead of unilaterally all platforms which
use prom_init.c. That would also only increase the size if KASAN is enabled.
Very desirable, but ugly. I think most of us kernel hackers will take the ugly.

#ifdef CONFIG_KASAN
...
#else
#define prom_strcmp strcmp
...
#endif /* !CONFIG_KASAN */ 

(you would have to change arch/powerpc/kernel/prom_init_check.sh , but that
shouldn't be too hard)


Daniel
