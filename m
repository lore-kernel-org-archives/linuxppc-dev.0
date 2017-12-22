Return-Path: <srs0=2rch=ds=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z2yWF5hrRzF07W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 16:59:05 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3z2yWF4gmRz8t8G
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 16:59:05 +1100 (AEDT)
Received: from mail-ua0-x22a.google.com (mail-ua0-x22a.google.com
 [IPv6:2607:f8b0:400c:c08::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3z2yWF13dgz9sBZ
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Dec 2017 16:59:04 +1100 (AEDT)
Received: by mail-ua0-x22a.google.com with SMTP id v22so1229848uaj.1
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Dec 2017 21:59:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87608zpd10.fsf@concordia.ellerman.id.au>
References: <20171220042520.7946-1-mpe@ellerman.id.au>
 <87608zpd10.fsf@concordia.ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Fri, 22 Dec 2017 16:59:02 +1100
Message-ID: <CAKTCnzmL3G4-d6ue03PyDYgFC0ZWSauGeeWPY3M-+9fKS+EAwQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/pseries: Increase memory block size to 1GB on
 radix
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 22, 2017 at 4:06 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>
>> When we're using the Radix MMU we map the kernel linear mapping with
>> 1G pages. That means we must do memory hot remove in blocks of at
>> least that size. Otherwise the linear mapping can end up not mapping
>> all of memory because we've removed part of a 1G region but unmapped
>> the entire 1G region from the linear mapping.
>>
>> Currently on pseries we consult the device tree to find out the the
>> "LMB" (Logical Memory Block) size. This is the unit of memory hotplug
>> communicated to us by the hypervisor, but it does not take into
>> account anything the kernel has done itself, such as use 1G pages for
>> the linear mapping.
>
> This patch failed to survive contact with reality. ie. it doesn't work.
>
> NAK.


I have patches to split the size of a region, I guess the right thing to do is
to split the size of mapping during hotplug. I can look at doing that once I
am back. What broke for you during testing?

Balbir Singh.
