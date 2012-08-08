Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 23BCA2C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2012 07:04:31 +1000 (EST)
Message-ID: <5022D44E.8040102@freescale.com>
Date: Wed, 8 Aug 2012 16:04:14 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/6] powerpc/fsl-pci: Add pci inbound/outbound PM support
References: <1343125210-16720-1-git-send-email-B38951@freescale.com>
 <1343125210-16720-5-git-send-email-B38951@freescale.com>
 <946C76FC-1F2E-4F09-919F-D5769D29E1A4@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A29E98@039-SN1MPN1-002.039d.mgd.msft.net>
 <BAB2AC7D-90D8-473A-83A0-59BD6F730E62@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A48CF7@039-SN1MPN1-002.039d.mgd.msft.net>
 <50213597.5080600@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A51933@039-SN1MPN1-002.039d.mgd.msft.net>
 <1C95474C-B59D-4635-8FA9-B76165E177CD@kernel.crashing.org>
In-Reply-To: <1C95474C-B59D-4635-8FA9-B76165E177CD@kernel.crashing.org>
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

On 08/08/2012 07:46 AM, Kumar Gala wrote:
>>>>>>>
>>>>>>> On Jul 24, 2012, at 5:20 AM, Jia Hongtao wrote:
>>>>>>>
>>>>>>>> Power supply for PCI inbound/outbound window registers is off when
>>>>>>> system
>>>>>>>> go to deep-sleep state. We save the values of registers before
>>>>>>>> suspend and restore to registers after resume.
>>>>>>>>
>>>>>>>> Signed-off-by: Jiang Yutang <b14898@freescale.com>
>>>>>>>> Signed-off-by: Jia Hongtao <B38951@freescale.com>
>>>>>>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>>>>>>> ---
>>>>>>>> arch/powerpc/include/asm/pci-bridge.h |    2 +-
>>>>>>>> arch/powerpc/sysdev/fsl_pci.c         |  121
>>>>>>> +++++++++++++++++++++++++++++++++
>>>>>>>> 2 files changed, 122 insertions(+), 1 deletions(-)
>>>>>>>
>>>>>>> Remind me why we need to save/restore PCI ATMUs, why not just
>>>>>>> re-parse the device tree to restore?
>>>>>>>
>>>>>>> - k
>>>>>>
>>>>>> Save/restore is the more efficient way. Latency of sleep/wakeup is
>>>>>> one of most important features in power management.
>>>>>>
>>>>>> -Hongtao.
>>>>>
>>>>> I don't think the time it takes to run through setup_pci_atmu() is
>>>>> that long compared to fsl_pci_resume().
>>>>>
>>>>> Also, don't you need to setup PCICCSRBAR and do setup_pci_cmd() on
>>> resume?
>>>>>
>>>>> - k
>>>>
>>>> Hi Kumar,
>>>> I did some tests on P1022DS and found out that PCI_CMD and PCICSRBAR
>>>> is not lost when system in deep sleep. We don't need to save it.

How do you know you're not just getting lucky?  Maybe it only survives
deep sleep up to a certain duration, or under other specific circumstances.

Can you find anywhere that documents what state will be retained during
deep sleep, or ask an appropriate hardware designer?

-Scott
