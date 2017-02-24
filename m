Return-Path: <mhocko@kernel.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vVHG60WjKzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2017 03:52:30 +1100 (AEDT)
Date: Fri, 24 Feb 2017 17:52:25 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linux-mm@kvack.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 mdroth@linux.vnet.ibm.com, kys@microsoft.com
Subject: Re: [RFC PATCH] memory-hotplug: Use dev_online for memhp_auto_offline
Message-ID: <20170224165224.GA9363@dhcp22.suse.cz>
References: <20170223174106.GB13822@dhcp22.suse.cz>
 <87tw7kydto.fsf@vitty.brq.redhat.com>
 <20170224133714.GH19161@dhcp22.suse.cz>
 <87efyny90q.fsf@vitty.brq.redhat.com>
 <20170224144147.GJ19161@dhcp22.suse.cz>
 <87a89by6hd.fsf@vitty.brq.redhat.com>
 <20170224153227.GL19161@dhcp22.suse.cz>
 <8760jzy3iu.fsf@vitty.brq.redhat.com>
 <20170224162317.GN19161@dhcp22.suse.cz>
 <871suny22u.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <871suny22u.fsf@vitty.brq.redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri 24-02-17 17:40:25, Vitaly Kuznetsov wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> 
> > On Fri 24-02-17 17:09:13, Vitaly Kuznetsov wrote:
[...]
> >> While this will most probably work for me I still disagree with the
> >> concept of 'one size fits all' here and the default 'false' for ACPI,
> >> we're taking away the feature from KVM/Vmware folks so they'll again
> >> come up with the udev rule which has known issues.
> >
> > Well, AFAIU acpi_memory_device_add is a standard way how to announce
> > physical memory added to the system. Where does the KVM/VMware depend on
> > this to do memory ballooning?
> 
> As far as I understand memory hotplug in KVM/VMware is pure ACPI memory
> hotplug, there is no specific code for it.

VMware has its ballooning driver AFAIK and I have no idea what KVM uses.
Anyway, acpi_memory_device_add is no different from doing a physical
memory hotplug IIUC so there shouldn't be any difference to how it is
handled.

I will post the patch as an RFC sometimes next week, let's see what
others think about it.
-- 
Michal Hocko
SUSE Labs
