Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 431D12C0086
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2012 02:02:30 +1000 (EST)
Message-ID: <50228D8B.3040204@freescale.com>
Date: Wed, 8 Aug 2012 11:02:19 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao-B38951 <B38951@freescale.com>
Subject: Re: [PATCH V5 3/3] powerpc/fsl-pci: Unify pci/pcie initialization code
References: <1343988851-884-1-git-send-email-B38951@freescale.com>
 <1343988851-884-4-git-send-email-B38951@freescale.com>
 <501BFC0E.6070708@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A36D0A@039-SN1MPN1-002.039d.mgd.msft.net>
 <501FDE40.1060906@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A45931@039-SN1MPN1-002.039d.mgd.msft.net>
 <50213439.9070806@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A51913@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01A51913@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/08/2012 04:39 AM, Jia Hongtao-B38951 wrote:
> 
> 
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Tuesday, August 07, 2012 11:29 PM
>> To: Jia Hongtao-B38951
>> Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org;
>> galak@kernel.crashing.org; Li Yang-R58472
>> Subject: Re: [PATCH V5 3/3] powerpc/fsl-pci: Unify pci/pcie
>> initialization code
>>
>> On 08/07/2012 03:09 AM, Jia Hongtao-B38951 wrote:
>>> I am really not sure that all boards need primary bus. Could you give
>>> me the link of discussion about primary that you mentioned?
>>
>> https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-June/098586.html
>>
>> -Scott
> 
> 
> It seems in qemu isa_io_base must be non-zero.

In all cases.  It just shows up worse under QEMU because of a different
issue.

> If there is no isa bridge should isa_io_base be non-zero for other boards?

Yes, until the bugs are fixed.

> If not maybe we should fix qemu bug.

If you want to try to make QEMU accept I/O BARs with address zero, go
ahead, but you don't get to assume that someone else will do it, we
still need to be compatible with older QEMUs (this bug is not so severe
that compatibility is unreasonable), and it still doesn't address the
fact that things are not functioning as designed.  IIRC there are some
real hardware PCI cards that don't like getting an address of zero either.

> Or "quick fix" in the link is a workaround.

I think that "quick fix" may have problems if there is a primary bus but
it's not the first one detected.  In any case, any fix or workaround has
to happen before you make changes that rely on it.

-Scott
