Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0558F1A06A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 22:13:44 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 24 Jun 2015 08:13:41 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id B6D076E803F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 08:05:24 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5OCDcv064421984
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 12:13:38 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5OCDbXd022109
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 08:13:37 -0400
Message-ID: <558A9EF0.3010305@linux.vnet.ibm.com>
Date: Wed, 24 Jun 2015 07:13:36 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Bharata B Rao <bharata.rao@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@au1.ibm.com>
Subject: Re: powerpc,numa: Memory hotplug to memory-less nodes ?
References: <CAGZKiBrmkSa1yyhbf5hwGxubcjsE5SmkSMY4tpANERMe2UG4bg@mail.gmail.com>
 <CAGZKiBpWtPKLR+P_gQ8LguS7p4sZt4EvyNqCW_7t8NovGmNpPg@mail.gmail.com>
In-Reply-To: <CAGZKiBpWtPKLR+P_gQ8LguS7p4sZt4EvyNqCW_7t8NovGmNpPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/23/2015 11:01 PM, Bharata B Rao wrote:
> So will it be correct to say that memory hotplug to memory-less node
> isn't supported by PowerPC kernel ? Should I enforce the same in QEMU
> for PowerKVM ?
>

I'm not sure if that is correct. It appears that we initialize all online
nodes, even those without spanned_pages, at boot time. This occurs
in setup_node_data() called from initmem_init().

Looking at this I would think that we could add memory to any online node
even if it does not have any spanned_pages. I think an interesting test
we be to check for the node being online instead of checking to see if
it has any memory.

-Nathan

> On Mon, Jun 22, 2015 at 10:18 AM, Bharata B Rao <bharata.rao@gmail.com> wrote:
>> Hi,
>>
>> While developing memory hotplug support in QEMU for PoweKVM, I
>> realized that guest kernel has specific checks to prevent hot addition
>> of memory to a memory-less node.
>>
>> I am referring to arch/powerpc/mm/numa.c:hot_add_scn_to_nid() which
>> has explicit checks to ensure that it returns a nid that has some some
>> memory (NODE_DATA(nid)->node_spanned_pages) even when user wants to
>> hotplug to a node that currently has zero memory.
>>
>> Is this limitation by design ?
>>
>> Regards,
>> Bharata.
>> --
>> http://raobharata.wordpress.com/
> 
> 
> 
