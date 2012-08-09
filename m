Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 22F572C00E2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2012 23:10:35 +1000 (EST)
Subject: Re: [PATCH 5/6] powerpc/fsl-pci: Add pci inbound/outbound PM support
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CADRPPNRT3i-cmAtTmCzi4Rt6ohPpvk1U0vNHZZQqbCGeCJ5Cag@mail.gmail.com>
Date: Thu, 9 Aug 2012 08:08:23 -0500
Message-Id: <90115399-5F52-44AC-99F7-86738AABDA66@kernel.crashing.org>
References: <1343125210-16720-1-git-send-email-B38951@freescale.com>
 <1343125210-16720-5-git-send-email-B38951@freescale.com>
 <946C76FC-1F2E-4F09-919F-D5769D29E1A4@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A29E98@039-SN1MPN1-002.039d.mgd.msft.net>
 <BAB2AC7D-90D8-473A-83A0-59BD6F730E62@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A48CF7@039-SN1MPN1-002.039d.mgd.msft.net>
 <50213597.5080600@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A51933@039-SN1MPN1-002.039d.mgd.msft.net>
 <1C95474C-B59D-4635-8FA9-B76165E177CD@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A51DA2@039-SN1MPN1-002.039d.mgd.msft.net>
 <CADRPPNRT3i-cmAtTmCzi4Rt6ohPpvk1U0vNHZZQqbCGeCJ5Cag@mail.gmail.com>
To: Li Yang <leoli@freescale.com>
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


On Aug 9, 2012, at 12:05 AM, Li Yang wrote:

> On Thu, Aug 9, 2012 at 10:52 AM, Jia Hongtao-B38951
> <B38951@freescale.com> wrote:
>>=20
>>=20
>>> -----Original Message-----
>>> From: Linuxppc-dev [mailto:linuxppc-dev-
>>> bounces+b38951=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Kumar =
Gala
>>> Sent: Wednesday, August 08, 2012 8:47 PM
>>> To: Jia Hongtao-B38951
>>> Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org; Li Yang-R58472
>>> Subject: Re: [PATCH 5/6] powerpc/fsl-pci: Add pci inbound/outbound =
PM
>>> support
>>>=20
>>>>>>>>>=20
>>>>>>>>> On Jul 24, 2012, at 5:20 AM, Jia Hongtao wrote:
>>>>>>>>>=20
>>>>>>>>>> Power supply for PCI inbound/outbound window registers is off
>>>>>>>>>> when
>>>>>>>>> system
>>>>>>>>>> go to deep-sleep state. We save the values of registers =
before
>>>>>>>>>> suspend and restore to registers after resume.
>>>>>>>>>>=20
>>>>>>>>>> Signed-off-by: Jiang Yutang <b14898@freescale.com>
>>>>>>>>>> Signed-off-by: Jia Hongtao <B38951@freescale.com>
>>>>>>>>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>>>>>>>>> ---
>>>>>>>>>> arch/powerpc/include/asm/pci-bridge.h |    2 +-
>>>>>>>>>> arch/powerpc/sysdev/fsl_pci.c         |  121
>>>>>>>>> +++++++++++++++++++++++++++++++++
>>>>>>>>>> 2 files changed, 122 insertions(+), 1 deletions(-)
>>>>>>>>>=20
>>>>>>>>> Remind me why we need to save/restore PCI ATMUs, why not just
>>>>>>>>> re-parse the device tree to restore?
>>>>>>>>>=20
>>>>>>>>> - k
>>>>>>>>=20
>>>>>>>> Save/restore is the more efficient way. Latency of sleep/wakeup =
is
>>>>>>>> one of most important features in power management.
>>>>>>>>=20
>>>>>>>> -Hongtao.
>>>>>>>=20
>>>>>>> I don't think the time it takes to run through setup_pci_atmu() =
is
>>>>>>> that long compared to fsl_pci_resume().
>>>>>>>=20
>>>>>>> Also, don't you need to setup PCICCSRBAR and do setup_pci_cmd() =
on
>>>>> resume?
>>>>>>>=20
>>>>>>> - k
>>>>>>=20
>>>>>> Hi Kumar,
>>>>>> I did some tests on P1022DS and found out that PCI_CMD and =
PCICSRBAR
>>>>>> is not lost when system in deep sleep. We don't need to save it.
>>>>>=20
>>>>> How does the PCI code know you're entering deep sleep and not
>>> hibernation?
>>>>>=20
>>>>> -Scott
>>>>=20
>>>> When system come back from hibernation PCI will be initialized =
again.
>>>> So no need to save PCI_CMD and PEXCSRBAR.
>>>>=20
>>>> -Hongtao.
>>>>=20
>>>=20
>>> What do you mean PCI will be initialized again?  What code path are =
you
>>> talking about that would set PCI_CMD & PEXCSRBAR?
>>>=20
>>> - k
>>=20
>>=20
>> In hibernation mode:
>>=20
>> When system come back from hibernation kernel will start up again.
>> Before loading hibernation image PCI initialization has already done.
>> Some other hardware also re-init again.
>=20
> In current Linux implementation, restoring from hibernation image is
> using late initcall.  By that time, all the platform devices are
> already initialized like a fresh boot.
>=20
> - Leo

I ask against, what specific code path (I'd like a call trace) would =
cause PCI_CMD and PEXCSRBAR to be set in the wakeup case?

- k=
