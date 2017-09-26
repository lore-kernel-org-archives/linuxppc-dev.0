Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y1Z9j4FYwzDsPN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 18:38:49 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8Q8YdgZ066909
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 04:38:45 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2d7frh4apj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 04:38:45 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 26 Sep 2017 04:38:45 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Rob Herring <robh@kernel.org>
Cc: obh+dt@kernel.org, Frank Rowand <frowand.list@gmail.com>,
 "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] drivers: of: static DT reservations incorrectly added to
 dynamic list
In-Reply-To: <CAL_JsqL29j59wJtmOAuD=N7Tccv2rxEMav90yxTyGTfhwHQUsw@mail.gmail.com>
References: <20170914102415.26395-1-stewart@linux.vnet.ibm.com>
 <CAL_JsqL29j59wJtmOAuD=N7Tccv2rxEMav90yxTyGTfhwHQUsw@mail.gmail.com>
Date: Tue, 26 Sep 2017 18:38:37 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87mv5hyhv6.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rob Herring <robh@kernel.org> writes:
> On Thu, Sep 14, 2017 at 5:24 AM, Stewart Smith
> <stewart@linux.vnet.ibm.com> wrote:
>> There are two types of memory reservations firmware can ask the kernel
>> to make in the device tree: static and dynamic.
>> See Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
>>
>> If you have greater than 16 entries in /reserved-memory (as we do on
>> POWER9 systems) you would get this scary looking error message:
>> [    0.000000] OF: reserved mem: not enough space all defined regions.
>>
>> This is harmless if all your reservations are static (which with OPAL on
>> POWER9, they are).
>>
>> It is not harmless if you have any dynamic reservations after the 16th.
>>
>> In the first pass over the fdt to find reservations, the child nodes of
>> /reserved-memory are added to a static array in of_reserved_mem.c so that
>> memory can be reserved in a 2nd pass. The array has 16 entries. This is why,
>> on my dual socket POWER9 system, I get that error 4 times with 20 static
>> reservations.
>>
>> We don't have a problem on ppc though, as in arch/powerpc/kernel/prom.c
>> we look at the new style /reserved-ranges property to do reservations,
>> and this logic was introduced in 0962e8004e974 (well before any powernv
>> system shipped).
>>
>> Google shows up no occurances of that exact error message, so we're probably
>> safe in that no machine that people use has memory not being reserved when
>> it should be.
>>
>> The fix is simple, as there's a different code path for static and dynamic
>> allocations, we just don't add the region to the list if it's static. Since
>> it's a static *OR* dynamic region, this is a perfectly valid thing to do
>> (although I have not checked every real world device tree on the planet
>> for this condition)
>
> If the region is dynamic (i.e. no reg prop), then we bail from
> __reserved_mem_reserve_reg. So wouldn't this change make the list be
> empty always?

We get the dynamic node in __fdt_scan_reserved_mem() rather
than__reserved_mem_reserve_reg():


static int __init __reserved_mem_reserve_reg(unsigned long node,
                                             const char *uname)
{
...
        prop = of_get_flat_dt_prop(node, "reg", &len);
        if (!prop)
                return -ENOENT;
...
}

static int __init __fdt_scan_reserved_mem(unsigned long node, const char *uname,
                                          int depth, void *data)
{
....
....
        err = __reserved_mem_reserve_reg(node, uname);
        if (err == -ENOENT && of_get_flat_dt_prop(node, "size", NULL))
                fdt_reserved_mem_save_node(node, uname, 0, 0);

        /* scan next node */
        return 0;
}

So that should capture the dynamic reservations (as they're the ones
with the size property) to be handled by fdt_init_reserved_mem() later
in boot.

> Won't we have problems with lookups for devices with a "memory-region"
> property if static allocations are not in the list?

Ahh yep, I see the issue.

The array is being used for two things: reserving the memory and looking it
up during device init (seems like only used on ARM, which is why it
Worked For Me(TM) on POWER :)

It looks a bit more involved making that work, although not impossible.

> I'm inclined to just make the safe and easy change of increasing the
> array to 32 entries. That should be enough for everyone (TM).

that would certainly solve my immediate problem :)

(of course, given a CPU generation or two I'm sure we'd hit it again)

I'll send a patch that does that, and can asynchronously work on a patch
that addresses the device lookup of memory region problem (although
that'll be fairly down on my list of things to look at).

-- 
Stewart Smith
OPAL Architect, IBM.
