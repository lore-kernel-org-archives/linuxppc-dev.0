Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A67262C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2012 23:37:32 +1000 (EST)
Subject: Re: [PATCH V3 1/5] powerpc/fsl-pci: Unify pci/pcie initialization code
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CADRPPNThb68v9h6Dy4qOxv2pwYLg=Zvuk_6+jM4HUxDbuzfhAQ@mail.gmail.com>
Date: Tue, 31 Jul 2012 08:37:30 -0500
Message-Id: <0080192C-3C13-40DA-BE8A-4FCE67F79E04@kernel.crashing.org>
References: <1343305827-26734-1-git-send-email-B38951@freescale.com>
 <ACC8975F-CA31-4AA0-9824-4C3F6C70CD45@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A289D8@039-SN1MPN1-002.039d.mgd.msft.net>
 <5012F8FD.8030905@freescale.com>
 <A2F0976D-CF30-4A20-8697-0CD1830DD54A@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A29FEF@039-SN1MPN1-002.039d.mgd.msft.net>
 <536EC8A2-60D9-4991-8D38-092C4C8B698F@kernel.crashing.org>
 <CADRPPNThb68v9h6Dy4qOxv2pwYLg=Zvuk_6+jM4HUxDbuzfhAQ@mail.gmail.com>
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


On Jul 31, 2012, at 2:21 AM, Li Yang wrote:

> On Mon, Jul 30, 2012 at 10:46 PM, Kumar Gala =
<galak@kernel.crashing.org> wrote:
>>=20
>> On Jul 30, 2012, at 3:26 AM, Jia Hongtao-B38951 wrote:
>>=20
>>>=20
>>>=20
>>>> -----Original Message-----
>>>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>>>> Sent: Saturday, July 28, 2012 5:17 AM
>>>> To: Wood Scott-B07421
>>>> Cc: Jia Hongtao-B38951; linuxppc-dev@lists.ozlabs.org; Wood =
Scott-B07421;
>>>> Li Yang-R58472
>>>> Subject: Re: [PATCH V3 1/5] powerpc/fsl-pci: Unify pci/pcie
>>>> initialization code
>>>>=20
>>>>=20
>>>> On Jul 27, 2012, at 3:24 PM, Scott Wood wrote:
>>>>=20
>>>>> On 07/27/2012 05:10 AM, Jia Hongtao-B38951 wrote:
>>>>>> Hi kumar,
>>>>>>=20
>>>>>> I know "duplicate code from pci_process_bridge_OF_ranges()" is
>>>>>> hard to accept but "refactor the code to have a shared function"
>>>>>> is knotty. Actually this is the reason I didn't do the refactor.
>>>>>=20
>>>>> Maybe we should keep doing the init early?  We could still have a
>>>>> platform device for the PM stuff, but some init would be done =
before
>>>> probe.
>>>>>=20
>>>>> Another possibility is to try to handle swiotlb init later -- =
possibly
>>>>> by reserving memory for it if the platform indicates it's a =
possibility
>>>>> that it will be needed, then freeing the memory if it's not =
needed.
>>>>>=20
>>>>> -Scott
>>>>=20
>>>> I think the first option seems reasonable.  Can we leave =
fsl_pci_init()
>>>> as we now have it and just have the platform driver deal with PM =
restore
>>>> via calling setup_pci_atmu() [probably need to update =
setup_pci_atmu to
>>>> handle restore case, but seems like minor changes]
>>>>=20
>>>> - k
>>>>=20
>>>=20
>>>=20
>>> I think the second option is better if it's hard to decouple swiotlb
>>> determination from pci init. I believe the better architecture that
>>> PCI init in probe function of platform driver will bring us =
considerable
>>> advantage. I really like to keep the completion of pci controller
>>> platform driver not only for PM support but also for pci init.
>>>=20
>>> -Hongtao.
>>>=20
>>=20
>> Shifting of swiotlb init has a lot more issues.  Why do we need to do =
the PCI init in probe?
>=20
> The ordering issues are introduced by swiotlb.  And the ideal way is
> to solve the problem within swiotlb instead of changing PCI to
> workaround it.  Take the implementation of x86 as reference it's
> possible to be addressed bu allocating first and free later approach.
>=20
> It is common sense that the initialization of a device is in the probe
> function of the driver of the device.  And the change will provide
> better unification of PCI controller code.  The PCI controller is
> generic enough not to be taken care of at the platform area.
>=20
> Leo

Than lets look at going with that approach.. Be careful with impact on =
other users of swiotlb on PPC, I believe one 44x board uses swiotlb.

- k=
