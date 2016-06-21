Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYn6d3BQ4zDqDN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 22:27:21 +1000 (AEST)
In-Reply-To: <201606021145.u52Behar021447@mx0a-001b2d01.pphosted.com>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v2] powerpc: export cpu_to_core_id()
Message-Id: <3rYn6d0tldz9t0Y@ozlabs.org>
Date: Tue, 21 Jun 2016 22:27:20 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-02-06 at 11:45:14 UTC, Mauricio Faria de Oliveira wrote:
> Export cpu_to_core_id().  This will be used by the lpfc driver.
> 
> This enables topology_core_id() from  <linux/topology.h> (defined
> to cpu_to_core_id() in arch/powerpc/include/asm/topology.h) to be
> used by (non-builtin) modules.
> 
> That is arch-neutral, already used by eg, drivers/base/topology.c,
> but it is builtin (obj-y in Makefile) thus didn't need the export.
> 
> Since the module uses topology_core_id() and this is defined to
> cpu_to_core_id(), it needs the export, otherwise:
> 
>     ERROR: "cpu_to_core_id" [drivers/scsi/lpfc/lpfc.ko] undefined!
> 
> Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f8ab481066e7246e4b272233aa

cheers
