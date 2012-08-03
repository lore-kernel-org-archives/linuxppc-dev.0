Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B7AC62C0084
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2012 02:04:09 +1000 (EST)
Message-ID: <501BF66C.3070107@freescale.com>
Date: Fri, 3 Aug 2012 11:03:56 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao-B38951 <B38951@freescale.com>
Subject: Re: [PATCH V4 3/3] powerpc/fsl-pci: Unify pci/pcie initialization code
References: <1343907741-20589-1-git-send-email-B38951@freescale.com>
 <1343907741-20589-4-git-send-email-B38951@freescale.com>
 <A4B0DB85-7B49-4748-8B94-0E1F1B7B663A@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A35A2F@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01A35A2F@039-SN1MPN1-002.039d.mgd.msft.net>
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

On 08/02/2012 10:39 PM, Jia Hongtao-B38951 wrote:
> 
> 
>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Thursday, August 02, 2012 8:24 PM
>> To: Jia Hongtao-B38951
>> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Li Yang-R58472
>> Subject: Re: [PATCH V4 3/3] powerpc/fsl-pci: Unify pci/pcie
>> initialization code
>>
>> You need to convert all boards to use fsl_pci_init before this patch.
>> Otherwise we'll end up with PCI getting initialized twice on boards.
>>
>> - k
> 
> If we covert all boards with platform driver in this patch PCI will
> be initialized only once without converting all boards to use
> fsl_pci_init first. 

Then we'd have to pick apart core changes from board changes when reviewing.

> If we convert all boards to use fsl_pci_init before this patch and
> convert them to use platform driver again after this patch. Then
> between this patch and next pci will be initialized twice too.

Why?  That one patch should both create the platform driver and remove
the init from fsl_pci_init() -- except things like primary bus detection
which has to happen globally.

-Scott
