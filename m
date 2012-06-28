Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D3A801007D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2012 02:32:00 +1000 (EST)
Message-ID: <4FEC86CC.90307@freescale.com>
Date: Thu, 28 Jun 2012 11:31:08 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao-B38951 <B38951@freescale.com>
Subject: Re: [PATCH 0/3] powerpc/fsl: PCI refactoring and QEMU paravirt
 platform
References: <20120627234851.GA9071@tyr.buserror.net>
 <412C8208B4A0464FA894C5F0C278CD5D01A10EAB@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01A10EAB@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>, "agraf@suse.de" <agraf@suse.de>,
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

On 06/27/2012 11:06 PM, Jia Hongtao-B38951 wrote:
> 
> 
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Thursday, June 28, 2012 7:49 AM
>> To: galak@kernel.crashing.org
>> Cc: agraf@suse.de; linuxppc-dev@lists.ozlabs.org; Jia Hongtao-B38951
>> Subject: [PATCH 0/3] powerpc/fsl: PCI refactoring and QEMU paravirt
>> platform
>>
>> The QEMU stuff is related to the PCI refactoring because currently
>> we have a hard time selecting a primary bus under QEMU, and also because
>> the generic qemu e500 platform wants a full list of FSL PCI compatibles
>> to check.
>>
> 
> It seems that not all primary bus has "isa" node like 8541 and 8555.

Do those boards (it's the boards that matter, not chips...) have legacy
ISA?  If they do, and it's not in the device tree, then we should fix
the device tree for consistency, but also retain some sort of hack to
remain compatible with old device trees.

A board can refrain from using the new common infrastructure if it has a
good reason to.

> Without PM support for pci controllers I totally agree with this refactoring
> for pci init. But in linux mechanism PM ops should be registered to a driver.
> Do you have any ideas to add PM support for pci controllers under this patchset?

This isn't meant to be instead of making it a platform device.  It's
just meant to get us away from board-specific code and primary-bus
hardcoding now, rather than once we sort out all the issues with
platform devices.

-Scott
