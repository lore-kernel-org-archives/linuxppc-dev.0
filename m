Return-Path: <B38951@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A84DE2C0080
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2012 01:41:50 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH][V4] powerpc/fsl-pci: Add pci inbound/outbound PM support
Date: Wed, 19 Sep 2012 15:41:41 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01AAA4E8@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1347934234-18223-1-git-send-email-B38951@freescale.com>
 <86ADF4ED-B84C-4560-8781-D9FA4486D854@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01AAA35A@039-SN1MPN1-002.039d.mgd.msft.net>,
 <36119932-E4BF-4DF6-8D33-C9A832883272@kernel.crashing.org>
In-Reply-To: <36119932-E4BF-4DF6-8D33-C9A832883272@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
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

=0A=
________________________________________=0A=
From: Kumar Gala [galak@kernel.crashing.org]=0A=
Sent: Wednesday, September 19, 2012 10:27 PM=0A=
To: Jia Hongtao-B38951=0A=
Cc: linuxppc-dev@lists.ozlabs.org; Li Yang-R58472; Wood Scott-B07421=0A=
Subject: Re: [PATCH][V4] powerpc/fsl-pci: Add pci inbound/outbound PM suppo=
rt=0A=
=0A=
On Sep 19, 2012, at 2:10 AM, Jia Hongtao-B38951 wrote:=0A=
=0A=
>=0A=
>=0A=
>> -----Original Message-----=0A=
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]=0A=
>> Sent: Tuesday, September 18, 2012 1:04 PM=0A=
>> To: Jia Hongtao-B38951=0A=
>> Cc: linuxppc-dev@lists.ozlabs.org; Li Yang-R58472; Wood Scott-B07421=0A=
>> Subject: Re: [PATCH][V4] powerpc/fsl-pci: Add pci inbound/outbound PM=0A=
>> support=0A=
>>=0A=
>>=0A=
>> On Sep 17, 2012, at 9:10 PM, Jia Hongtao wrote:=0A=
>>=0A=
>>> Power supply for PCI inbound/outbound window registers is off when=0A=
>>> system go to deep-sleep state. We save the values of registers before=
=0A=
>>> suspend and restore to registers after resume.=0A=
>>>=0A=
>>> Signed-off-by: Jiang Yutang <b14898@freescale.com>=0A=
>>> Signed-off-by: Jia Hongtao <B38951@freescale.com>=0A=
>>> Signed-off-by: Li Yang <leoli@freescale.com>=0A=
>>> ---=0A=
>>> Changes for V4:=0A=
>>> We just rebase the patch upon following patch:=0A=
>>> powerpc/fsl-pci: Unify pci/pcie initialization code=0A=
>>>=0A=
>>> arch/powerpc/include/asm/pci-bridge.h |    2 +-=0A=
>>> arch/powerpc/sysdev/fsl_pci.c         |  121=0A=
>> +++++++++++++++++++++++++++++++++=0A=
>>> 2 files changed, 122 insertions(+), 1 deletions(-)=0A=
>>=0A=
>> Did you ever compare this to just re-parsing device tree method?=0A=
>>=0A=
>> - k=0A=
>=0A=
> I tested the re-parsing way by using setup_pci_atmu() when resume.=0A=
> And I found out that re-parsing will *change* outbound IO translation=0A=
> address regitster.=0A=
>=0A=
> It seems that in the first bootup, after setup_atmu()=0A=
> pcibios_setup_phb_resources() may update hose->io_resource, but atmu=0A=
> is not updated according to the new hose->io_resource value.=0A=
> In resume from sleep setup_atmu() will reset atmu according to the=0A=
> new hose->io_resource value. So the setup_atmu() will cause different=0A=
> result on outbound IO register between first bootup and resume from=0A=
> sleep.=0A=
>=0A=
> So... There's a possibility that in the first bootup atmu is not setup=0A=
> properly.=0A=
=0A=
[Are you seeing this happen in your testing?  If so its a bug we need to lo=
ok at fixing.]=0A=
=0A=
Yes, I see this in my testing.=0A=
Also PCIe ethernet card works well after resuming from sleep in both save/r=
estore=0A=
and re-parsing way. (Maybe PCIe ethernet card don't need outbound IO resour=
ce)=0A=
So, I guess the result of re-parsing (actually it's re-setup) is right and =
ATMU is not setup=0A=
properly at the first bootup.=0A=
=0A=
=0A=
=0A=
>=0A=
> Anyway, if setup_pci_atmu() at resume is functionally right then re-parsi=
ng=0A=
> is a good way for PM. I also test the latency of re-parsing and save/rest=
ore,=0A=
> both way are acceptable.=0A=
>=0A=
>=0A=
> - Hongtao.=0A=
=0A=
=0A=
