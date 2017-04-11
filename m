Return-Path: <dan.j.williams@intel.com>
Received: from mail-oi0-x22d.google.com (mail-oi0-x22d.google.com
 [IPv6:2607:f8b0:4003:c06::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2b5F4RxtzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 04:22:54 +1000 (AEST)
Received: by mail-oi0-x22d.google.com with SMTP id r203so6464899oib.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 11:22:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170411174233.21902-1-oohall@gmail.com>
References: <20170411174233.21902-1-oohall@gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 11 Apr 2017 11:22:48 -0700
Message-ID: <CAPcyv4hKnP_pddKP8Ve6R0n6sXihPeLCw5seq06iHJ=Hc3yaQA@mail.gmail.com>
Subject: Re: ZONE_DEVICE and pmem API support for powerpc
To: "Oliver O'Halloran" <oohall@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bsingharora@gmail.com,
 arbab@linux.vnet.ibm.com,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 11, 2017 at 10:42 AM, Oliver O'Halloran <oohall@gmail.com> wrote:
> Hi all,
>
> This series adds support for ZONE_DEVICE and the pmem api on powerpc. Namely,
> support for altmaps and the various bits and pieces required for DAX PMD faults.
> The first two patches touch generic mm/ code, but otherwise this is fairly well
> contained in arch/powerpc.
>
> If the nvdimm folks could sanity check this series I'd appreciate it.

Quick feedback: I'm in the process of cleaning up and resubmitting my
patch set to push the pmem api down into the driver directly.

    https://lwn.net/Articles/713064/

I'm also reworking memory hotplug to allow sub-section allocations
which has collided with Michal Hocko's hotplug reworks. It will be
good to have some more eyes on that work to understand the cross-arch
implications.

    https://lkml.org/lkml/2017/3/19/146

> Series is based on next-20170411, but it should apply elsewhere with minor
> fixups to arch_{add|remove}_memory due to conflicts with HMM.  For those
> interested in testing this, there is a driver and matching firmware that carves
> out some system memory for use as an emulated Con Tutto memory card.
>
> Driver: https://github.com/oohal/linux/tree/contutto-next
> Firmware: https://github.com/oohal/skiboot/tree/fake-contutto
>
> Edit core/init.c:686 to control the amount of memory borrowed for the emulated
> device.  I'm keeping the driver out of tree for a until 4.13 since I plan on
> reworking the firmware interface anyway and There's at least one showstopper
> bug.

Is this memory card I/O-cache coherent? I.e. existing dma mapping api
can hand out mappings to it? Just trying to figure out if this the
existing pmem-definition of ZONE_DEVICE or a new one.
