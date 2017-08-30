Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xj2m66FM7zDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 21:07:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Brian King <brking@linux.vnet.ibm.com>,
 "dougmill\@us.ibm.com" <dougmill@us.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Turn on SCSI_AACRAID in powernv_defconfig
In-Reply-To: <58487ce7-aea1-39c1-b9c8-cd8435e493e0@linux.vnet.ibm.com>
References: <1503899802-13248-1-git-send-email-mpe@ellerman.id.au>
 <72f7e609-58b9-32dc-4090-fdbd97d0c924@linux.vnet.ibm.com>
 <87h8wq1uvv.fsf@concordia.ellerman.id.au>
 <58487ce7-aea1-39c1-b9c8-cd8435e493e0@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 21:07:47 +1000
Message-ID: <87shg91fgc.fsf@concordia.ellerman.id.au>
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

"Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:

> On 08/29/2017 08:22 AM, Michael Ellerman wrote:
>> "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:
>> 
>>> On 08/28/2017 02:56 AM, Michael Ellerman wrote:
>>>> Some Power9 boxes will have this adapter installed, so add it to the
>>>> defconfig so we can boot on those machines without an initrd.
>>>
>>> Michael, not sure if this affects Petitboot (I know it has its own
>>> default config files), but in the past we had some issues with this
>>> driver and it's nice to have the possibility to blacklist it.
>> 
>> Why we were black listing it?
>
> Basically for the same reason you want it built-in - debug purposes heheh
>
> In fact, this driver takes some time in its initialization process, so
> if my rootfs is not under it, to speedup my boot-time I could blacklist
> it; also, to debug the aacraid driver we could blacklist it in Petitboot
> and debug on distro (easier to build kernels there), since the issue
> could be in first probe only (or be affected by kexec-out from Petitboot).
>
> Anyway, since make it a module will harm your workflow, I agree built-in
> is the best option!

OK. So maybe when the petitboot kernel moves up to 4.14 they may want to
flip it back to being a module.

I think the majority of machines that have one of these adapters will be
using it for their root disk, so I think the slow initialisation is just
something we have to suffer.

cheers
