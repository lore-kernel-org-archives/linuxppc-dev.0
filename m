Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F2D231A045E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 10:02:31 +1100 (AEDT)
In-Reply-To: <56BB6FB9.2020701@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [3/3] powerpc/pseries: Cleanup property cloning in memory dlpar
Message-Id: <20160301230231.DA2A81402D8@ozlabs.org>
Date: Wed,  2 Mar 2016 10:02:31 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-10-02 at 17:13:29 UTC, Nathan Fontenot wrote:
> Now that the DLPAR add/remove flow updates the ibm,dynamic-memory device
> tree property each time we add or remove a LMB the work needed to clone
> this property can be reduced.
> 
> Prior to performing any memory DLPAR operation we now clone the device
> tree property once and convert it to cpu format. This copy is then used
> to walk through LMBs as we process them and is thrown away when we
> are finished. There is no longer a need to convert the entire property to
> cpu format and then back to BE every time we update it, we can just parse
> it in its native BE format and update the one LMB we need to modify
> before updating the property.
> 
> This patch removes the BE => cpu conversion step in the clone routine and
> creates a drconf_property_to_cpu() routine to make this conversion for the
> one time we need to convert the entire property. This then allows us
> to remove dlpar_update_drconf_property() since we can now do everything
> in dlpar_update_device_tree_lmb().

Hi Nathan,

This sounds like a good cleanup on the face of it.

But even with it applied I still see a boat load of endian errors from sparse
in this file. That worries me, can you please try and fix them.

  arch/powerpc/platforms/pseries/hotplug-memory.c:121:20: warning: cast to restricted __be32
  arch/powerpc/platforms/pseries/hotplug-memory.c:126:38: warning: cast to restricted __be32
  arch/powerpc/platforms/pseries/hotplug-memory.c:129:39: warning: incorrect type in assignment (different base types)
  arch/powerpc/platforms/pseries/hotplug-memory.c:129:39:    expected unsigned int [unsigned] [usertype] flags
  arch/powerpc/platforms/pseries/hotplug-memory.c:129:39:    got restricted __be32 [usertype] <noident>
  arch/powerpc/platforms/pseries/hotplug-memory.c:130:42: warning: incorrect type in assignment (different base types)
  arch/powerpc/platforms/pseries/hotplug-memory.c:130:42:    expected unsigned int [unsigned] [usertype] aa_index
  arch/powerpc/platforms/pseries/hotplug-memory.c:130:42:    got restricted __be32 [usertype] <noident>
  arch/powerpc/platforms/pseries/hotplug-memory.c:188:21: warning: cast to restricted __be32
  arch/powerpc/platforms/pseries/hotplug-memory.c:189:28: warning: cast to restricted __be32
  arch/powerpc/platforms/pseries/hotplug-memory.c:296:16: warning: cast to restricted __be64
  arch/powerpc/platforms/pseries/hotplug-memory.c:615:33: warning: cast to restricted __be32
  arch/powerpc/platforms/pseries/hotplug-memory.c:675:14: warning: cast to restricted __be32
  arch/powerpc/platforms/pseries/hotplug-memory.c:681:37: warning: cast to restricted __be64
  arch/powerpc/platforms/pseries/hotplug-memory.c:682:37: warning: cast to restricted __be32
  arch/powerpc/platforms/pseries/hotplug-memory.c:683:33: warning: cast to restricted __be32
  arch/powerpc/platforms/pseries/hotplug-memory.c:694:15: warning: incorrect type in assignment (different base types)
  arch/powerpc/platforms/pseries/hotplug-memory.c:694:15:    expected unsigned int [unsigned] [usertype] count
  arch/powerpc/platforms/pseries/hotplug-memory.c:694:15:    got restricted __be32 [usertype] drc_count
  arch/powerpc/platforms/pseries/hotplug-memory.c:695:19: warning: incorrect type in assignment (different base types)
  arch/powerpc/platforms/pseries/hotplug-memory.c:695:19:    expected unsigned int [unsigned] [usertype] drc_index
  arch/powerpc/platforms/pseries/hotplug-memory.c:695:19:    got restricted __be32 [usertype] drc_index
  arch/powerpc/platforms/pseries/hotplug-memory.c:766:16: warning: cast to restricted __be64
  arch/powerpc/platforms/pseries/hotplug-memory.c:808:22: warning: cast to restricted __be32
  arch/powerpc/platforms/pseries/hotplug-memory.c:809:24: warning: cast to restricted __be32
  arch/powerpc/platforms/pseries/hotplug-memory.c:811:33: warning: cast to restricted __be64
  arch/powerpc/platforms/pseries/hotplug-memory.c:814:31: warning: cast to restricted __be32
  arch/powerpc/platforms/pseries/hotplug-memory.c:816:30: warning: cast to restricted __be32
  arch/powerpc/platforms/pseries/hotplug-memory.c:818:43: warning: cast to restricted __be64


I think the problem is you're using one type, struct of_drconf_cell, to hold
both BE and LE data, but at different times. That may be OK if you do the
conversions exactly right, but it is highly error prone, and also confuses the
checker, so is best avoided.

So we can either say that of_drconf_cell holds the device tree representation,
in which case it should use __be64/__be32, or we say that it holds the cpu
endian representation, in which case it stays as is.

My preference would be the latter, and we create an accessor which does the
conversion in exactly one place, ie. something like:

void of_property_read_drconf_cell(const struct property *p,
                                 struct of_drconf_cell *result)
{
       struct {
               __be64 base_addr;
               __be32 drc_index;
               __be32 reserved;
               __be32 aa_index;
               __be32 flags;
       } *s = (void *)p->value;

       result->base_addr = be64_to_cpu(s->base_addr);
       result->drc_index = be32_to_cpu(s->base_addr);
       result->reserved = be32_to_cpu(s->reserved);
       result->aa_index = be32_to_cpu(s->aa_index);
       result->flags = be32_to_cpu(s->flags);
}

cheers
