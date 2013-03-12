Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C072C2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 07:46:16 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: Add platform_device declaration to fsl_pci.h
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01C11ED4@039-SN1MPN1-003.039d.mgd.msft.net>
Date: Tue, 12 Mar 2013 15:46:09 -0500
Message-Id: <1A66AF08-B77F-419C-B742-87EE61DBB11F@kernel.crashing.org>
References: <1362386409-15907-1-git-send-email-B38951@freescale.com>
 <CC45B9DD-7BB6-4E88-B5A0-F3E7A30608A7@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01C11ED4@039-SN1MPN1-003.039d.mgd.msft.net>
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


On Mar 10, 2013, at 9:36 PM, Jia Hongtao-B38951 wrote:

>=20
>=20
>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Saturday, March 09, 2013 4:38 AM
>> To: Jia Hongtao-B38951
>> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Li Yang-R58472
>> Subject: Re: [PATCH] powerpc/85xx: Add platform_device declaration to
>> fsl_pci.h
>>=20
>>=20
>> On Mar 4, 2013, at 2:40 AM, Jia Hongtao wrote:
>>=20
>>> mpc85xx_pci_err_probe(struct platform_device *op) need =
platform_device
>>> declaration for definition. Otherwise, it will cause compile error =
if
>>> any files including fsl_pci.h without declaration of =
platform_device.
>>>=20
>>> Signed-off-by: Jia Hongtao <B38951@freescale.com>
>>> ---
>>> arch/powerpc/sysdev/fsl_pci.h |    2 ++
>>> 1 files changed, 2 insertions(+), 0 deletions(-)
>>>=20
>>=20
>> Where does the compile error show up?
>>=20
>> - k
>=20
> The function mpc85xx_pci_err_probe(struct platform_device *op) need
> *platform_device* declaration so <linux/platform_device.h> must be
> included.=20
>=20
> For now there is no compile error occurred just because the file that
> need fsl_pci.h happened to include <linux/platform_device.h> already.
>=20
> If not the compile error log will be like this:
> "
> In file included from arch/powerpc/kernel/traps.c:62:0:
> arch/powerpc/sysdev/fsl_pci.h:108:34: error: 'struct platform_device' =
declared inside parameter list
> arch/powerpc/sysdev/fsl_pci.h:108:34: error: its scope is only this =
definition or declaration, which is probably not what you want
> "
>=20
> You mean I have to show the compile error log in patch description?

Not necessarily, I'm just trying to decide if we should include =
<linux/platform_device.h> or just do:

struct platform_device;

near the top of fsl_pci.h.

>=20
> Thanks.
> -Hongtao.
>=20
>>=20
>>> diff --git a/arch/powerpc/sysdev/fsl_pci.h
>>> b/arch/powerpc/sysdev/fsl_pci.h index c495c00..df66721 100644
>>> --- a/arch/powerpc/sysdev/fsl_pci.h
>>> +++ b/arch/powerpc/sysdev/fsl_pci.h
>>> @@ -14,6 +14,8 @@
>>> #ifndef __POWERPC_FSL_PCI_H
>>> #define __POWERPC_FSL_PCI_H
>>>=20
>>> +#include <linux/platform_device.h>
>>> +
>>> #define PCIE_LTSSM	0x0404		/* PCIE Link Training and
>> Status */
>>> #define PCIE_LTSSM_L0	0x16		/* L0 state */
>>> #define PCIE_IP_REV_2_2		0x02080202 /* PCIE IP block =
version
>> Rev2.2 */
>>> --
>>> 1.7.5.1
>>>=20
>>=20
>=20
