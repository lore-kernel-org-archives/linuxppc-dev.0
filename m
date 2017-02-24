Return-Path: <vkuznets@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vVHZJ449RzDqH1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2017 04:06:32 +1100 (AEDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linux-mm@kvack.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 mdroth@linux.vnet.ibm.com, kys@microsoft.com
Subject: Re: [RFC PATCH] memory-hotplug: Use dev_online for memhp_auto_offline
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
 <20170224165224.GA9363@dhcp22.suse.cz>
Date: Fri, 24 Feb 2017 18:06:28 +0100
In-Reply-To: <20170224165224.GA9363@dhcp22.suse.cz> (Michal Hocko's message of
 "Fri, 24 Feb 2017 17:52:25 +0100")
Message-ID: <87poi7wmaz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michal Hocko <mhocko@kernel.org> writes:

> On Fri 24-02-17 17:40:25, Vitaly Kuznetsov wrote:
>> Michal Hocko <mhocko@kernel.org> writes:
>> 
>> > On Fri 24-02-17 17:09:13, Vitaly Kuznetsov wrote:
> [...]
>> >> While this will most probably work for me I still disagree with the
>> >> concept of 'one size fits all' here and the default 'false' for ACPI,
>> >> we're taking away the feature from KVM/Vmware folks so they'll again
>> >> come up with the udev rule which has known issues.
>> >
>> > Well, AFAIU acpi_memory_device_add is a standard way how to announce
>> > physical memory added to the system. Where does the KVM/VMware depend on
>> > this to do memory ballooning?
>> 
>> As far as I understand memory hotplug in KVM/VMware is pure ACPI memory
>> hotplug, there is no specific code for it.
>
> VMware has its ballooning driver AFAIK and I have no idea what KVM
> uses.

They both have ballooning drivers but ballooning is a different
thing. BTW, both Xen and Hyper-V have ballooning too but it is a
different thing, we're not discussing it here.

> Anyway, acpi_memory_device_add is no different from doing a physical
> memory hotplug IIUC so there shouldn't be any difference to how it is
> handled.

With the patch you suggest we'll have different memory hotplug defaults
for different virtualization technologies. If you suggest to have
unconditional default online it should probably be the save for all
hypervisors we support (IMO).

-- 
  Vitaly
