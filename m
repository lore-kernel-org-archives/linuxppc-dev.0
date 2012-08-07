Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BD4952C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2012 03:34:24 +1000 (EST)
Subject: Re: [PATCH 5/6] powerpc/fsl-pci: Add pci inbound/outbound PM support
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <50213597.5080600@freescale.com>
Date: Tue, 7 Aug 2012 12:34:11 -0500
Message-Id: <AAB7014A-15DB-4DFD-9301-7343AE4701AF@kernel.crashing.org>
References: <1343125210-16720-1-git-send-email-B38951@freescale.com>
 <1343125210-16720-5-git-send-email-B38951@freescale.com>
 <946C76FC-1F2E-4F09-919F-D5769D29E1A4@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A29E98@039-SN1MPN1-002.039d.mgd.msft.net>
 <BAB2AC7D-90D8-473A-83A0-59BD6F730E62@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A48CF7@039-SN1MPN1-002.039d.mgd.msft.net>
 <50213597.5080600@freescale.com>
To: Scott Wood <scottwood@freescale.com>
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


On Aug 7, 2012, at 10:34 AM, Scott Wood wrote:

> On 08/07/2012 05:11 AM, Jia Hongtao-B38951 wrote:
>>=20
>>=20
>>> -----Original Message-----
>>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>>> Sent: Tuesday, July 31, 2012 9:37 PM
>>> To: Jia Hongtao-B38951
>>> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Li Yang-R58472
>>> Subject: Re: [PATCH 5/6] powerpc/fsl-pci: Add pci inbound/outbound =
PM
>>> support
>>>=20
>>>=20
>>> On Jul 30, 2012, at 1:09 AM, Jia Hongtao-B38951 wrote:
>>>=20
>>>>> -----Original Message-----
>>>>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>>>>> Sent: Friday, July 27, 2012 9:24 PM
>>>>> To: Jia Hongtao-B38951
>>>>> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Li =
Yang-R58472
>>>>> Subject: Re: [PATCH 5/6] powerpc/fsl-pci: Add pci inbound/outbound =
PM
>>>>> support
>>>>>=20
>>>>>=20
>>>>> On Jul 24, 2012, at 5:20 AM, Jia Hongtao wrote:
>>>>>=20
>>>>>> Power supply for PCI inbound/outbound window registers is off =
when
>>>>> system
>>>>>> go to deep-sleep state. We save the values of registers before
>>>>>> suspend and restore to registers after resume.
>>>>>>=20
>>>>>> Signed-off-by: Jiang Yutang <b14898@freescale.com>
>>>>>> Signed-off-by: Jia Hongtao <B38951@freescale.com>
>>>>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>>>>> ---
>>>>>> arch/powerpc/include/asm/pci-bridge.h |    2 +-
>>>>>> arch/powerpc/sysdev/fsl_pci.c         |  121
>>>>> +++++++++++++++++++++++++++++++++
>>>>>> 2 files changed, 122 insertions(+), 1 deletions(-)
>>>>>=20
>>>>> Remind me why we need to save/restore PCI ATMUs, why not just
>>>>> re-parse the device tree to restore?
>>>>>=20
>>>>> - k
>>>>=20
>>>> Save/restore is the more efficient way. Latency of sleep/wakeup is =
one
>>>> of most important features in power management.
>>>>=20
>>>> -Hongtao.
>>>=20
>>> I don't think the time it takes to run through setup_pci_atmu() is =
that
>>> long compared to fsl_pci_resume().
>>>=20
>>> Also, don't you need to setup PCICCSRBAR and do setup_pci_cmd() on =
resume?
>>>=20
>>> - k
>>=20
>> Hi Kumar,
>> I did some tests on P1022DS and found out that PCI_CMD and PCICSRBAR =
is not
>> lost when system in deep sleep. We don't need to save it.
>=20
> How does the PCI code know you're entering deep sleep and not =
hibernation?
>=20
> -Scott
>=20

Also, are you sure PCICSRBAR does not need restoring?  I'd be surprised =
if PCICSRBAR was ok, but the ATMUs where not.

- k
