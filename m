Return-Path: <B11780@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C92302C044F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2012 05:04:33 +1000 (EST)
Received: from mail169-va3 (localhost [127.0.0.1])	by
 mail169-va3-R.bigfish.com (Postfix) with ESMTP id AB513420493	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2012 19:04:28 +0000 (UTC)
Received: from VA3EHSMHS005.bigfish.com (unknown [10.7.14.239])	by
 mail169-va3.bigfish.com (Postfix) with ESMTP id 6CC8360049	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2012 19:04:26 +0000 (UTC)
From: Gala Kumar-B11780 <B11780@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: Re: [PATCH V5 3/3] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Wed, 8 Aug 2012 19:04:22 +0000
Message-ID: <3F366E73-1EED-4DFE-85B3-F37BCCFFFFB5@freescale.com>
References: <1343988851-884-1-git-send-email-B38951@freescale.com>
 <1343988851-884-4-git-send-email-B38951@freescale.com>
 <501BFC0E.6070708@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A36D0A@039-SN1MPN1-002.039d.mgd.msft.net>
 <501FDE40.1060906@freescale.com>
 <CADRPPNTqnEt3xE8Et1cbK=GwfemgA3-dF7aH2cTNppCddKJ6DA@mail.gmail.com>
 <50213342.8020600@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A518E4@039-SN1MPN1-002.039d.mgd.msft.net>
 <50228CA5.801@freescale.com>
In-Reply-To: <50228CA5.801@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
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

>>>>>>> As I explained before, this has to be done globally, not from the
>>>>>>> probe function, so we can assign a default primary bus if there
>>> isn't any ISA.
>>>>>>> There are bugs in the Linux PPC PCI code relating to not having
>>>>>>> any primary bus.
>>>>>>>=20
>>>>>>> -Scott
>>>>>>=20
>>>>>> In my way of searching ISA you can also assign a default primary bus
>>>>>> in board specific files.
>>>>>=20
>>>>> That was meant for when the board file had an alternate way of
>>>>> searching for the primary bus (e.g. look for i8259), not as a
>>>>> replacement for the mechanism that guarantees there's a primary bus.
>>>>>=20
>>>>> You are causing a regression in the qemu_e500.c platform.
>>>>=20
>>>> Can we fix the qemu device tree to address the problem if we do make
>>>> it a rule to use the ISA node to indicate the primary bus?
>>>=20
>>> No.  There is no ISA, and we're not going to lie and say there is.
>>=20
>> But we can assign a default primary for qemu.
>=20
> Not in the device tree.  What other mechanism do you propose?  And why
> do you want to fix it only for QEMU and not other boards, where things
> happen to work but not as designed?
>=20
> Kumar, can you speak up here as maintainer so we can stop going back and
> forth endlessly?

I'd rather we stick with the code that works for this purpose at this point=
.  That would be Scott's current upstream code.  Lets get the other aspects=
 of this patchset closed (SWIOTLB, conversion to platform driver, PM, etc.)=
.  The primary bus code Scott wrote does NOT need to change at this point.

- k=
