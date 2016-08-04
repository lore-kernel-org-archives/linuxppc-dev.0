Return-Path: <york.sun@nxp.com>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20085.outbound.protection.outlook.com [40.107.2.85])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5byw5ShHzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Aug 2016 05:12:08 +1000 (AEST)
From: york sun <york.sun@nxp.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC: "morbidrsa@gmail.com" <morbidrsa@gmail.com>, "oss@buserror.net"
 <oss@buserror.net>, Stuart Yoder <stuart.yoder@nxp.com>, "bp@alien8.de"
 <bp@alien8.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Paul
 Mackerras" <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "Kevin
 Hao" <haokexin@gmail.com>, Yinghai Lu <yinghai@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v3 01/11] arch/powerpc/pci: Fix compiling error for
 mpc85xx_edac
Date: Thu, 4 Aug 2016 23:39:14 +0000
Message-ID: <AM4PR0401MB17322032D82792F305AF63A19A070@AM4PR0401MB1732.eurprd04.prod.outlook.com>
References: <1470351518-22404-1-git-send-email-york.sun@nxp.com>
 <1470351518-22404-2-git-send-email-york.sun@nxp.com>
 <8a1cbb34-1e5a-a7ee-1fc6-e6bd5db34aa1@au1.ibm.com>
Reply-To: york sun <york.sun@nxp.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/04/2016 04:36 PM, Andrew Donnellan wrote:=0A=
> On 05/08/16 08:58, York Sun wrote:=0A=
>> Two symbols are missing if mpc85xx_edac driver is compiled as module.=0A=
>>=0A=
>> Signed-off-by: York Sun <york.sun@nxp.com>=0A=
>=0A=
> Good catch! One comment below.=0A=
>=0A=
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>=0A=
>=0A=
>>  /*=0A=
>>   * Reads the interrupt pin to determine if interrupt is use by card.=0A=
>> @@ -1585,6 +1586,7 @@ int early_find_capability(struct pci_controller *h=
ose, int bus, int devfn,=0A=
>>  {=0A=
>>  	return pci_bus_find_capability(fake_pci_bus(hose, bus), devfn, cap);=
=0A=
>>  }=0A=
>> +EXPORT_SYMBOL(early_find_capability);=0A=
>=0A=
> It'd be nicer for this to be renamed as "pci_early_find_capability" or=0A=
> something like that with a "namespace", I think.=0A=
>=0A=
=0A=
I will rename it if I respin this patch for any reason. Otherwise, I =0A=
will send out another patch to rename it after merging.=0A=
=0A=
York=0A=
=0A=
