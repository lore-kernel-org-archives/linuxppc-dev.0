Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6262CB6EF4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 08:03:18 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4F63A5BD.1090207@freescale.com>
Date: Fri, 16 Mar 2012 16:03:10 -0500
Message-Id: <3F0C165C-B018-4751-97FD-557C36FC40B6@kernel.crashing.org>
References: <1328861387-31390-1-git-send-email-shuo.liu@freesacle.com>
 <2F2A8FBF-BD4D-4A53-A293-F5426F8C5BAA@kernel.crashing.org>
 <4F63A5BD.1090207@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, r61911@freescale.com,
 "<shuo.liu@freesacle.com>" <shuo.liu@freesacle.com>,
 Zhao Chenhui <b35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 16, 2012, at 3:42 PM, Scott Wood wrote:

> On 03/16/2012 03:35 PM, Kumar Gala wrote:
>> On Feb 10, 2012, at 2:09 AM, <shuo.liu@freesacle.com> =
<shuo.liu@freesacle.com> wrote:
>>> +static int is_in_pci_mem_space(phys_addr_t addr)
>>> +{
>>> +	struct pci_controller *hose;
>>> +	struct resource *res;
>>> +	int i;
>>> +
>>> +	list_for_each_entry(hose, &hose_list, list_node) {
>>> +		for (i =3D 0; i < 3; i++) {
>>> +			res =3D &hose->mem_resources[i];
>>> +			if ((res->flags & IORESOURCE_MEM) &&
>>> +				addr >=3D res->start && addr <=3D =
res->end)
>>> +				return 1;
>>> +		}
>>> +	}
>>> +	return 0;
>>=20
>> just move this into fsl_pci_mcheck_exception() no need for a separate =
function.
>=20
> A separate function increases readability.
>=20
> -Scott

I'll accept that.

- k=
