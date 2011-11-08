Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 63BFA1007D3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 03:54:59 +1100 (EST)
Received: from mail69-ch1 (localhost.localdomain [127.0.0.1])	by
 mail69-ch1-R.bigfish.com (Postfix) with ESMTP id 10D0B1770259	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 16:54:44 +0000 (UTC)
Received: from CH1EHSMHS011.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.244])	by mail69-ch1.bigfish.com (Postfix) with ESMTP id
 E439521804C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 16:54:13 +0000 (UTC)
Message-ID: <4EB95EBC.8010808@freescale.com>
Date: Tue, 8 Nov 2011 10:54:20 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zang Roy-R61911 <r61911@freescale.com>
Subject: Re: [PATCH] powerpc/p1023: set IRQ[4:6, 11] to high level sensitive
 for PCIe
References: <1320654778-3294-1-git-send-email-tie-fei.zang@freescale.com>
 <4EB826F1.50402@freescale.com>
 <2239AC579C7D3646A720227A37E0268120D5C5@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <2239AC579C7D3646A720227A37E0268120D5C5@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/07/2011 11:51 PM, Zang Roy-R61911 wrote:
> 
> 
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Tuesday, November 08, 2011 2:44 AM
>> To: Zang Roy-R61911
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Subject: Re: [PATCH] powerpc/p1023: set IRQ[4:6, 11] to high level sensitive for
>> PCIe
>>
>> On 11/07/2011 02:32 AM, Roy Zang wrote:
>>> P1023 external IRQ[4:6, 11] do not pin out, but the interrupts are
>>> shared with PCIe controller.
>>> The silicon internally ties the interrupts to L, so change the
>>> IRQ[4:6,11] to high level sensitive for PCIe.
>>
>> Some extra commentary on why this works would be nice.
> I do not know what kind of extra commentary you request. 

Just a note that there's magic to allow the PCIe block to output these
interrupts as either active-high or active-low, depending on how they're
configured at the mpic.

> IRQ 4,5,6, 11 are internally tie to low by silicon. To use these interrupts for PCIe, they need to set high level sensitive.
> It is clear enough for this patch.

It's odd enough that I felt the need to go reading through the docs to
see why such a thing would work at all.

>> The manual says:
>>
>>> If a PCI Express INTx interrupt is being used, then the PIC must be configured
>> so that external interrupts
>>> are level-sensitive (EIVPRn[S] = 1).
> That is true for all FSL powerpc silicon with PCIe controller beside P1023.

Sure, my point was more that it didn't say anything there about how to
configure EIVPRn[P].

-Scott
