Return-Path: <york.sun@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0073.outbound.protection.outlook.com [104.47.2.73])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5dhW48YPzDqhN
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Aug 2016 06:29:47 +1000 (AEST)
From: york sun <york.sun@nxp.com>
To: Michael Ellerman <mpe@ellerman.id.au>, "linux-edac@vger.kernel.org"
 <linux-edac@vger.kernel.org>
CC: "morbidrsa@gmail.com" <morbidrsa@gmail.com>, "oss@buserror.net"
 <oss@buserror.net>, Stuart Yoder <stuart.yoder@nxp.com>, "bp@alien8.de"
 <bp@alien8.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Paul
 Mackerras" <paulus@samba.org>, Kevin Hao <haokexin@gmail.com>, "Andrew
 Donnellan" <andrew.donnellan@au1.ibm.com>, Yinghai Lu <yinghai@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v3 01/11] arch/powerpc/pci: Fix compiling error for
 mpc85xx_edac
Date: Fri, 5 Aug 2016 20:29:40 +0000
Message-ID: <AM4PR0401MB1732CBF31450B03C8F5087D19A180@AM4PR0401MB1732.eurprd04.prod.outlook.com>
References: <1470351518-22404-1-git-send-email-york.sun@nxp.com>
 <1470351518-22404-2-git-send-email-york.sun@nxp.com>
 <877fbvkhi3.fsf@concordia.ellerman.id.au>
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

On 08/04/2016 08:43 PM, Michael Ellerman wrote:=0A=
> York Sun <york.sun@nxp.com> writes:=0A=
>=0A=
>> Two symbols are missing if mpc85xx_edac driver is compiled as module.=0A=
>>=0A=
>> Signed-off-by: York Sun <york.sun@nxp.com>=0A=
>>=0A=
>> ---=0A=
>> Change log=0A=
>>   v3: Change subject tag=0A=
>>   v2: no change=0A=
>>=0A=
>>  arch/powerpc/kernel/pci-common.c | 2 ++=0A=
>>  1 file changed, 2 insertions(+)=0A=
>>=0A=
>> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-=
common.c=0A=
>> index 0f7a60f..86bc484 100644=0A=
>> --- a/arch/powerpc/kernel/pci-common.c=0A=
>> +++ b/arch/powerpc/kernel/pci-common.c=0A=
>> @@ -226,6 +226,7 @@ struct pci_controller* pci_find_hose_for_OF_device(s=
truct device_node* node)=0A=
>>  	}=0A=
>>  	return NULL;=0A=
>>  }=0A=
>> +EXPORT_SYMBOL(pci_find_hose_for_OF_device);=0A=
>>=0A=
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
> Does the driver really need to use these routines? They're meant for use=
=0A=
> early in boot, before PCI is setup.=0A=
>=0A=
> AFAICS this is just a regular driver, so when it's probed the PCI=0A=
> devices should have already been scanned. In which case pci_get_device()=
=0A=
> could work couldn't it? (I see other edac drivers doing that).=0A=
=0A=
I am trying to fix this but need some help. We are dealing with PCIe =0A=
controller here. Does it have a bus number assigned at this point? If =0A=
yes, how can I find it? I seem not able to find out where the =0A=
platform_data is filled as well. Can someone kindly point it out to me?=0A=
=0A=
York=0A=
=0A=
