Return-Path: <srs0=kspq=4c=suse.de=msuchanek@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wCj2L4fVYzDqC4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 00:22:02 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wCj2L3Hxcz8sxx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 00:22:02 +1000 (AEST)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wCj2K6bBZz9s2P
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2017 00:22:00 +1000 (AEST)
Date: Wed, 26 Apr 2017 16:21:53 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>, Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/2] powerpc/fadump: reduce memory consumption for
 capture kernel
Message-ID: <20170426162153.1bc4fc01@kitsune.suse.cz>
In-Reply-To: <149319210065.14869.5547128856388591456.stgit@hbathini.in.ibm.com>
References: <149319210065.14869.5547128856388591456.stgit@hbathini.in.ibm.com>
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

Hello,

On Wed, 26 Apr 2017 13:05:20 +0530
Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:

> With fadump (dump capture) kernel booting like a regular kernel, it
> almost needs the same amount of memory to boot as the production
> kernel, which is unwarranted for a dump capture kernel. But with no
> option to disable some of the unnecessary subsystems in fadump
> kernel, that much memory is wasted on fadump, depriving the
> production kernel of that memory.
> 
> Introduce kernel parameter 'fadump_append=' that would take regular
> kernel parameters as a comma separated list, to be enforced when
> fadump is active. This 'fadump_append=' parameter can be leveraged to
> pass parameters like nr_cpus=1, cgroup_disable=memory and numa=off,
> to disable unwarranted resources/subsystems.

According to Linux admin guide at
Documentation/admin-guide/kernel-parameters.{rst,txt}

there are arguments like isolcpus=1,2,10-20,100-2000:2/25
baycom_ser_hdx=<io>,<irq>,<mode> or console=ttyUSB0[,options] that
include a comma. On the other hand, same guide suggests that parameters
can be quoted param="spaces in here". 

So I think it would be more sensible to document the existing quoting
mechanism in the fadump_append option documentation rather than
inventing your own that is incompatible with some existing options.

Thanks

Michal
