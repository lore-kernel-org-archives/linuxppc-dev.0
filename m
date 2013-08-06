Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0248.outbound.messaging.microsoft.com [213.199.154.248])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2380E2C0077
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 10:10:17 +1000 (EST)
Message-ID: <1375747806.13074.106.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 7/8] powerpc/fsl_booke: make sure PAGE_OFFSET map to
 memstart_addr for relocatable kernel
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Mon, 5 Aug 2013 19:10:06 -0500
In-Reply-To: <20130804005035.GE19141@pek-khao-d1.corp.ad.wrs.com>
References: <1372942454-25191-1-git-send-email-haokexin@gmail.com>
 <1372942454-25191-8-git-send-email-haokexin@gmail.com>
 <1374884277.30721.39@snotra>
 <20130804005035.GE19141@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-08-04 at 08:50 +0800, Kevin Hao wrote:
> On Fri, Jul 26, 2013 at 07:17:57PM -0500, Scott Wood wrote:
> > >diff --git a/arch/powerpc/mm/fsl_booke_mmu.c
> > >b/arch/powerpc/mm/fsl_booke_mmu.c
> > >index 8f60ef8..dd283fd 100644
> > >--- a/arch/powerpc/mm/fsl_booke_mmu.c
> > >+++ b/arch/powerpc/mm/fsl_booke_mmu.c
> > >@@ -224,7 +224,7 @@ void __init adjust_total_lowmem(void)
> > >
> > > 	i = switch_to_as1();
> > > 	__max_low_memory = map_mem_in_cams(ram, CONFIG_LOWMEM_CAM_NUM);
> > >-	restore_to_as0(i);
> > >+	restore_to_as0(i, 0, 0);
> > 
> > The device tree virtual address is zero?
> 
> No. But if the __pa(PAGE_OFFSET in AS0) is equal to __pa(PAGE_OFFSET in AS1),
> that mean we don't need to do another relocation and the device tree virtual
> address is useless in this case.

The documentation of restore_to_as0() should make it clear that r5 is
ignored if r4 is zero.

-Scott
