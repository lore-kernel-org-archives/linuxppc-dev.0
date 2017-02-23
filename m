Return-Path: <vkuznets@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTZrb57j8zDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 00:31:27 +1100 (AEDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linux-mm@kvack.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 mdroth@linux.vnet.ibm.com
Subject: Re: [RFC PATCH] memory-hotplug: Use dev_online for memhp_auto_offline
References: <20170221172234.8047.33382.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <878toy1sgd.fsf@vitty.brq.redhat.com>
 <20170223125643.GA29064@dhcp22.suse.cz>
Date: Thu, 23 Feb 2017 14:31:24 +0100
In-Reply-To: <20170223125643.GA29064@dhcp22.suse.cz> (Michal Hocko's message
 of "Thu, 23 Feb 2017 13:56:43 +0100")
Message-ID: <87bmttyqxf.fsf@vitty.brq.redhat.com>
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

> On Wed 22-02-17 10:32:34, Vitaly Kuznetsov wrote:
> [...]
>> > There is a workaround in that a user could online the memory or have
>> > a udev rule to online the memory by using the sysfs interface. The
>> > sysfs interface to online memory goes through device_online() which
>> > should updated the dev->offline flag. I'm not sure that having kernel
>> > memory hotplug rely on userspace actions is the correct way to go.
>> 
>> Using udev rule for memory onlining is possible when you disable
>> memhp_auto_online but in some cases it doesn't work well, e.g. when we
>> use memory hotplug to address memory pressure the loop through userspace
>> is really slow and memory consuming, we may hit OOM before we manage to
>> online newly added memory.
>
> How does the in-kernel implementation prevents from that?
>

Onlining memory on hot-plug is much more reliable, e.g. if we were able
to add it in add_memory_resource() we'll also manage to online it. With
udev rule we may end up adding many blocks and then (as udev is
asynchronous) failing to online any of them. In-kernel operation is
synchronous.

>> In addition to that, systemd/udev folks
>> continuosly refused to add this udev rule to udev calling it stupid as
>> it actually is an unconditional and redundant ping-pong between kernel
>> and udev.
>
> This is a policy and as such it doesn't belong to the kernel. The whole
> auto-enable in the kernel is just plain wrong IMHO and we shouldn't have
> merged it.

I disagree.

First of all it's not a policy, it is a default. We have many other
defaults in kernel. When I add a network card or a storage, for example,
I don't need to go anywhere and 'enable' it before I'm able to use
it from userspace. An for memory (and CPUs) we, for some unknown reason
opted for something completely different. If someone is plugging new
memory into a box he probably wants to use it, I don't see much value in
waiting for a special confirmation from him. 

Second, this feature is optional. If you want to keep old behavior just
don't enable it.

Third, this solves real world issues. With Hyper-V it is very easy to
show udev failing on stress. No other solution to the issue was ever
suggested.

-- 
  Vitaly
