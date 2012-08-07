Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 42E982C0085
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2012 01:24:57 +1000 (EST)
Received: from mail128-co1 (localhost [127.0.0.1])	by
 mail128-co1-R.bigfish.com (Postfix) with ESMTP id 75ADB20515	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2012 15:24:52 +0000 (UTC)
Received: from CO1EHSMHS032.bigfish.com (unknown [10.243.78.241])	by
 mail128-co1.bigfish.com (Postfix) with ESMTP id 3B882A80058	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2012 15:24:50 +0000 (UTC)
Message-ID: <50213342.8020600@freescale.com>
Date: Tue, 7 Aug 2012 10:24:50 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH V5 3/3] powerpc/fsl-pci: Unify pci/pcie initialization code
References: <1343988851-884-1-git-send-email-B38951@freescale.com>
 <1343988851-884-4-git-send-email-B38951@freescale.com>
 <501BFC0E.6070708@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A36D0A@039-SN1MPN1-002.039d.mgd.msft.net>
 <501FDE40.1060906@freescale.com>
 <CADRPPNTqnEt3xE8Et1cbK=GwfemgA3-dF7aH2cTNppCddKJ6DA@mail.gmail.com>
In-Reply-To: <CADRPPNTqnEt3xE8Et1cbK=GwfemgA3-dF7aH2cTNppCddKJ6DA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 Jia Hongtao-B38951 <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/06/2012 11:20 PM, Li Yang wrote:
> On Mon, Aug 6, 2012 at 11:09 PM, Scott Wood <scottwood@freescale.com> wrote:
>> On 08/05/2012 10:07 PM, Jia Hongtao-B38951 wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Wood Scott-B07421
>>>> Sent: Saturday, August 04, 2012 12:28 AM
>>>> To: Jia Hongtao-B38951
>>>> Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Li Yang-
>>>> R58472; Wood Scott-B07421
>>>> Subject: Re: [PATCH V5 3/3] powerpc/fsl-pci: Unify pci/pcie
>>>> initialization code
>>>>
>>>> As I explained before, this has to be done globally, not from the probe
>>>> function, so we can assign a default primary bus if there isn't any ISA.
>>>>  There are bugs in the Linux PPC PCI code relating to not having any
>>>> primary bus.
>>>>
>>>> -Scott
>>>
>>> In my way of searching ISA you can also assign a default primary bus in board
>>> specific files.
>>
>> That was meant for when the board file had an alternate way of searching
>> for the primary bus (e.g. look for i8259), not as a replacement for the
>> mechanism that guarantees there's a primary bus.
>>
>> You are causing a regression in the qemu_e500.c platform.
> 
> Can we fix the qemu device tree to address the problem if we do make
> it a rule to use the ISA node to indicate the primary bus?

No.  There is no ISA, and we're not going to lie and say there is.

I really don't understand what the problem is with leaving the primary
detection code as global.  Either fix the bugs so we don't need a
primary, or accept some "impurity" in the workaround.

-Scott
