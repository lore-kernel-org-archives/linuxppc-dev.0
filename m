Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rbRrT3fHYzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 15:35:53 +1000 (AEST)
Message-ID: <1466746547.11831.2.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pseries: Auto online hotplugged memory
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>
Date: Fri, 24 Jun 2016 15:35:47 +1000
In-Reply-To: <5768A2EB.5030808@linux.vnet.ibm.com>
References: <5767F4D0.7070504@linux.vnet.ibm.com>
 <1466470648.9938.0.camel@ellerman.id.au>
 <5768A2EB.5030808@linux.vnet.ibm.com>
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

On Mon, 2016-06-20 at 21:14 -0500, Nathan Fontenot wrote:
> On 06/20/2016 07:57 PM, Michael Ellerman wrote:
> > On Mon, 2016-06-20 at 08:51 -0500, Nathan Fontenot wrote:
> > 
> > > Auto online hotplugged memory
> > > 
> > > A recent update (commit id 31bc3858ea3) to the core mm hotplug code
> > > introduced the memhp_auto_online variable to allow for automatically
> > > onlining memory that is added.
> > > 
> > > This patch update the pseries memory hotplug code to enable this so that
> > > any memory DLPAR added to the system is automatically onlined. The code
> > > to add the memory block for memory added from add_memory() is removed as
> > > this is not needed, the memory_add code does this.
> > 
> > Is this a bug fix, or just a cleanup?
> 
> Hmmm.. some cleanup and some new feature. The removal of the memblock_add()
> call is a cleanup and the setting of the memhp_auto_online variable is
> taking advantage of a feature I was not previously aware of.

OK. Looking at usage of memhp_auto_online it's not clear to me that you're
supposed to be setting it in arch code.

eg. if I build my kernel with CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=n, I will
expect it to not be onlined by default.

Similarly if I boot with memhp_default_state=offline on the kernel command line.

But this patch would then mean it is onlined by default. So that seems kind of
confusing for users.

I think instead we should be merging the bulk of this patch, but without the
forced assignment to memhp_auto_online?

cheers
