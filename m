Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL48R3YGyzDqlp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 21:03:19 +1000 (AEST)
Message-ID: <1464865393.11826.0.camel@ellerman.id.au>
Subject: Re: [PATCH 1/3] powerpc: export cpu_to_core_id()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Thu, 02 Jun 2016 21:03:13 +1000
In-Reply-To: <201606020900.u528tQHH025445@mx0a-001b2d01.pphosted.com>
References: <201606012016.u51KDwr8046821@mx0a-001b2d01.pphosted.com>
 <1464853260.19646.6.camel@ellerman.id.au>
 <201606020900.u528tQHH025445@mx0a-001b2d01.pphosted.com>
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

On Thu, 2016-06-02 at 06:00 -0300, Mauricio Faria de Oliveira wrote:
> Hi Michael,
> On 06/02/2016 04:41 AM, Michael Ellerman wrote:
> > On Wed, 2016-06-01 at 17:16 -0300, Mauricio Faria de Oliveira wrote:

> > > Export cpu_to_core_id().  This will be used by the lpfc driver.
> > 
> > Can you explain why?
> 
> Yup,

> > I would have thought there'd be architecture neutral APIs you can use - and if
> > there aren't maybe we should write them.
> 
> I actually use topology_core_id() from  <kernel/topology.h> in lpfc [1]
> (defined to cpu_to_core_id() by arch/powerpc/include/asm/topology.h).
> 
> That is arch-neutral, used by eg /sys/devices/system/cpu/cpu*/topology,
> but drivers/base/topology.c is built-in (obj-y in ./Makefile), and thus
> didn't need the export.
> 
> Thus, since the module uses topology_core_id() and this is defined to
> cpu_to_core_id(), it needs the export:
> 
>      ERROR: "cpu_to_core_id" [drivers/scsi/lpfc/lpfc.ko] undefined!
>      make[1]: *** [__modpost] Error 1
>      make: *** [modules] Error 2

Thanks.

Can you send me a v2 with a change log that includes all that detail.

cheers
