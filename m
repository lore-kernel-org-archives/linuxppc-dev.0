Return-Path: <srs0=y5bh=7g=au1.ibm.com=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNqYq2JRTzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 11:47:43 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xNqYq1Y04z8sZm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 11:47:43 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xNqYp52kxz9sPt
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Aug 2017 11:47:42 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v741j7Mm141228
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2017 21:47:40 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c4bxd7p8k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 03 Aug 2017 21:47:40 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Fri, 4 Aug 2017 11:47:37 +1000
Subject: Re: [PATCH 1/4] powerpc/prom: avoid endian conversions for linux,
 memory-limit node
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Hari Bathini <hbathini@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>
Cc: sjitindarsingh@gmail.com, Paul Mackerras <paulus@samba.org>,
 ben@codiert.org, Michael Ellerman <mpe@ellerman.id.au>, Anton Blanchard
 <anton@ozlabs.org>, stable@vger.kernel.org
Date: Fri, 04 Aug 2017 11:47:32 +1000
In-Reply-To: <1501810658.2664.60.camel@kernel.crashing.org>
References: <150175227508.9806.17545018023658850483.stgit@hbathini.in.ibm.com>
 <1501810658.2664.60.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1501811252.2664.66.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-08-04 at 11:37 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2017-08-03 at 14:54 +0530, Hari Bathini wrote:
> > As linux,memory-limit node is set and also later used by the kernel,
> > avoid endian conversions for this property.
> > 
> > Fixes: 493adffcb43f ("powerpc: Make prom_init.c endian safe")
> > Cc: stable@vger.kernel.org # 3.12+
> > Cc: Anton Blanchard <anton@ozlabs.org>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kernel/prom_init.c |    3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> > index 613f79f..723df83 100644
> > --- a/arch/powerpc/kernel/prom_init.c
> > +++ b/arch/powerpc/kernel/prom_init.c
> > @@ -3180,9 +3180,8 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
> >  	 * Fill in some infos for use by the kernel later on
> >  	 */
> >  	if (prom_memory_limit) {
> > -		__be64 val = cpu_to_be64(prom_memory_limit);
> >  		prom_setprop(prom.chosen, "/chosen", "linux,memory-limit",
> > -			     &val, sizeof(val));
> > +			     &prom_memory_limit, sizeof(prom_memory_limit));
> >  	}
> >  #ifdef CONFIG_PPC64
> >  	if (prom_iommu_off)
> 
> NACK. The device-tree is big endian by convention

Also that probably breaks kexec.

Cheers,
Ben.
