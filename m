Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF8C21A0B86
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 16:06:51 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 15 Apr 2015 16:06:49 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 34FAB2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 16:06:46 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3F66bkA59637924
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 16:06:46 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3F66Bxu002488
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 16:06:12 +1000
Message-ID: <552DFFC1.6050806@linux.vnet.ibm.com>
Date: Wed, 15 Apr 2015 11:35:53 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 3/3] powerpc/powernv: Introduce sysfs control for
 fastsleep workaround behavior
References: <1428976613-13007-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1428976613-13007-4-git-send-email-shreyas@linux.vnet.ibm.com>
 <552CCF5E.5040201@linux.vnet.ibm.com>
In-Reply-To: <552CCF5E.5040201@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> 
> A point that bothers me here is if we can potentially race with cpu
> hotplug ? If cpuX and its siblings are offline and it was interrupted to
> come online:
> 
> cpuX                                     cpuY
> Interrupted to come online
> Undo workaround
> 
>                                 Nop the fastsleep_workaround_exit path
>                                 IPI online cores: apply workaround once
> 
> Set yourself in the online mask
>                                 Nop the fastsleep_workaround_entry path
> 
> 
> This results in cpuX undoing the workaround on its core, never to set it
> back again.
> 
> So should we protect the region between the beginning and end of
> patching instructions with get_online_cpus() and put_online_cpus() ?
> 

Nice catch. I had missed this. Sending out a patch correcting this.

Thanks,
Shreyas
