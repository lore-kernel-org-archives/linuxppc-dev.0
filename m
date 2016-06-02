Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL1R04GlvzDqNq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 19:00:44 +1000 (AEST)
Received: from pps.filterd (m0075771.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u528tPo9035094
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jun 2016 05:00:42 -0400
Message-Id: <201606020900.u528tPo9035094@mx0a-001b2d01.pphosted.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23a7nqpyfu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jun 2016 05:00:42 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Thu, 2 Jun 2016 06:00:40 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 922F3352005C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 05:00:22 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5290bYI27197722
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jun 2016 06:00:37 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5290bKT020406
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jun 2016 06:00:37 -0300
Subject: Re: [PATCH 1/3] powerpc: export cpu_to_core_id()
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <201606012016.u51KDwr8046821@mx0a-001b2d01.pphosted.com>
 <1464853260.19646.6.camel@ellerman.id.au>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Thu, 2 Jun 2016 06:00:34 -0300
MIME-Version: 1.0
In-Reply-To: <1464853260.19646.6.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On 06/02/2016 04:41 AM, Michael Ellerman wrote:
> On Wed, 2016-06-01 at 17:16 -0300, Mauricio Faria de Oliveira wrote:
>
>> Export cpu_to_core_id().  This will be used by the lpfc driver.
>
> Can you explain why?

Yup,

> I would have thought there'd be architecture neutral APIs you can use - and if
> there aren't maybe we should write them.

I actually use topology_core_id() from  <kernel/topology.h> in lpfc [1]
(defined to cpu_to_core_id() by arch/powerpc/include/asm/topology.h).

That is arch-neutral, used by eg /sys/devices/system/cpu/cpu*/topology,
but drivers/base/topology.c is built-in (obj-y in ./Makefile), and thus
didn't need the export.

Thus, since the module uses topology_core_id() and this is defined to
cpu_to_core_id(), it needs the export:

     ERROR: "cpu_to_core_id" [drivers/scsi/lpfc/lpfc.ko] undefined!
     make[1]: *** [__modpost] Error 1
     make: *** [modules] Error 2

Thanks,

[1] http://marc.info/?l=linux-scsi&m=146481382301686

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
