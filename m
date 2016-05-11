Return-Path: <arbab@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4qYw1qdwzDqDJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 07:50:59 +1000 (AEST)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Wed, 11 May 2016 15:50:57 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 3B2F53E40041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 15:50:54 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4BLosv545219944
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 14:50:54 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4BLor7D028181
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 15:50:54 -0600
Date: Wed, 11 May 2016 16:50:51 -0500
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Bharata B Rao <bharata.rao@gmail.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc,numa: Memory hotplug to memory-less nodes ?
Message-ID: <20160511215051.GF22115@arbab-laptop.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <CAGZKiBrmkSa1yyhbf5hwGxubcjsE5SmkSMY4tpANERMe2UG4bg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 22, 2015 at 10:18:43AM +0530, Bharata B Rao wrote:
>While developing memory hotplug support in QEMU for PoweKVM, I
>realized that guest kernel has specific checks to prevent hot addition
>of memory to a memory-less node.
>
>I am referring to arch/powerpc/mm/numa.c:hot_add_scn_to_nid() which
>has explicit checks to ensure that it returns a nid that has some some
>memory (NODE_DATA(nid)->node_spanned_pages) even when user wants to
>hotplug to a node that currently has zero memory.
>
>Is this limitation by design ?

Sorry to resurrect such an old thread, but did anything come of this?

I've recently bumped into the same limitation. Could we consider 
removing it?

(I couldn't find the original distribution list for this thread. Please 
add whomever is appropriate to the Cc:)

-- 
Reza Arbab
