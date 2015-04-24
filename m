Return-Path: <thuth@redhat.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AEFA51A0C24
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2015 20:57:19 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 343F4140134
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2015 20:57:19 +1000 (AEST)
Date: Fri, 24 Apr 2015 12:56:57 +0200
From: Thomas Huth <thuth@redhat.com>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] pci-phb: check for the 32-bit overflow
Message-ID: <20150424125657.7e1d5140@thh440s>
In-Reply-To: <871tjaxjwe.fsf@abhimanyu.in.ibm.com>
References: <1429700240-32373-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <20150423154314.595b8439@thh440s>
 <871tjaxjwe.fsf@abhimanyu.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: aik@ozlabs.ru, linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 24 Apr 2015 09:22:33 +0530
Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:

> 
> Hi Thomas,
> 
> Thomas Huth <thuth@redhat.com> writes:
> > Am Wed, 22 Apr 2015 16:27:19 +0530
> > schrieb Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>:
> >
> >> With the addition of 64-bit BARS and increase in the mmio address
> >> space, the code was hitting this limit. The memory of pci devices
> >> across the bridges were not accessible due to which the drivers
> >> failed.
> >> 
> >> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> >> ---
> >>  board-qemu/slof/pci-phb.fs | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/board-qemu/slof/pci-phb.fs b/board-qemu/slof/pci-phb.fs
> >> index 529772f..e307d95 100644
> >> --- a/board-qemu/slof/pci-phb.fs
> >> +++ b/board-qemu/slof/pci-phb.fs
> >> @@ -258,7 +258,8 @@ setup-puid
> >>              decode-64 2 / dup >r                \ Decode and calc size/2
> >>              pci-next-mem @ + dup pci-max-mem !  \ and calc max mem address
> >
> > Could pci-max-mem overflow, too?
> 
> Should not, its only the boundary that was an issue.
> 
> Qemu sends base and size, base + size can be till uint32 max. So for
> example base was 0xC000.0000 and size was 0x4000.0000, we add up base +
> size and put pci-max-mmio as 0x1.0000.0000, which would get programmend
> in the bridge bars: lower limit as 0xC000 and 0x0000 as upper
> limit. And no mmio access were going across the bridge.
> 
> In my testing, I have found one more issue with translate-my-address,
> it does not take care of 64-bit addresses. I have a patch working for
> SLOF, but its breaking the guest kernel booting.
> 
> >
> >>              dup pci-next-mmio !                 \ which is the same as MMIO base
> >> -            r> + pci-max-mmio !                 \ calc max MMIO address
> >> +            r> + FFFFFFFF min pci-max-mmio !    \ calc max MMIO address and
> >> +                                                \ check the 32-bit boundary

Ok, thanks a lot for the example! I think your patch likely works in
practice, but after staring at the code for a while, I think the real
bug is slightly different. If I get the code above right, pci-max-mmio
is normally set to the first address that is _not_ part of the mmio
window anymore, right. Now have a look at pci-bridge-set-mmio-base in
pci-scan.fs:

: pci-bridge-set-mmio-base ( addr -- )
        pci-next-mmio @ 100000 #aligned         \ read the current Value and align to 1MB boundary
        dup 100000 + pci-next-mmio !            \ and write back with 1MB for bridge
        10 rshift                               \ mmio-base reg is only the upper 16 bits
        pci-max-mmio @ FFFF0000 and or          \ and Insert mmio Limit (set it to max)
        swap 20 + rtas-config-l!                \ and write it into the bridge
;

Seems like the pci-max-mmio, i.e. the first address that is not in the
window anymore, is programmed into the memory limit register here - but
according to the pci-to-pci bridge specification, it should be the last
address of the window instead.

So I think the correct fix would be to decrease the pci-max-mmio
value in pci-bridge-set-mmio-base by 1- before programming it into the
limit register (note: in pci-bridge-set-mmio-limit you can find a "1-"
already, so I think this also should be done in
pci-bridge-set-mmio-base, too)

So if you've got some spare minutes, could you please check whether that
would fix the issue, too?

 Thomas
