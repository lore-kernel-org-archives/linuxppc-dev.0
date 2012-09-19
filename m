Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D91062C007D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2012 01:49:51 +1000 (EST)
Subject: Re: [PATCH][V4] powerpc/fsl-pci: Add pci inbound/outbound PM support
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01AAA4E8@039-SN1MPN1-002.039d.mgd.msft.net>
Date: Wed, 19 Sep 2012 10:49:20 -0500
Message-Id: <8086D08B-62B7-4838-8DB6-0F6158DE581A@kernel.crashing.org>
References: <1347934234-18223-1-git-send-email-B38951@freescale.com>
 <86ADF4ED-B84C-4560-8781-D9FA4486D854@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01AAA35A@039-SN1MPN1-002.039d.mgd.msft.net>,
 <36119932-E4BF-4DF6-8D33-C9A832883272@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01AAA4E8@039-SN1MPN1-002.039d.mgd.msft.net>
To: Jia Hongtao-B38951 <B38951@freescale.com>
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

>>> On Sep 17, 2012, at 9:10 PM, Jia Hongtao wrote:
>>>=20
>>>> Power supply for PCI inbound/outbound window registers is off when
>>>> system go to deep-sleep state. We save the values of registers =
before
>>>> suspend and restore to registers after resume.
>>>>=20
>>>> Signed-off-by: Jiang Yutang <b14898@freescale.com>
>>>> Signed-off-by: Jia Hongtao <B38951@freescale.com>
>>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>>> ---
>>>> Changes for V4:
>>>> We just rebase the patch upon following patch:
>>>> powerpc/fsl-pci: Unify pci/pcie initialization code
>>>>=20
>>>> arch/powerpc/include/asm/pci-bridge.h |    2 +-
>>>> arch/powerpc/sysdev/fsl_pci.c         |  121
>>> +++++++++++++++++++++++++++++++++
>>>> 2 files changed, 122 insertions(+), 1 deletions(-)
>>>=20
>>> Did you ever compare this to just re-parsing device tree method?
>>>=20
>>> - k
>>=20
>> I tested the re-parsing way by using setup_pci_atmu() when resume.
>> And I found out that re-parsing will *change* outbound IO translation
>> address regitster.
>>=20
>> It seems that in the first bootup, after setup_atmu()
>> pcibios_setup_phb_resources() may update hose->io_resource, but atmu
>> is not updated according to the new hose->io_resource value.
>> In resume from sleep setup_atmu() will reset atmu according to the
>> new hose->io_resource value. So the setup_atmu() will cause different
>> result on outbound IO register between first bootup and resume from
>> sleep.
>>=20
>> So... There's a possibility that in the first bootup atmu is not =
setup
>> properly.
>=20
> [Are you seeing this happen in your testing?  If so its a bug we need =
to look at fixing.]
>=20
> Yes, I see this in my testing.
> Also PCIe ethernet card works well after resuming from sleep in both =
save/restore
> and re-parsing way. (Maybe PCIe ethernet card don't need outbound IO =
resource)
> So, I guess the result of re-parsing (actually it's re-setup) is right =
and ATMU is not setup
> properly at the first bootup.

Are you seeing the following message - "PCI: I/O resource not set for =
host bridge" ?

Trying to understand why you'd hit the reassignment of io_resource.

- k

>=20
>=20
>=20
>>=20
>> Anyway, if setup_pci_atmu() at resume is functionally right then =
re-parsing
>> is a good way for PM. I also test the latency of re-parsing and =
save/restore,
>> both way are acceptable.
>>=20
>>=20
>> - Hongtao.
>=20
>=20
