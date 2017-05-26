Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYsWX5FXlzDqMH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 13:46:48 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id u26so43114821pfd.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 20:46:48 -0700 (PDT)
Date: Fri, 26 May 2017 13:46:36 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Bringmann
 <mwb@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Paul Mackerras
 <paulus@samba.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>, Shailendra Singh
 <shailendras@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [Patch 2/2]: powerpc/hotplug/mm: Fix hot-add memory node assoc
Message-ID: <20170526134636.03548feb@firefly.ozlabs.ibm.com>
In-Reply-To: <20170525151011.m4ae4ipxbqsj3mn7@arbab-laptop.localdomain>
References: <3bb44d92-b2ff-e197-4bdf-ec6d588d6dab@linux.vnet.ibm.com>
 <20170523155251.bqwc5mc4jpgzkqlm@arbab-laptop.localdomain>
 <1c1d70e3-4e45-b035-0e75-1b0f531c111b@linux.vnet.ibm.com>
 <20170523214922.bns675oqzqj4pkhc@arbab-laptop.localdomain>
 <ee96df3d-ad0f-c4dc-e7d5-290018ec8afd@linux.vnet.ibm.com>
 <87poeya4dt.fsf@concordia.ellerman.id.au>
 <8e2417d8-d108-2949-40f2-997d53a3f367@linux.vnet.ibm.com>
 <87a861a25y.fsf@concordia.ellerman.id.au>
 <20170525151011.m4ae4ipxbqsj3mn7@arbab-laptop.localdomain>
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

On Thu, 25 May 2017 10:10:11 -0500
Reza Arbab <arbab@linux.vnet.ibm.com> wrote:

> On Thu, May 25, 2017 at 04:19:53PM +1000, Michael Ellerman wrote:
> >The commit message for 3af229f2071f says:
> >
> >    In practice, we never see a system with 256 NUMA nodes, and in fact, we
> >    do not support node hotplug on power in the first place, so the nodes
> >    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >    that are online when we come up are the nodes that will be present for
> >    the lifetime of this kernel.
> >
> >Is that no longer true?  
> 
> I don't know what the reasoning behind that statement was at the time, 
> but as far as I can tell, the only thing missing for node hotplug now is 
> Balbir's patchset [1]. He fixes the resource issue which motivated 
> 3af229f2071f and reverts it.
> 
> With that set, I can instantiate a new numa node just by doing 
> add_memory(nid, ...) where nid doesn't currently exist.
> 
> [1] https://lkml.kernel.org/r/1479253501-26261-1-git-send-email-bsingharora@gmail.com
> 

I guess I should try and revive that patchset. One of the suggestions of
then was to limit maximum possible nodes in firmware, but I'm double checking
to see if we can do that in a well defined manner.

Balbir Singh
