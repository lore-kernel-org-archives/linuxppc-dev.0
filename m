Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xk72Q5DDBzDqZ9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 15:23:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Brian King <brking@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, "dougmill\@us.ibm.com" <dougmill@us.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Turn on SCSI_AACRAID in powernv_defconfig
In-Reply-To: <5011affa-e820-1362-2af2-3507f8aeb914@linux.vnet.ibm.com>
References: <1503899802-13248-1-git-send-email-mpe@ellerman.id.au>
 <72f7e609-58b9-32dc-4090-fdbd97d0c924@linux.vnet.ibm.com>
 <87h8wq1uvv.fsf@concordia.ellerman.id.au>
 <58487ce7-aea1-39c1-b9c8-cd8435e493e0@linux.vnet.ibm.com>
 <87shg91fgc.fsf@concordia.ellerman.id.au> <87y3q0hxtm.fsf@linux.vnet.ibm.com>
 <877exjud52.fsf@concordia.ellerman.id.au>
 <5011affa-e820-1362-2af2-3507f8aeb914@linux.vnet.ibm.com>
Date: Fri, 01 Sep 2017 15:23:58 +1000
Message-ID: <87mv6f56vl.fsf@concordia.ellerman.id.au>
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

Brian King <brking@linux.vnet.ibm.com> writes:

> On 08/31/2017 07:37 AM, Michael Ellerman wrote:
>> Stewart Smith <stewart@linux.vnet.ibm.com> writes:
>> 
>>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>>> OK. So maybe when the petitboot kernel moves up to 4.14 they may want to
>>>> flip it back to being a module.
>>>
>>> Yeah. We tend to keep all RAID adapters as modules because they almost
>>> all uniquely try to undo all boot time optimization done by anybody,
>>> anywhere, ever.
>> 
>> Yes I know what you mean. I am thinking of one In ParticulaR.
>
> Ouch. In all fairness over the life of ipr I've done a couple things to
> improve initialization time.

Sorry that wasn't meant as a dig at you, more the hardware. It might
have needed a smiley :)

> 1. On a PowerVM machine, the ipr boot device should not get reset between
>    the FCODE driver and the Linux driver, so init is extremely fast. If its
>    a non-boot device, then you'll have to wait for the firmware to initialize
>    on those adapters.

Yeah I don't see any problem on my LPARs, which just have a single IPR
for the boot device. Init takes ~1 second.

> 2. On a bare metal machine, if you set ipr.fast_reboot=1 on the skiboot
>    kernel, then we should also avoid resetting the ipr adapter, so ipr
>    init on the kernel being kexec booted from skiboot should be extremely fast. 

OK, I didn't know that was an option, so that might help.

> ...
> If you've got cases where ipr init is taking a long time, I'd be
> interested to know what scenarios are the most annoying to see if there
> is any opportunity to improve.

Yeah booting bare metal is where I see it (not using ipr.fast_reboot).

eg booting a Tuleta:

  [    1.517752] ipr: IBM Power RAID SCSI Device Driver version: 2.6.4 (March 14, 2017)
  ...
  [    1.519884] ipr 0001:08:00.0: Initializing IOA.
  [    1.519941] scsi host0: IBM 0 Storage Adapter
  [   25.695744] ipr 0001:08:00.0: Starting IOA initialization sequence.
  ...
  [   26.329614] sd 0:2:0:0: [sda] Spinning up disk...
  [   26.329752] sd 0:2:1:0: [sdb] Spinning up disk...
  [   26.329990] sd 0:2:2:0: [sdc] Spinning up disk...
  [   26.330065] sd 0:2:3:0: [sdd] Spinning up disk...
  ...
  [   26.349962] sr 0:0:6:0: Attached scsi generic sg15 type 5


Those 24 seconds are a bit of a shame. I assume we're just waiting for
the card firmware to come up?

I don't think there's much we can do in the kernel, PCI has just come
up, so we can't start the IPR init earlier. And the rest of the boot
only takes ~3 seconds, so even if we did everything else in parallel,
we'd still be waiting ~21 seconds for IPR.

cheers
