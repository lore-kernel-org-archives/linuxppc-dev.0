Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 837621A0259
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 11:04:56 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3B19C14014D
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2014 11:04:56 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 26 Nov 2014 10:04:56 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 498B42CE802D
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2014 11:04:53 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAQ04qE638011072
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2014 11:04:53 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAQ04qQ7017898
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2014 11:04:52 +1100
Date: Wed, 26 Nov 2014 11:04:51 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v1 0/5] powerpc/pci: PCI slot unified reset
Message-ID: <20141126000451.GA21271@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1416868727-5814-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1416956093.5089.1.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416956093.5089.1.camel@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 26, 2014 at 09:54:53AM +1100, Benjamin Herrenschmidt wrote:
>On Tue, 2014-11-25 at 09:38 +1100, Gavin Shan wrote:
>> The patchset corresponds to skiboot changes, which manages PCI slots
>> in a unified way: OPAL APIs used to do slot reset, power management,
>> presence status retrival. The patchset shouldn't be merged before
>> the OPAL firmware counterpart is merged.
>
>This doesn't work. We need to have both backward and forward
>compatibility.
>
>IE. New kernels must work with old OPAL and vice-versa.
>

Yes, it's known issue as you remind me yesterday. I'll fix it in next
revision, from skiboot (I guess it would be official name to be used
now) side.

>> The kernel changes have been split into 2 parts: (A) Use the unified
>> PCI slot reset OPAL API - this patchset; (B) Changes to rpaphp.ko to
>> support PCI slot hotplug via sysfs entries for PowerPC PowerNV platform.
>
>I don't think we should be using rpaphp... we should be creating our new
>backend, there is almost no commonalities between RPA/PAPR and OPAL.
>

Ok. I'll create powernv-php as you suggested in another thread. Thank you
for your time on this.

Thanks,
Gavin

>> This patchset affects EEH, PCI reset logics, which is used mainly by
>> VFIO. A couple of cases have been tested out on P7/P8 boxes and looks
>> good: EEH on PowerNV, EEH support for guest, PCI passthrou.
>> 
>> Gavin Shan (5):
>>   powerpc/powernv: Use PCI slot reset infrastructure
>>   powerpc/powernv: Refactor ioda_eeh_reset()
>>   powerpc/powernv: Avoid do complete reset for twice
>>   powerpc/powernv: Issue fundamental reset if required
>>   powerpc/powernv: Drop opal_pci_reinit()
>> 
>>  arch/powerpc/include/asm/eeh.h                 |   2 +-
>>  arch/powerpc/include/asm/opal.h                |  31 +---
>>  arch/powerpc/kernel/eeh_pe.c                   |   3 -
>>  arch/powerpc/platforms/powernv/eeh-ioda.c      | 230 ++++++++++++++-----------
>>  arch/powerpc/platforms/powernv/eeh-powernv.c   |  24 +--
>>  arch/powerpc/platforms/powernv/opal-wrappers.S |   1 -
>>  arch/powerpc/platforms/powernv/pci-ioda.c      |   5 +-
>>  arch/powerpc/platforms/pseries/eeh_pseries.c   |   3 +-
>>  8 files changed, 139 insertions(+), 160 deletions(-)
>> 
>> Thanks,
>> Gavin
>
>
