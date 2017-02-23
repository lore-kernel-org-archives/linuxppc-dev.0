Return-Path: <vkuznets@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTj7D39PGzDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 05:14:32 +1100 (AEDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linux-mm@kvack.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 mdroth@linux.vnet.ibm.com, kys@microsoft.com
Subject: Re: [RFC PATCH] memory-hotplug: Use dev_online for memhp_auto_offline
References: <20170221172234.8047.33382.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <878toy1sgd.fsf@vitty.brq.redhat.com>
 <20170223125643.GA29064@dhcp22.suse.cz>
 <87bmttyqxf.fsf@vitty.brq.redhat.com>
 <20170223150920.GB29056@dhcp22.suse.cz>
 <877f4gzz4d.fsf@vitty.brq.redhat.com>
 <20170223161241.GG29056@dhcp22.suse.cz>
 <8737f4zwx5.fsf@vitty.brq.redhat.com>
 <20170223174106.GB13822@dhcp22.suse.cz>
Date: Thu, 23 Feb 2017 19:14:27 +0100
In-Reply-To: <20170223174106.GB13822@dhcp22.suse.cz> (Michal Hocko's message
 of "Thu, 23 Feb 2017 18:41:07 +0100")
Message-ID: <87tw7kydto.fsf@vitty.brq.redhat.com>
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

> On Thu 23-02-17 17:36:38, Vitaly Kuznetsov wrote:
>> Michal Hocko <mhocko@kernel.org> writes:
> [...]
>> > Is a grow from 256M -> 128GB really something that happens in real life?
>> > Don't get me wrong but to me this sounds quite exaggerated. Hotmem add
>> > which is an operation which has to allocate memory has to scale with the
>> > currently available memory IMHO.
>> 
>> With virtual machines this is very real and not exaggerated at
>> all. E.g. Hyper-V host can be tuned to automatically add new memory when
>> guest is running out of it. Even 100 blocks can represent an issue.
>
> Do you have any reference to a bug report. I am really curious because
> something really smells wrong and it is not clear that the chosen
> solution is really the best one.

Unfortunately I'm not aware of any publicly posted bug reports (CC:
K. Y. - he may have a reference) but I think I still remember everything
correctly. Not sure how deep you want me to go into details though...

Virtual guests under stress were getting into OOM easily and the OOM
killer was even killing the udev process trying to online the
memory. There was a workaround for the issue added to the hyper-v driver
doing memory add:

hv_mem_hot_add(...) {
...
 add_memory(....);
 wait_for_completion_timeout(..., 5*HZ);
 ...
}

the completion was done by observing for the MEM_ONLINE event. This, of
course, was slowing things down significantly and waiting for a
userspace action in kernel is not a nice thing to have (not speaking
about all other memory adding methods which had the same issue). Just
removing this wait was leading us to the same OOM as the hypervisor was
adding more and more memory and eventually even add_memory() was
failing, udev and other processes were killed,...

With the feature in place we have new memory available right after we do
add_memory(), everything is serialized.

> [...]
>> > Because the udev will run a code which can cope with that - retry if the
>> > error is recoverable or simply report with all the details. Compare that
>> > to crawling the system log to see that something has broken...
>> 
>> I don't know much about udev, but the most common rule to online memory
>> I've met is:
>> 
>> SUBSYSTEM=="memory", ACTION=="add", ATTR{state}=="offline",  ATTR{state}="online"
>> 
>> doesn't do anything smart.
>
> So what? Is there anything that prevents doing something smarter?

Yes, the asynchronous nature of all this stuff. There is no way you can
stop other blocks from being added to the system while you're processing
something in userspace.

-- 
  Vitaly
