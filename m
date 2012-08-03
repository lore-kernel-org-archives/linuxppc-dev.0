Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 26BCB2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2012 02:09:38 +1000 (EST)
Message-ID: <501BF7BC.1030208@freescale.com>
Date: Fri, 3 Aug 2012 11:09:32 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao-B38951 <B38951@freescale.com>
Subject: Re: [PATCH V4 3/3] powerpc/fsl-pci: Unify pci/pcie initialization code
References: <1343907741-20589-1-git-send-email-B38951@freescale.com>
 <1343907741-20589-4-git-send-email-B38951@freescale.com>
 <501AE0A2.4010809@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A359AF@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01A359AF@039-SN1MPN1-002.039d.mgd.msft.net>
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

On 08/02/2012 09:20 PM, Jia Hongtao-B38951 wrote:
> 
> 
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Friday, August 03, 2012 4:19 AM
>> To: Jia Hongtao-B38951
>> Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Wood Scott-
>> B07421; Li Yang-R58472
>> Subject: Re: [PATCH V4 3/3] powerpc/fsl-pci: Unify pci/pcie
>> initialization code
>>
>> Why are you eliminating the uli lookup?  We don't want to call
>> uli_exclude_device on boards that don't have a uli.
>>
>> -Scott
> 
> I found out that all 85xx_ds boards (mpc8572ds, mpc8544ds, p2020ds) have
> ULI.

Perhaps all boards currently handled by this file do, but it's not true
for all mpc85xx_ds boards.  I think we could handle mpc8536ds here if we
didn't hardcode the uli assumption.  Not critical, but would be nice to
make this more device tree driven.

p1022ds OTOH is weird enough that it deserves its own board file.

> Also in platform driver fsl_pci_primary is determined at arch_initcall
> which means at the stage of board_setup_arch fsl_pci_primary is not ready.

You could export the primary detection function so that boards can call
it early if they want.

-Scott
