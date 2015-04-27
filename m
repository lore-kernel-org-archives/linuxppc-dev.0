Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D48D91A0758
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 14:58:19 +1000 (AEST)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 23191140319
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 14:58:18 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Mon, 27 Apr 2015 10:28:16 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id D396CE004C
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 10:30:56 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3R4wDf7917860
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 10:28:13 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3R4wC5d022653
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 10:28:13 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 1/2] pci-phb: check for the 32-bit overflow
In-Reply-To: <20150424125657.7e1d5140@thh440s>
References: <1429700240-32373-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <20150423154314.595b8439@thh440s> <871tjaxjwe.fsf@abhimanyu.in.ibm.com>
 <20150424125657.7e1d5140@thh440s>
Date: Mon, 27 Apr 2015 10:28:12 +0530
Message-ID: <87sibmqiaj.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: aik@ozlabs.ru, linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thomas Huth <thuth@redhat.com> writes:

> On Fri, 24 Apr 2015 09:22:33 +0530
> Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:
>
>> 
>> Hi Thomas,
>> 
>> Thomas Huth <thuth@redhat.com> writes:
>> > Am Wed, 22 Apr 2015 16:27:19 +0530
>> > schrieb Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>:
>> >
>> >> With the addition of 64-bit BARS and increase in the mmio address
>> >> space, the code was hitting this limit. The memory of pci devices
>> >> across the bridges were not accessible due to which the drivers
>> >> failed.
>> >> 
>> >> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>> >> ---
>> >>  board-qemu/slof/pci-phb.fs | 3 ++-
>> >>  1 file changed, 2 insertions(+), 1 deletion(-)
>> >> 
>> >> diff --git a/board-qemu/slof/pci-phb.fs b/board-qemu/slof/pci-phb.fs
>> >> index 529772f..e307d95 100644
>> >> --- a/board-qemu/slof/pci-phb.fs
>> >> +++ b/board-qemu/slof/pci-phb.fs
>> >> @@ -258,7 +258,8 @@ setup-puid
>> >>              decode-64 2 / dup >r                \ Decode and calc size/2
>> >>              pci-next-mem @ + dup pci-max-mem !  \ and calc max mem address
>> >
>> > Could pci-max-mem overflow, too?
>> 
>> Should not, its only the boundary that was an issue.
>> 
>> Qemu sends base and size, base + size can be till uint32 max. So for
>> example base was 0xC000.0000 and size was 0x4000.0000, we add up base +
>> size and put pci-max-mmio as 0x1.0000.0000, which would get programmend
>> in the bridge bars: lower limit as 0xC000 and 0x0000 as upper
>> limit. And no mmio access were going across the bridge.
>> 
>> In my testing, I have found one more issue with translate-my-address,
>> it does not take care of 64-bit addresses. I have a patch working for
>> SLOF, but its breaking the guest kernel booting.
>> 
>> >
>> >>              dup pci-next-mmio !                 \ which is the same as MMIO base
>> >> -            r> + pci-max-mmio !                 \ calc max MMIO address
>> >> +            r> + FFFFFFFF min pci-max-mmio !    \ calc max MMIO address and
>> >> +                                                \ check the 32-bit boundary
>
> Ok, thanks a lot for the example! I think your patch likely works in
> practice, but after staring at the code for a while, I think the real
> bug is slightly different. If I get the code above right, pci-max-mmio
> is normally set to the first address that is _not_ part of the mmio
> window anymore, right. Now have a look at pci-bridge-set-mmio-base in
> pci-scan.fs:
>
> : pci-bridge-set-mmio-base ( addr -- )
>         pci-next-mmio @ 100000 #aligned         \ read the current Value and align to 1MB boundary
>         dup 100000 + pci-next-mmio !            \ and write back with 1MB for bridge
>         10 rshift                               \ mmio-base reg is only the upper 16 bits
>         pci-max-mmio @ FFFF0000 and or          \ and Insert mmio Limit (set it to max)
>         swap 20 + rtas-config-l!                \ and write it into the bridge
> ;
>
> Seems like the pci-max-mmio, i.e. the first address that is not in the
> window anymore, is programmed into the memory limit register here - but
> according to the pci-to-pci bridge specification, it should be the last
> address of the window instead.
>
> So I think the correct fix would be to decrease the pci-max-mmio
> value in pci-bridge-set-mmio-base by 1- before programming it into the
> limit register (note: in pci-bridge-set-mmio-limit you can find a "1-"
> already, so I think this also should be done in
> pci-bridge-set-mmio-base, too)

Yes, you are right, and because it was being done during probing and
correct values set later on nobody noticed this as an issue. We only
found it when we had an address that was over 32-bit.

>
> So if you've got some spare minutes, could you please check whether that
> would fix the issue, too?

I have tried this fix and works fine, will change this and repost.

Regards,
Nikunj
