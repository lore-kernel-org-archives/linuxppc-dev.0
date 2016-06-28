Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdsD845qHzDqRd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 13:46:16 +1000 (AEST)
Message-ID: <1467085570.32607.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pseries: Auto online hotplugged memory
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>
Date: Tue, 28 Jun 2016 13:46:10 +1000
In-Reply-To: <57713AFD.5040801@linux.vnet.ibm.com>
References: <5767F4D0.7070504@linux.vnet.ibm.com>
 <1466470648.9938.0.camel@ellerman.id.au>
 <5768A2EB.5030808@linux.vnet.ibm.com>
 <1466746547.11831.2.camel@ellerman.id.au>
 <57713AFD.5040801@linux.vnet.ibm.com>
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

On Mon, 2016-06-27 at 09:41 -0500, Nathan Fontenot wrote:
> On 06/24/2016 12:35 AM, Michael Ellerman wrote:
> > On Mon, 2016-06-20 at 21:14 -0500, Nathan Fontenot wrote:
> > > On 06/20/2016 07:57 PM, Michael Ellerman wrote:
> > > > On Mon, 2016-06-20 at 08:51 -0500, Nathan Fontenot wrote:
> > > > 
> > > > > Auto online hotplugged memory
> > > > > 
> > > > > A recent update (commit id 31bc3858ea3) to the core mm hotplug code
> > > > > introduced the memhp_auto_online variable to allow for automatically
> > > > > onlining memory that is added.
> > > > > 
> > > > > This patch update the pseries memory hotplug code to enable this so that
> > > > > any memory DLPAR added to the system is automatically onlined. The code
> > > > > to add the memory block for memory added from add_memory() is removed as
> > > > > this is not needed, the memory_add code does this.
> > > > 
> > > > Is this a bug fix, or just a cleanup?
> > > 
> > > Hmmm.. some cleanup and some new feature. The removal of the memblock_add()
> > > call is a cleanup and the setting of the memhp_auto_online variable is
> > > taking advantage of a feature I was not previously aware of.
> > 
> > OK. Looking at usage of memhp_auto_online it's not clear to me that you're
> > supposed to be setting it in arch code.
> > 
> > eg. if I build my kernel with CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=n, I will
> > expect it to not be onlined by default.
> > 
> > Similarly if I boot with memhp_default_state=offline on the kernel command line.
> > 
> > But this patch would then mean it is onlined by default. So that seems kind of
> > confusing for users.
> 
> Yes, but we already online memory when it is DLPAR added to the system. This has
> always been the default behavior for pseries. I was using the memhp_auto_online
> setting so that the memory will be added as part of the memory_add call instead
> of having to online the memory as a separate step in the pseries code.
> 
> In other words, I am not changing the existing behavior of pseries code. 

Yep, that's good.

What's not good is giving the user an option and then ignoring it.

> Perhaps something a bit different? I could save and restore the memhp_auto_online
> setting across the call to memory_add, or perhpas ther should be an
> add_memory_and_online() variant of the add_memory() call that always onlines memory.
 
No I think we should just honor the setting.

To retain the existing behavour on pseries we just set CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
in the pseries defconfig.

That way users can control the behaviour, which is good, and all the existing
documentation applies equally to powerpc as other arches. If we do something
different, like force onlining it, then we need to go and update all the docs to
say "memhp_auto_online - ignored on powerpc".

cheers
