Return-Path: <bsingharora@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40q8d3416TzF0wQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 16:53:43 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id 30-v6so8212570pld.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 23:53:42 -0700 (PDT)
Date: Mon, 21 May 2018 16:53:32 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: Failure to allocate HTAB for guest - CMA allocation failures?
Message-ID: <20180521165332.5b2ff78e@balbir.ozlabs.ibm.com>
In-Reply-To: <87zi0ye2n8.fsf@linkitivity.dja.id.au>
References: <87zi0ye2n8.fsf@linkitivity.dja.id.au>
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

On Fri, 18 May 2018 01:13:31 +1000
Daniel Axtens <dja@axtens.net> wrote:

> I noticed from [1] that there is a patch from Balbir that apparently
> helps when VFIO is used - 2e5bbb5461f1 ("KVM: PPC: Book3S HV: Migrate
> pinned pages out of CMA"). The user is running a 4.4 kernel with this
> backported.

Hmm.. there are two possible scenarios

1. We got movable allocations in the CMA region, these should be migrated 
out on their own
2. We've got pinned allocations in the CMA region and hence movable won't
work with them. We do have trace events for cma_alloc/cma_release if you
want to look them.

Your right in that we'll try to allocate 128 MB from
the CMA region (based on the 1/128th calculation that I remember). If we
can figure out what's allocated memory in the CMA region we can debug
this further. Do the sum of HPT allocations add up to the used CMA memory?

Balbir Singh.
