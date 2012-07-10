Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1FEFD2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 01:49:49 +1000 (EST)
Subject: Re: [PATCH] PCI: Add pcie_irq=other to enable non MSI/INTx interrupt
 for port service driver
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4FFC4AD0.3070201@freescale.com>
Date: Tue, 10 Jul 2012 10:49:42 -0500
Message-Id: <009D8F85-2036-47C1-A19E-3E8D3EB8462F@kernel.crashing.org>
References: <1341830970-12779-1-git-send-email-Shengzhou.Liu@freescale.com>
 <4FFB0927.7080406@freescale.com>
 <3F453DDFF675A64A89321A1F3528102176B4BF@039-SN1MPN1-003.039d.mgd.msft.net>
 <4FFC4AD0.3070201@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
 Liu Shengzhou-B36685 <B36685@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 10, 2012, at 10:31 AM, Scott Wood wrote:

> On 07/10/2012 01:13 AM, Liu Shengzhou-B36685 wrote:
>>=20
>>=20
>>> -----Original Message-----
>>> From: Wood Scott-B07421
>>> Sent: Tuesday, July 10, 2012 12:39 AM
>>> To: Liu Shengzhou-B36685
>>> Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; linuxppc-
>>> dev@lists.ozlabs.org
>>> Subject: Re: [PATCH] PCI: Add pcie_irq=3Dother to enable non =
MSI/INTx interrupt
>>> for port service driver
>>>=20
>>> On 07/09/2012 05:49 AM, Shengzhou Liu wrote:
>>>> On some platforms, in RC mode, root port has neither MSI/MSI-X nor
>>>> INTx interrupt generated, which are available only in EP mode on =
those
>>> platform.
>>>> In this case, we try to use other interrupt if supported (i.e. =
there
>>>> is the shared error interrupt on platform P1010, P3041, P4080, etc) =
to
>>>> have AER, Hot-plug, etc, services to work.
>>>>=20
>>>> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
>>>> ---
>>>> Documentation/kernel-parameters.txt |    4 ++++
>>>> drivers/pci/pcie/portdrv_core.c     |   19 +++++++++++++++++++
>>>> 2 files changed, 23 insertions(+), 0 deletions(-)
>>>>=20
>>>> diff --git a/Documentation/kernel-parameters.txt
>>>> b/Documentation/kernel-parameters.txt
>>>> index a92c5eb..af97c81 100644
>>>> --- a/Documentation/kernel-parameters.txt
>>>> +++ b/Documentation/kernel-parameters.txt
>>>> @@ -2218,6 +2218,10 @@ bytes respectively. Such letter suffixes can =
also be
>>> entirely omitted.
>>>> 		nomsi	Do not use MSI for native PCIe PME signaling =
(this makes
>>>> 			all PCIe root ports use INTx for all services).
>>>>=20
>>>> +	pcie_irq=3D	[PCIE] Native PCIe root port interrupt options:
>>>> +		other	Try to use other interrupt when root port has
>>>> +			neither MSI/MSI-X nor INTx support.
>>>=20
>>> Why does the user need to specify this?  Shouldn't this be a matter =
of
>>> communication between kernel internals?
>>>=20
>>=20
>> The "other interrupt" appears a non-standard interrupt way compared =
to MSI/MSI-X and INTx in point of PCIe spec.
>=20
> It still shouldn't be the user's responsibility to pass this in.

I agree with Scott, this should be done in board code or as a PCI fixup, =
not as a command line arg.

>> The intent of specifying this is to have an intervention and
>> confirmation manually to avoid causing unexpected issue on some
>> unknown platforms.
>>=20
>> I'm glad to remove the specified kernel parameter if it would be =
accepted upstream.
>=20
> Hopefully someone will comment if there is harm in doing this
> unconditionally.  If there is, then we should handle this via a quirk =
or
> similar mechanism.
>=20
> -Scott

If we need to do it via quirk, wondering if we can use the pci_dev_flags =
and set the flag in a quirk.

- k=
