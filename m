Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8B50A1A072B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2015 01:33:36 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 25 Jun 2015 11:33:34 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 7B34A6E803F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 11:25:17 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5PFXU8f63373380
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 15:33:31 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5PFXUYH001682
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 11:33:30 -0400
Date: Thu, 25 Jun 2015 08:33:28 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: Bharata B Rao <bharata.rao@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Anton Blanchard <anton@au1.ibm.com>, Paul Mackerras <paulus@samba.org>
Subject: Re: powerpc,numa: Memory hotplug to memory-less nodes ?
Message-ID: <20150625153328.GA5319@linux.vnet.ibm.com>
References: <CAGZKiBrmkSa1yyhbf5hwGxubcjsE5SmkSMY4tpANERMe2UG4bg@mail.gmail.com>
 <CAGZKiBpWtPKLR+P_gQ8LguS7p4sZt4EvyNqCW_7t8NovGmNpPg@mail.gmail.com>
 <558A9EF0.3010305@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <558A9EF0.3010305@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 24.06.2015 [07:13:36 -0500], Nathan Fontenot wrote:
> On 06/23/2015 11:01 PM, Bharata B Rao wrote:
> > So will it be correct to say that memory hotplug to memory-less node
> > isn't supported by PowerPC kernel ? Should I enforce the same in QEMU
> > for PowerKVM ?
> >
> 
> I'm not sure if that is correct. It appears that we initialize all online
> nodes, even those without spanned_pages, at boot time. This occurs
> in setup_node_data() called from initmem_init().
> 
> Looking at this I would think that we could add memory to any online node
> even if it does not have any spanned_pages. I think an interesting test
> we be to check for the node being online instead of checking to see if
> it has any memory.

I see no *technical* reason we should't be able to hotplug to an
initially memoryless node. I'm not sure it happens in practice under
PowerVM (where we have far less control of the topology anyways). One
aspect of this that I have on my todo list is seeing what SLUB does when
a node goes from memoryless to populated -- as during boot memoryless
nodes get a 'useless' per node structure (early_kmem_cache_node_alloc).

I can look at this a bit under KVM maybe later this week myself to see
what happens in a guest.

-Nish
