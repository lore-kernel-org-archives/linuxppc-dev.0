Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x242.google.com (mail-ua0-x242.google.com
 [IPv6:2607:f8b0:400c:c08::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xprcD6NjgzDrbq
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Sep 2017 07:51:08 +1000 (AEST)
Received: by mail-ua0-x242.google.com with SMTP id s15so1075857uag.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Sep 2017 14:51:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504768881.12628.23.camel@kernel.crashing.org>
References: <20170907050551.4632-1-anton@ozlabs.org>
 <ab33351f-1d52-2e55-8aeb-32813ca52e94@linux.vnet.ibm.com>
 <20170907151741.41ee33a8@kryten>
 <1504768881.12628.23.camel@kernel.crashing.org>
From: Balbir Singh <bsingharora@gmail.com>
Date: Sat, 9 Sep 2017 07:51:05 +1000
Message-ID: <CAKTCnzk_O9Oacr+y08=PBLZpXX3-tZbdGoT6b-iwxb1zZphAVA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/powernv: Increase memory block size to 1GB on
 radix
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Anton Blanchard <anton@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Reza Arbab <arbab@linux.vnet.ibm.com>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Cyril Bur <cyrilbur@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 7, 2017 at 5:21 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Thu, 2017-09-07 at 15:17 +1000, Anton Blanchard wrote:
>> Hi,
>>
>> > There is a similar issue being worked on w.r.t pseries.
>> >
>> > https://lkml.kernel.org/r/1502357028-27465-1-git-send-email-bharata@linux.vnet.ibm.com
>> >
>> > The question is should we map these regions ? ie, we need to tell the
>> > kernel memory region that we would like to hot unplug later so that
>> > we avoid doing kernel allocations from that. If we do that, then we
>> > can possibly map them via 2M size ?
>>
>> But all of memory on PowerNV should be able to be hot unplugged, so

For this ideally we need movable mappings for the regions we intend
to hot-unplug - no? Otherwise, there is no guarantee that hot-unplug
will work

>> there are two options as I see it - either increase the memory block
>> size, or map everything with 2MB pages.
>
> Or be smarter and map with 1G when blocks of 1G are available and break
> down to 2M where necessary, it shouldn't be too hard.
>

strict_rwx patches added helpers to do this

Balbir Singh.
